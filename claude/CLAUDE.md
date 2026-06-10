# Linee guida personali

## Codice
- KISS: scegli la soluzione più semplice che risolve il problema reale; niente astrazioni o generalizzazioni speculative.
- SOLID: una sola responsabilità per unità; funzioni e classi piccole e focalizzate; dipendi da astrazioni, non da dettagli.
- Uniformati a convenzioni, naming e pattern già presenti; non introdurne di nuovi senza motivo.
- Modifiche minime e mirate: niente refactor o riformattazioni non richiesti.
- Commenti solo dove la logica non è ovvia, e spiega il *perché*, non il *cosa*.

## Workflow
- Task non banali: proponi un piano e attendi il mio ok prima di scrivere codice.
- Mai `commit` o `push` se non te lo chiedo esplicitamente.
- Dopo aver modificato il codice esegui il linter del progetto e riportami l'esito.
- Se un'istruzione è ambigua o un'azione è rischiosa/irreversibile, fermati e chiedi invece di indovinare.

## Testing
- TDD come default: quando aggiungi o cambi un comportamento, scrivi prima il test che fallisce, poi il codice minimo che lo fa passare.
- Ogni modifica va validata dai test (esistenti + nuovi) prima di considerarla completa: eseguili e riportami l'esito.
- Unica eccezione: se ti dico esplicitamente che sto facendo uno *spike*, salta TDD e test e punta alla soluzione più rapida.
