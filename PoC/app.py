import os
import time
from pathlib import Path

import anthropic
import duckdb
import openai
from dotenv import load_dotenv
from fastapi import FastAPI, HTTPException, Query
from fastapi.responses import RedirectResponse
from pydantic import BaseModel, Field

CARTELLA = Path(__file__).resolve().parent
DATABASE = CARTELLA / 'acme.duckdb'

load_dotenv(CARTELLA / '.env')

MODELLO_ANTHROPIC = os.getenv('ANTHROPIC_MODEL') or 'claude-opus-5-5'
MODELLO_OPENAI = os.getenv('OPENAI_MODEL') or 'gpt-5-mini'
TIMEOUT = 60.0

FATTURATO_NETTO = '''
    SUM(COALESCE(f.ven_lordo, 0)
        - (COALESCE(f.ven_incondizionato, 0) + COALESCE(f.ven_offerta, 0)
           + COALESCE(f.ven_canvass, 0) + COALESCE(f.ven_finanziari, 0))
        - (COALESCE(f.res_lordo, 0)
           - (COALESCE(f.res_incondizionato, 0) + COALESCE(f.res_offerta, 0)
              + COALESCE(f.res_canvass, 0) + COALESCE(f.res_finanziari, 0))))
'''

app = FastAPI(title='PoC SmartDashboard', version='0.1.0')


class Prova(BaseModel):
    domanda: str = Field(default='Rispondi soltanto con la parola: funziona', max_length=500)


def connessione():
    if not DATABASE.exists():
        raise HTTPException(503, 'Database non trovato: eseguire prima crea_database.py')
    return duckdb.connect(str(DATABASE), read_only=True)


def chiave(nome):
    valore = os.getenv(nome)
    if not valore:
        raise HTTPException(503, f'{nome} mancante nel file .env')
    return valore


def client_anthropic():
    return anthropic.Anthropic(api_key=chiave('ANTHROPIC_API_KEY'), timeout=TIMEOUT)


def client_openai():
    return openai.OpenAI(api_key=chiave('OPENAI_API_KEY'), timeout=TIMEOUT)


def errore_provider(provider, errore):
    if isinstance(errore, (anthropic.AuthenticationError, openai.AuthenticationError)):
        tipo = 'chiave non valida'
    elif isinstance(errore, (anthropic.PermissionDeniedError, openai.PermissionDeniedError)):
        tipo = 'permesso negato'
    elif isinstance(errore, (anthropic.NotFoundError, openai.NotFoundError)):
        tipo = 'modello non disponibile'
    elif isinstance(errore, (anthropic.RateLimitError, openai.RateLimitError)):
        tipo = 'limite di richieste o credito esaurito'
    elif isinstance(errore, (anthropic.APIStatusError, openai.APIStatusError)):
        tipo = 'errore del provider'
    elif isinstance(errore, (anthropic.APITimeoutError, openai.APITimeoutError)):
        tipo = 'tempo scaduto'
    else:
        tipo = 'connessione non riuscita'
    return HTTPException(502, {
        'provider': provider,
        'errore': tipo,
        'stato_http': getattr(errore, 'status_code', None),
    })


ERRORI_PROVIDER = (anthropic.APIError, openai.APIError)


@app.get('/', include_in_schema=False)
def inizio():
    return RedirectResponse('/docs')


@app.get('/salute')
def salute():
    return {
        'stato': 'ok',
        'database': DATABASE.exists(),
        'chiavi': {
            'anthropic': bool(os.getenv('ANTHROPIC_API_KEY')),
            'openai': bool(os.getenv('OPENAI_API_KEY')),
        },
    }


@app.get('/db/tabelle')
def tabelle():
    con = connessione()
    try:
        elenco = con.execute(
            "SELECT schema_name, table_name FROM duckdb_tables() ORDER BY schema_name, table_name"
        ).fetchall()
        return [
            {
                'schema': schema,
                'tabella': tabella,
                'righe': con.execute(f'SELECT count(*) FROM {schema}.{tabella}').fetchone()[0],
            }
            for schema, tabella in elenco
        ]
    finally:
        con.close()


@app.get('/db/fatturato')
def fatturato(anno: int = Query(2025, ge=2010, le=2026)):
    con = connessione()
    try:
        righe = con.execute(f'''
            SELECT cn.des_cod AS canale, ROUND({FATTURATO_NETTO}, 2) AS fatturato_netto
            FROM dwh.fact_fatturato f
            JOIN dwh.dim_calendario_custom cal ON f.id_anno_mese = cal.id
            JOIN dwh.dim_tabgen cn ON f.sk_id_canale = cn.sk_id AND cn.tipo_tab = 'CN'
            WHERE cal.anno = ?
            GROUP BY cn.des_cod
            ORDER BY fatturato_netto DESC
        ''', [anno]).fetchall()
    finally:
        con.close()
    if not righe:
        raise HTTPException(404, f'Nessun dato per il {anno}')
    return {
        'anno': anno,
        'totale': round(sum(valore for _, valore in righe), 2),
        'canali': [{'canale': canale, 'fatturato_netto': valore} for canale, valore in righe],
    }


@app.get('/llm/anthropic/modelli')
def modelli_anthropic():
    try:
        return {'modelli': [modello.id for modello in client_anthropic().models.list(limit=100)]}
    except ERRORI_PROVIDER as errore:
        raise errore_provider('anthropic', errore)


@app.get('/llm/openai/modelli')
def modelli_openai():
    try:
        return {'modelli': sorted(modello.id for modello in client_openai().models.list())}
    except ERRORI_PROVIDER as errore:
        raise errore_provider('openai', errore)


@app.post('/llm/anthropic/prova')
def prova_anthropic(prova: Prova = Prova()):
    client = client_anthropic()
    inizio = time.perf_counter()
    try:
        risposta = client.beta.messages.create(
            model=MODELLO_ANTHROPIC,
            max_tokens=1024,
            output_config={'effort': 'low'},
            betas=['server-side-fallback-2026-07-01'],
            fallbacks='default',
            messages=[{'role': 'user', 'content': prova.domanda}],
        )
    except ERRORI_PROVIDER as errore:
        raise errore_provider('anthropic', errore)
    testo = ''.join(blocco.text for blocco in risposta.content if blocco.type == 'text')
    return {
        'provider': 'anthropic',
        'modello': risposta.model,
        'risposta': testo,
        'motivo_fine': risposta.stop_reason,
        'secondi': round(time.perf_counter() - inizio, 2),
        'token': {
            'input': risposta.usage.input_tokens,
            'output': risposta.usage.output_tokens,
        },
    }


@app.post('/llm/openai/prova')
def prova_openai(prova: Prova = Prova()):
    client = client_openai()
    inizio = time.perf_counter()
    try:
        risposta = client.responses.create(
            model=MODELLO_OPENAI,
            input=prova.domanda,
            max_output_tokens=1024,
        )
    except ERRORI_PROVIDER as errore:
        raise errore_provider('openai', errore)
    return {
        'provider': 'openai',
        'modello': risposta.model,
        'risposta': risposta.output_text,
        'motivo_fine': risposta.status,
        'secondi': round(time.perf_counter() - inizio, 2),
        'token': {
            'input': risposta.usage.input_tokens,
            'output': risposta.usage.output_tokens,
        },
    }
