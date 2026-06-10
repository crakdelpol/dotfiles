---
name: refactor
description: Modalità refactoring. Usa quando l'utente vuole migliorare codice esistente senza cambiarne il comportamento.
user-invocable: true
---

# Modalità: Refactor

- **MAI cambi di comportamento durante il refactor.** Il comportamento osservabile deve restare identico: nessuna nuova funzionalità, nessuna modifica di output, side-effect o API. Se serve cambiare comportamento, è un'altra fase: fermati e segnalalo.
- **All'inizio individua i code smell** nella parte di codice interessata e mostrameli con `path:riga`, dicendo *quale* smell è (vedi catalogo sotto) e *perché*. Aspetta che ti indichi quali affrontare prima di procedere.
- Assicurati che ci sia una rete di test verde **prima** di iniziare; se manca, scrivila prima di toccare il codice.
- Se il codice non è sufficientemente testato, usa la **fault injection** per scoprire cosa non è verificato: introduci deliberatamente un difetto nella parte da modificare e controlla che un test fallisca. Se nessun test fallisce, quella parte non è coperta — aggiungi i test mancanti **prima** di refactorarla, poi rimuovi il difetto.
- Passi piccoli e reversibili, un solo tipo di cambiamento alla volta; test verdi a ogni passo.
- Migliora solo ciò che serve allo scopo dichiarato; niente refactor a tappeto non richiesti.
- Non mischiare refactor e cambi di comportamento nello stesso commit.

## Catalogo code smell di riferimento
Catalogo di Martin Fowler (*Refactoring*). Usalo per nominare gli smell quando li mostri.
- **Bloaters** (cose diventate troppo grandi): Long Method, Large Class, Primitive Obsession, Long Parameter List, Data Clumps.
- **Abusi dell'OO**: Switch Statements ripetuti, Temporary Field, Refused Bequest, Alternative Classes with Different Interfaces.
- **Change Preventers** (ostacolano i cambiamenti): Divergent Change, Shotgun Surgery, Parallel Inheritance Hierarchies.
- **Dispensables** (superfluo): Duplicated Code, Dead Code, Lazy Class, Data Class, Speculative Generality, commenti ridondanti.
- **Couplers** (accoppiamento eccessivo): Feature Envy, Inappropriate Intimacy, Message Chains, Middle Man.
