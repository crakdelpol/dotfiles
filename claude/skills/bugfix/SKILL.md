---
name: bugfix
description: Modalità correzione bug. Usa quando l'utente segnala un comportamento errato da correggere.
user-invocable: true
---

# Modalità: Bugfix

- Prima **capisci e riproduci** il bug: scrivi un test che fallisce e cattura il difetto.
- Poi correggi con la modifica minima che fa passare il test (red → green).
- Cerca la **causa radice**, non il sintomo.
- Verifica che il fix non rompa altri test: nessuna regressione.
- Riportami causa, fix applicato e come l'hai verificato.
