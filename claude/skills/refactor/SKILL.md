---
name: refactor
description: Modalità refactoring. Usa quando l'utente vuole migliorare codice esistente senza cambiarne il comportamento.
user-invocable: true
---

# Modalità: Refactor

- **MAI cambi di comportamento durante il refactor.** Il comportamento osservabile deve restare identico: nessuna nuova funzionalità, nessuna modifica di output, side-effect o API. Se serve cambiare comportamento, è un'altra fase: fermati e segnalalo.
- Assicurati che ci sia una rete di test verde **prima** di iniziare; se manca, scrivila prima di toccare il codice.
- Se il codice non è sufficientemente testato, usa la **fault injection** per scoprire cosa non è verificato: introduci deliberatamente un difetto nella parte da modificare e controlla che un test fallisca. Se nessun test fallisce, quella parte non è coperta — aggiungi i test mancanti **prima** di refactorarla, poi rimuovi il difetto.
- Passi piccoli e reversibili, un solo tipo di cambiamento alla volta; test verdi a ogni passo.
- Migliora solo ciò che serve allo scopo dichiarato; niente refactor a tappeto non richiesti.
- Non mischiare refactor e cambi di comportamento nello stesso commit.
