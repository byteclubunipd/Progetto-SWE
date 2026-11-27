import argparse
import re
import sys
import time
from pathlib import Path

import duckdb

CARTELLA = Path(__file__).resolve().parent

SCHEMI = {
    'raw': ('acmeOLAP', '01_create_acmeOLAP.sql'),
    'dwh': ('acmeOLAP_DWH', '02_create_acmeOLAP_DWH.sql'),
}

TIPI = {
    'int': 'INTEGER',
    'smallint': 'SMALLINT',
    'float': 'DOUBLE',
    'varchar': 'VARCHAR',
    'char': 'VARCHAR',
}


def leggi_tabelle(file_sql):
    testo = file_sql.read_text(encoding='utf-8')
    tabelle = {}
    for nome, corpo in re.findall(r'CREATE TABLE dbo\.(\w+) \((.*?)\n\);', testo, re.S):
        colonne = []
        for colonna, tipo in re.findall(r'\[(\w+)\] (\w+)', corpo):
            if tipo.lower() not in TIPI:
                raise ValueError(f'Tipo {tipo} non gestito: {nome}.{colonna}')
            colonne.append((colonna, TIPI[tipo.lower()]))
        tabelle[nome] = colonne
    if not tabelle:
        raise ValueError(f'Nessuna tabella trovata in {file_sql}')
    return tabelle


def controlla_intestazione(file_csv, colonne):
    with file_csv.open(encoding='utf-8') as file:
        intestazione = file.readline().strip().split(';')
    attese = [colonna for colonna, _ in colonne]
    if intestazione != attese:
        raise ValueError(f'Le colonne di {file_csv.name} non corrispondono allo schema SQL')


def carica_tabella(con, schema, tabella, colonne, file_csv):
    controlla_intestazione(file_csv, colonne)
    definizione = ', '.join(f'{colonna} {tipo}' for colonna, tipo in colonne)
    con.execute(f'CREATE TABLE {schema}.{tabella} ({definizione})')
    percorso = str(file_csv).replace("'", "''")
    con.execute(
        f"COPY {schema}.{tabella} FROM '{percorso}' "
        "(DELIMITER ';', HEADER, QUOTE '\"', ALLOW_QUOTED_NULLS false)"
    )
    return con.execute(f'SELECT count(*) FROM {schema}.{tabella}').fetchone()[0]


def crea_database(dati, percorso_db):
    temporaneo = percorso_db.with_name(f'{percorso_db.stem}.tmp.duckdb')
    temporaneo.unlink(missing_ok=True)
    con = duckdb.connect(str(temporaneo))
    try:
        con.execute('SET preserve_insertion_order = false')
        for schema, (cartella, file_sql) in SCHEMI.items():
            con.execute(f'CREATE SCHEMA {schema}')
            for tabella, colonne in leggi_tabelle(dati / 'sql' / file_sql).items():
                inizio = time.perf_counter()
                righe = carica_tabella(con, schema, tabella, colonne, dati / cartella / f'{tabella}.csv')
                durata = time.perf_counter() - inizio
                print(f'{schema}.{tabella}: {righe:,} righe in {durata:.1f} s'.replace(',', '.'))
        con.close()
    except BaseException:
        con.close()
        temporaneo.unlink(missing_ok=True)
        raise
    temporaneo.replace(percorso_db)


def main():
    parser = argparse.ArgumentParser(description='Crea il database DuckDB dai CSV di Ergon.')
    parser.add_argument('--dati', type=Path, default=CARTELLA / 'data')
    parser.add_argument('--db', type=Path, default=CARTELLA / 'acme.duckdb')
    argomenti = parser.parse_args()

    if not (argomenti.dati / 'sql').is_dir():
        sys.exit(f'Dataset non trovato in {argomenti.dati}: vedi la sezione Preparazione del README.')

    inizio = time.perf_counter()
    crea_database(argomenti.dati, argomenti.db)
    print(f'Database creato in {argomenti.db} ({time.perf_counter() - inizio:.0f} s).')


if __name__ == '__main__':
    main()
