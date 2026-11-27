# PoC: database e API aziendali

Primo ambiente di sperimentazione per il capitolato C7 SmartDashboard di Ergon Informatica (issue #56):

- database relazionale creato con Python a partire dai CSV forniti dall'azienda;
- test delle chiavi API di OpenAI e Anthropic tramite FastAPI.

## Cosa non è nel repository

Il repository è pubblico, quindi alcuni file restano solo sul proprio PC e sono esclusi da `.gitignore`:

| File | Contenuto | Come ottenerlo |
|---|---|---|
| `data/` | dataset di Ergon (CSV, documentazione, SQL) | pacchetto `dataset_analisi_fatturato.zip`, da chiedere al gruppo |
| `.env` | chiavi API | da chiedere al gruppo, mai su GitHub né in chat |
| `.venv/` | ambiente Python | si crea con i comandi qui sotto |
| `*.duckdb` | database generato | si crea dallo script del PoC |

## Preparazione

Requisiti: Python 3.12 o successivo, circa 10 GB liberi su disco.

1. Estrarre il dataset in `PoC/data/`, in modo da avere:

   ```
   PoC/data/
   ├── acmeOLAP/
   ├── acmeOLAP_DWH/
   ├── docs/documentazione_dataset.html
   ├── sql/
   └── README.md
   ```

2. Copiare il modello delle chiavi e inserire i valori:

   ```bash
   cd PoC
   cp .env.example .env
   ```

   Il file `.env` deve contenere una variabile per riga, senza spazi né virgolette:

   ```env
   OPENAI_API_KEY=...
   ANTHROPIC_API_KEY=...
   ```

3. Creare l'ambiente e installare le librerie:

   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   pip install -r requirements.txt
   ```

   In VS Code selezionare l'interprete `PoC/.venv/bin/python` (`Ctrl+Shift+P` → *Python: Select Interpreter*).

4. Prima di ogni commit controllare con `git status` che non compaiano file di `data/`, `.env` o `*.duckdb`.

## Creazione del database

Con l'ambiente attivo, dalla cartella `PoC`:

```bash
python crea_database.py
pytest test_database.py
```

Lo script crea `acme.duckdb` con due schemi, uno per ciascun database di Ergon:

| Schema | Origine | Tabelle |
|---|---|---|
| `raw` | `data/acmeOLAP/` | `stattab`, `stattabagg` e le anagrafiche |
| `dwh` | `data/acmeOLAP_DWH/` | `fact_fatturato` e le dimensioni `dim_*` |

Le tabelle e i tipi delle colonne vengono letti dagli SQL di Ergon in `data/sql/`. Prima di caricare ogni CSV, lo script controlla che le colonne corrispondano allo schema. Il database viene scritto in un file temporaneo e sostituisce quello vecchio solo se il caricamento va a buon fine. Su un portatile con 8 core, il caricamento richiede circa un minuto e 3 GB di RAM, e produce un file di 1,1 GB.

I test verificano che:

- il numero di righe di ogni tabella coincida con la documentazione di Ergon;
- i codici siano testo e conservino gli zeri iniziali;
- ogni chiave di `fact_fatturato` trovi la sua riga nella dimensione;
- le colonne usate per il fatturato netto non contengano NULL, in `stattab` e in `fact_fatturato` (la formula usa comunque `COALESCE`, così un eventuale NULL vale 0 invece di escludere l'intera riga dal totale);
- il fatturato netto di ogni anno sia uguale calcolato da `raw` e da `dwh`.

Per aprire il database e scrivere query:

```bash
python -c "import duckdb; print(duckdb.connect('acme.duckdb', read_only=True).sql('SHOW ALL TABLES'))"
```

## Avvio di FastAPI

Con l'ambiente attivo, dalla cartella `PoC`:

```bash
uvicorn app:app --reload
```

Il servizio risponde su `http://127.0.0.1:8000`. La pagina `http://127.0.0.1:8000/docs` elenca gli endpoint e permette di provarli dal browser.

| Endpoint | Cosa fa | Costo |
|---|---|---|
| `GET /salute` | stato del servizio, presenza del database e delle chiavi (senza mostrarle) | gratuito |
| `GET /db/tabelle` | tabelle del database con il numero di righe | gratuito |
| `GET /db/fatturato?anno=2025` | fatturato netto per canale calcolato sul DWH | gratuito |
| `GET /llm/anthropic/modelli` | modelli disponibili con la chiave Anthropic | gratuito |
| `GET /llm/openai/modelli` | modelli disponibili con la chiave OpenAI | gratuito |
| `POST /llm/anthropic/prova` | invia una domanda breve a Claude e restituisce risposta, tempo e token | consuma credito |
| `POST /llm/openai/prova` | invia una domanda breve a OpenAI e restituisce risposta, tempo e token | consuma credito |

Per verificare che una chiave sia valida bastano gli endpoint `modelli`, che non consumano credito. Gli endpoint `prova` accettano facoltativamente un corpo `{"domanda": "..."}` di al massimo 500 caratteri.

I modelli usati sono `claude-opus-5-5` e `gpt-5-mini`. Si possono cambiare aggiungendo al file `.env` le variabili `ANTHROPIC_MODEL` e `OPENAI_MODEL`.

Se una chiave manca, l'endpoint risponde `503`. Se il provider rifiuta la richiesta, risponde `502` indicando il motivo: chiave non valida, permesso negato, modello non disponibile, limite di richieste o credito esaurito, errore del provider, tempo scaduto o connessione non riuscita.

Per i test:

```bash
pytest
```

`test_app.py` simula le risposte dei provider, quindi non consuma credito e funziona anche senza chiavi.

### Risultati della prova del 2026-11-25

| | Anthropic | OpenAI |
|---|---|---|
| Chiave | valida, 14 modelli disponibili | valida, 103 modelli disponibili |
| Modello | `claude-opus-5-5` | `gpt-5-mini` |
| Risposta a "Rispondi soltanto con la parola: funziona" | `funziona` | `funziona` |
| Tempo | 0,8 s | 4,9 s |
| Token in ingresso / in uscita | 25 / 5 | 17 / 109 |

## Il dataset

Fatturato di Acme Srl, azienda del settore caseario, con dati anonimizzati dal 2010 a novembre 2026. La documentazione completa è in `data/docs/documentazione_dataset.html`.

| Cartella | Ruolo | Contenuto |
|---|---|---|
| `acmeOLAP/` | dati di partenza, come escono dal gestionale | 10 tabelle; `stattab` ha 10.250.000 righe |
| `acmeOLAP_DWH/` | data warehouse con schema a fiocco di neve | `fact_fatturato` (10.250.000 righe) e 9 dimensioni `dim_*` |

Formato dei CSV: codifica UTF-8, separatore `;`, punto decimale, intestazione in prima riga, campo vuoto = NULL.

## Problemi e limitazioni

1. **Codici con zeri iniziali.** Codici come `003`, `05` o `C01` vanno letti come testo: se i tipi vengono dedotti in automatico diventano numeri e perdono gli zeri. I tipi vanno indicati in modo esplicito, ricavandoli dagli SQL di Ergon.
2. **SQL scritti per SQL Server.** Gli script in `data/sql/` usano `GO`, `BULK INSERT` e percorsi Windows: vanno adattati a DuckDB.
3. **Record "N/D" ripetuti.** Le chiavi mancanti puntano al record con `sk_id = -1`, che in `dim_tabgen` e `dim_clsart` è ripetuto per ogni tipo o livello. `sk_id` da solo non può quindi essere chiave primaria, e ogni join su queste tabelle deve filtrare anche per `tipo_tab` o per livello.
4. **Dimensioni dei file.** I CSV occupano circa 4,5 GB, di cui 2,1 GB per `stattab` e altrettanti per `fact_fatturato`: vanno caricati direttamente con DuckDB, senza passare da pandas, per non esaurire la memoria.
5. **Valori sintetici.** I costi unitari e i campi Capo Area, Zona Vendita, Mercato, Gruppo Acquisto e Insegna sono generati da Ergon, così come le righe oltre le 231.938 reali: i risultati delle analisi non rappresentano dati reali.
6. **Nome della variabile della chiave Anthropic.** La libreria ufficiale di Anthropic cerca la chiave in `ANTHROPIC_API_KEY`: con un altro nome, come `CLAUDE_API_KEY`, non la trova.
7. **Token di ragionamento di OpenAI.** Per una risposta di una sola parola, `gpt-5-mini` ha conteggiato 109 token in uscita e ha impiegato quasi 5 secondi, perché i token del ragionamento interno sono fatturati come output. Nel progetto andrà valutato il compromesso tra costo, tempi di risposta e qualità dei due provider.
8. **Ragionamento sempre attivo su Claude Opus 5.5.** Su questo modello il ragionamento non si può disattivare: la prova usa il livello di impegno più basso (`effort: low`) per contenere costi e tempi. Le richieste usano anche il fallback automatico lato server (`fallbacks: "default"`), che in caso di rifiuto ripete la richiesta su un altro modello.
9. **Nessuna autenticazione.** Gli endpoint `prova` consumano il credito messo a disposizione da Ergon e non richiedono login: il servizio va avviato solo in locale e non va esposto in rete.
