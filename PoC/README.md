# Proof of Concept (PoC)

## 1. Introduzione

Questa cartella contiene la **Proof of Concept (PoC)** del progetto. Il suo scopo è sperimentare e verificare la fattibilità tecnica delle principali soluzioni architetturali e tecnologiche individuate per la realizzazione del sistema.

Il PoC costituisce un ambiente di sviluppo sperimentale, nel quale vengono implementate e validate progressivamente le funzionalità fondamentali, con particolare attenzione all'integrazione tra i diversi componenti.

## 2. Obiettivi

Gli obiettivi principali della sperimentazione sono:

- Verificare l'integrazione tra frontend e backend.
- Sperimentare l'importazione e l'elaborazione di dataset.
- Valutare l'utilizzo di un Data Warehouse per la gestione dei dati.
- Realizzare una prima visualizzazione interattiva dei dati.
- Esplorare l'integrazione di funzionalità basate sull'intelligenza artificiale.
- Individuare eventuali criticità tecniche e valutare le tecnologie adottate.

## 3. Tecnologie

Le tecnologie individuate per la realizzazione del PoC sono:

| Tecnologia | Utilizzo |
|---|---|
| React | Sviluppo dell'interfaccia utente. |
| TypeScript | Tipizzazione e sviluppo del frontend. |
| Vite | Ambiente di sviluppo e build del frontend. |
| Python | Linguaggio di programmazione del backend e della pipeline ETL. |
| FastAPI | Realizzazione delle API REST. |
| Polars | Elaborazione e trasformazione dei dataset. |
| DuckDB | Gestione del Data Warehouse. |
| Apache ECharts | Generazione di grafici e visualizzazioni interattive. |

Le tecnologie e le relative modalità di utilizzo potranno essere aggiornate in seguito ai risultati delle sperimentazioni.

## 4. Struttura delle cartelle

La struttura del PoC è organizzata per separare le diverse responsabilità applicative.

```text
PoC/
├── frontend/           # Interfaccia utente
├── backend/            # Backend e API REST
├── etl/                # Pipeline di elaborazione dati
├── data/               # Dataset e dati sperimentali
├── database/           # Risorse e configurazioni del database
├── scripts/            # Script di supporto
├── .env.example        # Esempio di configurazione ambientale
├── docker-compose.yml  # Configurazione dei servizi
└── README.md           # Documentazione del PoC
```

## 5. Architettura prevista

Il sistema sperimentale prevede una suddivisione in componenti indipendenti:

- **Frontend:** gestisce l'interazione con l'utente, il caricamento dei dataset e la visualizzazione delle informazioni.
- **Backend:** espone le API REST e coordina le operazioni richieste dal frontend.
- **ETL:** si occupa dell'estrazione, della trasformazione e del caricamento dei dati.
- **Database:** gestisce la memorizzazione e l'interrogazione dei dati elaborati.
- **AI:** componente prevista per sperimentare l'elaborazione di richieste in linguaggio naturale e la generazione di visualizzazioni.

Il flusso principale previsto è:

```text
Frontend
   |
   v
Backend (FastAPI)
   |
   v
Pipeline ETL (Polars)
   |
   v
Data Warehouse (DuckDB)
   |
   v
Consultazione e visualizzazione
```

## 6. Configurazione e avvio

Le istruzioni di installazione e avvio verranno definite progressivamente, in base all'implementazione dei singoli componenti.

### Variabili d'ambiente

Il file `.env.example` contiene un modello delle variabili d'ambiente necessarie alla configurazione del PoC.

Per predisporre la configurazione locale, creare una copia del file:

```bash
cp .env.example .env
```

Su Windows PowerShell:

```powershell
Copy-Item .env.example .env
```

Le eventuali credenziali e chiavi API devono essere inserite esclusivamente nel file `.env`, che non deve essere versionato.

## 7. Sviluppo e sperimentazione

Lo sviluppo del PoC avviene in modo incrementale, implementando e verificando progressivamente i singoli componenti.

Le attività di sperimentazione e le relative considerazioni tecniche potranno essere documentate all'interno della cartella `docs/`, nella sezione dedicata agli esperimenti e alle decisioni architetturali.

## 8. Stato del progetto

Il PoC è attualmente in fase di predisposizione della struttura iniziale.

Le cartelle e i componenti descritti rappresentano l'organizzazione architetturale prevista e potranno subire modifiche durante le attività di sperimentazione.