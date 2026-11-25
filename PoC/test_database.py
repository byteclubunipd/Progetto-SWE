from pathlib import Path

import duckdb
import pytest

DATABASE = Path(__file__).resolve().parent / 'acme.duckdb'

RIGHE_ATTESE = {
    'raw.stattab': 10_250_000,
    'raw.stattabagg': 8_955_126,
    'raw.anaart': 1_292,
    'raw.anacli': 4_225,
    'raw.clsart': 613,
    'raw.tabgen': 186,
    'raw.tabage': 85,
    'raw.tabcare': 20,
    'raw.tabprov': 149,
    'raw.tabzone': 21,
    'dwh.fact_fatturato': 10_250_000,
    'dwh.dim_anaart': 1_293,
    'dwh.dim_anacli': 4_226,
    'dwh.dim_calendario_custom': 7_671,
    'dwh.dim_clsart': 617,
    'dwh.dim_tabage': 86,
    'dwh.dim_tabcare': 21,
    'dwh.dim_tabgen': 193,
    'dwh.dim_tabprov': 150,
    'dwh.dim_tabzone': 22,
}

CHIAVI_FATTO = [
    ('id_anno_mese', 'dim_calendario_custom', 'id', None),
    ('sk_id_articolo', 'dim_anaart', 'sk_id', None),
    ('sk_id_punto_consegna', 'dim_anacli', 'sk_id', None),
    ('sk_id_intestatario', 'dim_anacli', 'sk_id', None),
    ('sk_id_gruppo', 'dim_anacli', 'sk_id', None),
    ('sk_id_insegna', 'dim_anacli', 'sk_id', None),
    ('sk_id_gruppo_acquisto', 'dim_anacli', 'sk_id', None),
    ('sk_id_agente', 'dim_tabage', 'sk_id', None),
    ('sk_id_capo_area', 'dim_tabcare', 'sk_id', None),
    ('sk_id_zona_vend', 'dim_tabzone', 'sk_id', None),
    ('sk_id_area_vendita', 'dim_tabgen', 'sk_id', 'AV'),
    ('sk_id_canale', 'dim_tabgen', 'sk_id', 'CN'),
    ('sk_id_mercato', 'dim_tabgen', 'sk_id', 'ME'),
    ('sk_id_deposito', 'dim_tabgen', 'sk_id', 'DE'),
]

FATTURATO_NETTO = '''
    SUM(ven_lordo - (ven_incondizionato + ven_offerta + ven_canvass + ven_finanziari)
        - (res_lordo - (res_incondizionato + res_offerta + res_canvass + res_finanziari)))
'''


@pytest.fixture(scope='module')
def con():
    if not DATABASE.exists():
        pytest.skip('Database non trovato: eseguire prima crea_database.py')
    connessione = duckdb.connect(str(DATABASE), read_only=True)
    yield connessione
    connessione.close()


@pytest.mark.parametrize('tabella, attese', RIGHE_ATTESE.items())
def test_righe_come_da_documentazione(con, tabella, attese):
    assert con.execute(f'SELECT count(*) FROM {tabella}').fetchone()[0] == attese


def test_codici_mantengono_zeri_iniziali(con):
    tipo = con.execute(
        "SELECT data_type FROM information_schema.columns "
        "WHERE table_schema = 'raw' AND table_name = 'tabage' AND column_name = 'cod_age'"
    ).fetchone()[0]
    assert tipo == 'VARCHAR'
    assert con.execute("SELECT count(*) FROM raw.tabage WHERE cod_age = '001'").fetchone()[0] == 1


@pytest.mark.parametrize('colonna, dimensione, chiave, tipo_tab', CHIAVI_FATTO)
def test_chiavi_del_fatto_trovano_la_dimensione(con, colonna, dimensione, chiave, tipo_tab):
    filtro = f"AND d.tipo_tab = '{tipo_tab}'" if tipo_tab else ''
    orfane = con.execute(f'''
        SELECT count(*) FROM dwh.fact_fatturato f
        WHERE NOT EXISTS (
            SELECT 1 FROM dwh.{dimensione} d WHERE d.{chiave} = f.{colonna} {filtro}
        )
    ''').fetchone()[0]
    assert orfane == 0


def test_fatturato_netto_coerente_tra_raw_e_dwh(con):
    raw = dict(con.execute(f'''
        SELECT anno, {FATTURATO_NETTO} FROM raw.stattab GROUP BY anno
    ''').fetchall())
    dwh = dict(con.execute(f'''
        SELECT cal.anno, {FATTURATO_NETTO}
        FROM dwh.fact_fatturato f
        JOIN dwh.dim_calendario_custom cal ON f.id_anno_mese = cal.id
        GROUP BY cal.anno
    ''').fetchall())
    assert raw.keys() == dwh.keys()
    for anno, valore in raw.items():
        assert dwh[anno] == pytest.approx(valore, rel=1e-9), anno
