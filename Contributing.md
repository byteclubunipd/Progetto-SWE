# CONTRIBUTING

## 1. Per iniziare

Prima di iniziare assicurarsi di aver installato gli strumenti e i software necessari. <br>
Clona la repository:
```
git clone https://github.com/byteclubunipd/Progetto-SWE.git
cd Progetto-SWE
```

## 2. Workflow
Il Workflow utilizzato per il progetto è il *gitflow workflow*, molto utilizzato in ambito professionale e molto comodo per gestire un numero elevato di branch. Per saperne di più si può vedere la seguente documentazione: [GITFLOW WORKFLOW](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow). <br>
Si crea un branch separato per ogni cambiamento e per la loro nomenclatura di segue lo standard. <br>
Esempi: 	
- feature/add-new-feature
- fix/fix-bug-description
- docs/update-documentation <br>

Evitare di fare commit direttamente sul *main* e sul branch *develop*.

## 3. Nomenclatura per i documenti
I documenti sono stati divisi in due categorie: 
- Verbali e diari di bordo, per i quali si utilizza la nomenclatura [VE/VI/DDB_YYYY-MM-DD], in cui VI sta per verbale interno, VE per verbale esterno e DDB per diario di bordo. 
- Documenti tecnici, per i quali si utilizza la nomenclatura ["Nome documento" vx.y.z]. In quest'ultima, x identifica le modifiche sostanziali al contenuto, y le modifiche alla struttura e z le modifiche allo stile. <br>

Esempi:
- [VI_2005-12-22] è il nome di un verbale interno del 22 Dicembre 2005
- Analisi_dei_requisiti v8.8.8

## 4. Standard di codifica
- Per nominare variabili e funzioni usare il camelCase;
- Usare nomi chiari e descrittivi;
- Inserire commenti nei casi in cui il codice non sia autoesplicativo;
- Mantenere il codice pulito e semplice, senza creare funzioni e variabili inutili.

## 5. Testing
- Prima di fare una commit effettuare una sessione di test;
- Assicurarsi che dopo le modifiche il processo di build del progetto non dia errori;
- Assicurarsi che le modifiche non vadano a influenzare il corretto funzionamento dei moduli già esistenti.

## 6. Commits e Pull requests
- Scrivere messaggi chiari e descrittivi nelle commit;
- Spiegare il fine delle modifiche nella pull request, possibilmente evidenziando la issue;
- Descrivere come sono stati testati i cambiamenti;
- Inserire il verificatore per la verifica della pull request.