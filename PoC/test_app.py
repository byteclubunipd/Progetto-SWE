from types import SimpleNamespace

import anthropic
import httpx2
import openai
import pytest
from fastapi.testclient import TestClient

import app as modulo

client = TestClient(modulo.app)


def errore_http(classe, stato):
    risposta = httpx2.Response(stato, request=httpx2.Request('POST', 'https://api.example.com'))
    return classe('errore simulato', response=risposta, body=None)


class FintoAnthropic:
    def __init__(self, errore=None):
        def crea(**parametri):
            if errore:
                raise errore
            return SimpleNamespace(
                model=parametri['model'],
                content=[SimpleNamespace(type='text', text='funziona')],
                stop_reason='end_turn',
                usage=SimpleNamespace(input_tokens=10, output_tokens=2),
            )
        self.beta = SimpleNamespace(messages=SimpleNamespace(create=crea))
        self.models = SimpleNamespace(list=lambda **_: [SimpleNamespace(id='claude-opus-5-5')])


class FintoOpenAI:
    def __init__(self, errore=None):
        def crea(**parametri):
            if errore:
                raise errore
            return SimpleNamespace(
                model=parametri['model'],
                output_text='funziona',
                status='completed',
                usage=SimpleNamespace(input_tokens=10, output_tokens=2),
            )
        self.responses = SimpleNamespace(create=crea)
        self.models = SimpleNamespace(list=lambda: [SimpleNamespace(id='gpt-5-mini')])


@pytest.fixture
def chiavi(monkeypatch):
    monkeypatch.setenv('ANTHROPIC_API_KEY', 'chiave-finta')
    monkeypatch.setenv('OPENAI_API_KEY', 'chiave-finta')


def test_indirizzo_base_porta_alla_documentazione():
    risposta = client.get('/', follow_redirects=False)
    assert risposta.status_code == 307
    assert risposta.headers['location'] == '/docs'


def test_salute_non_mostra_le_chiavi(chiavi):
    risposta = client.get('/salute')
    assert risposta.status_code == 200
    assert risposta.json()['chiavi'] == {'anthropic': True, 'openai': True}
    assert 'chiave-finta' not in risposta.text


@pytest.mark.parametrize('provider, finto', [('anthropic', FintoAnthropic), ('openai', FintoOpenAI)])
def test_prova_riuscita(monkeypatch, chiavi, provider, finto):
    monkeypatch.setattr(modulo, f'client_{provider}', lambda: finto())
    risposta = client.post(f'/llm/{provider}/prova', json={'domanda': 'ciao'})
    assert risposta.status_code == 200
    dati = risposta.json()
    assert dati['risposta'] == 'funziona'
    assert dati['token'] == {'input': 10, 'output': 2}


@pytest.mark.parametrize('provider, finto', [('anthropic', FintoAnthropic), ('openai', FintoOpenAI)])
def test_elenco_modelli(monkeypatch, chiavi, provider, finto):
    monkeypatch.setattr(modulo, f'client_{provider}', lambda: finto())
    risposta = client.get(f'/llm/{provider}/modelli')
    assert risposta.status_code == 200
    assert len(risposta.json()['modelli']) == 1


@pytest.mark.parametrize('provider, sdk, finto', [
    ('anthropic', anthropic, FintoAnthropic),
    ('openai', openai, FintoOpenAI),
])
@pytest.mark.parametrize('classe, stato, atteso', [
    ('AuthenticationError', 401, 'chiave non valida'),
    ('NotFoundError', 404, 'modello non disponibile'),
    ('RateLimitError', 429, 'limite di richieste o credito esaurito'),
    ('InternalServerError', 500, 'errore del provider'),
])
def test_errori_del_provider(monkeypatch, chiavi, provider, sdk, finto, classe, stato, atteso):
    errore = errore_http(getattr(sdk, classe), stato)
    monkeypatch.setattr(modulo, f'client_{provider}', lambda: finto(errore))
    risposta = client.post(f'/llm/{provider}/prova')
    assert risposta.status_code == 502
    assert risposta.json()['detail'] == {'provider': provider, 'errore': atteso, 'stato_http': stato}


@pytest.mark.parametrize('provider, variabile', [
    ('anthropic', 'ANTHROPIC_API_KEY'),
    ('openai', 'OPENAI_API_KEY'),
])
def test_chiave_mancante(monkeypatch, provider, variabile):
    monkeypatch.delenv(variabile, raising=False)
    risposta = client.post(f'/llm/{provider}/prova')
    assert risposta.status_code == 503
    assert variabile in risposta.json()['detail']


def test_domanda_troppo_lunga(chiavi):
    risposta = client.post('/llm/anthropic/prova', json={'domanda': 'x' * 501})
    assert risposta.status_code == 422


richiede_database = pytest.mark.skipif(
    not modulo.DATABASE.exists(), reason='Database non trovato: eseguire prima crea_database.py'
)


@richiede_database
def test_tabelle():
    risposta = client.get('/db/tabelle')
    assert risposta.status_code == 200
    assert len(risposta.json()) == 20


@richiede_database
def test_fatturato_per_canale():
    risposta = client.get('/db/fatturato', params={'anno': 2025})
    assert risposta.status_code == 200
    dati = risposta.json()
    assert dati['canali']
    assert dati['totale'] == pytest.approx(sum(c['fatturato_netto'] for c in dati['canali']))


def test_fatturato_anno_fuori_intervallo():
    assert client.get('/db/fatturato', params={'anno': 1999}).status_code == 422
