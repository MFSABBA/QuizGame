<QUIZ GAME - README.TXT FILE

===============================================================
Copyright (C) 2026 by [Simone Sabbadin]
COPYRIGHT NOTICE:
Tutti i contenuti di questo file non possono essere copiati
(in parte o per intero), né riutilizzati in altri progetti
senza l’autorizzazione scritta dell’autore.
===============================================================


INTRODUZIONE:
===============================================================
Quiz Game è un’applicazione mobile sviluppata in Flutter
(utilizzando il linguaggio Dart) che permette all’utente di
partecipare a un quiz a scelta multipla.

L’app recupera domande in tempo reale da un’API online e
presenta all’utente una serie di 10 quesiti con quattro
possibili risposte.

L’obiettivo è selezionare la risposta corretta per ogni
domanda e ottenere il punteggio più alto possibile.

Al termine del quiz, viene mostrato il risultato finale con
il numero di risposte corrette e la possibilità di ricominciare
una nuova partita.


REQUISITI DI SISTEMA:
===============================================================
1) Flutter SDK versione 3.0 o superiore
2) Android Studio, Visual Studio Code o IDE compatibile
3) Dispositivo o emulatore Android/iOS connesso
4) Connessione Internet attiva (necessaria per il caricamento delle domande)


STRUTTURA DEL PROGETTO:
===============================================================
lib/
│
├── main.dart        → Codice principale dell’applicazione
│                     (gestione UI, logica del quiz e navigazione)


DESCRIZIONE TECNICA:
===============================================================
- L’applicazione utilizza il widget principale "MaterialApp"
  con tema scuro personalizzato.
- La navigazione tra schermate è gestita tramite routes:
  • "/"        → HomePage
  • "/quiz"    → QuizPage
  • "/result"  → ResultPage
- La HomePage consente di avviare il quiz tramite un pulsante.
- La QuizPage (StatefulWidget) gestisce:
  • il caricamento delle domande tramite richiesta HTTP
  • la logica del quiz (indice domanda e punteggio)
  • la visualizzazione dinamica delle risposte
- Le domande sono recuperate tramite API REST (Open Trivia DB)
  e convertite da formato JSON.
- Le risposte vengono mescolate casualmente ad ogni domanda.
- La funzione "rispondi()" verifica la correttezza della risposta
  e aggiorna il punteggio.
- Al termine del quiz, viene effettuata una navigazione verso
  la schermata dei risultati passando il punteggio come parametro.
- La ResultPage mostra:
  • punteggio finale
  • pulsante per ricominciare il quiz


PRINCIPALI SCELTE DI SVILUPPO:
===============================================================
1) Utilizzo di Flutter:
   → consente sviluppo multipiattaforma con una singola codebase.
2) Architettura semplice:
   → tutta la logica è contenuta in un unico file per chiarezza didattica.
3) Uso di StatefulWidget:
   → permette aggiornamenti dinamici dell’interfaccia durante il quiz.
4) Integrazione API esterna:
   → consente contenuti sempre diversi senza hardcoding delle domande.
5) Navigazione tramite routes:
   → separa logicamente le schermate dell’applicazione.
6) UI minimale:
   → focus sull’esperienza utente e leggibilità delle domande.


BUG CONOSCIUTI:
===============================================================
- Le domande possono contenere caratteri HTML non decodificati
  (es. &quot;, &#039;)
- Mancanza di gestione avanzata degli errori di rete
- Possibile ricaricamento delle risposte ad ogni rebuild


SUGGERIMENTI E MIGLIORAMENTI FUTURI:
===============================================================
- Decodifica automatica dei caratteri HTML nelle domande
- Aggiunta di un timer per ogni domanda
- Inserimento di livelli di difficoltà selezionabili
- Feedback visivo (verde/rosso) dopo la selezione della risposta
- Salvataggio dei punteggi migliori (leaderboard)
- Miglioramento UI con animazioni e transizioni
- Separazione del codice in più file (architettura modulare)
- Implementazione di modelli dati (classi Dart)


CREDITI:
===============================================================
Progetto sviluppato da [Simone Sabbadin]  
Basato sull’API pubblica Open Trivia DB  
Realizzato come esercitazione didattica Flutter 2026.


LICENZA:
===============================================================
N/D
===============================================================s