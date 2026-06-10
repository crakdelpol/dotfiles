---
name: refactor
description: Modalità refactoring. Usa quando l'utente vuole migliorare codice esistente senza cambiarne il comportamento.
user-invocable: true
---

# Modalità: Refactor

- Il comportamento osservabile **non deve cambiare**: nessuna nuova funzionalità.
- Assicurati che ci sia una rete di test verde **prima** di iniziare; se manca, scrivila prima di toccare il codice.
- Passi piccoli e reversibili, un solo tipo di cambiamento alla volta; test verdi a ogni passo.
- Migliora solo ciò che serve allo scopo dichiarato; niente refactor a tappeto non richiesti.
- Non mischiare refactor e cambi di comportamento nello stesso commit.
