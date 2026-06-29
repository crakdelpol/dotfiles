---
name: replace-conditional
description: Modalità refactoring focalizzata sui condizionali. Usa quando l'utente vuole semplificare switch/if ripetuti, condizionali complessi o annidati, senza cambiarne il comportamento.
user-invocable: true
---

# Modalità: Replace Conditional

Refactoring mirato a una sola famiglia di tecniche: **sostituire logica condizionale complessa o ripetuta** (`switch`, catene di `if/else`, condizioni annidate) con strutture più chiare. Valgono tutte le regole della modalità `refactor`, qui specializzate.

- **MAI cambi di comportamento.** Output, side-effect e API restano identici: ogni manovra qui sotto è behavior-preserving per costruzione. Se emerge un caso non gestito, fermati e segnalalo — non aggiungerlo di nascosto.
- **Rete di test verde prima di iniziare.** Se manca, scrivila. Se sospetti coperture deboli sui rami, usa la **fault injection** ramo per ramo: storpia un ramo e verifica che un test fallisca; se nessuno fallisce, quel ramo non è coperto — aggiungi il test prima di toccarlo.
- **Un ramo alla volta, passi piccoli e reversibili**, test verdi a ogni passo.

## Quando si applica (smell innescanti)
Mostrami i punti con `path:riga` e nomina lo smell:
- **Switch Statements** ripetuti sullo stesso type code in più punti (Shotgun Surgery in arrivo).
- **Condizionale annidato** profondo / arrow code che nasconde il flusso principale.
- **Condizione composta** illeggibile (`&&`/`||` lunghe) o duplicata su più rami.
- **Type code / flag** che pilota il comportamento via `if`/`switch`.
- **Controlli di null/caso speciale** sparsi e ripetuti su tutti i chiamanti.

## Catalogo manovre (Fowler) — sintomo → manovra
- **Decompose Conditional** — condizione e rami illeggibili: estrai `condizione`, `ramo-then`, `ramo-else` in funzioni dal nome parlante. *Prima mossa quasi sempre.*
- **Consolidate Conditional Expression** — più check distinti che portano allo **stesso** risultato: uniscili in una sola espressione (o funzione) ben nominata.
- **Replace Nested Conditional with Guard Clauses** — annidamento che gestisce casi eccezionali: trasformali in guard clause con return anticipato, lasciando il percorso normale piatto.
- **Replace Conditional with Polymorphism** — `switch`/`if` sullo **stesso** type code ripetuto in più punti: introduci una gerarchia/strategy e sposta ogni ramo nella sua sottoclasse. *La leva più forte contro lo Shotgun Surgery, ma anche la più invasiva: usala solo se il type code guida davvero più comportamenti.*
- **Replace Type Code with Subclasses / State / Strategy** — il type code è il vero driver: modellalo con tipi/stati invece che con un campo + condizionali.
- **Introduce Special Case / Null Object** — controlli ripetuti per uno stesso caso speciale (spesso `null`): incapsulalo in un oggetto che risponde come gli altri, eliminando i check ai chiamanti.
- **Introduce Assertion** — un ramo assume una condizione implicita: rendila esplicita con un'asserzione (non cambia comportamento in esecuzione normale).

## Guida alla scelta rapida
1. È solo **illeggibile** in un punto? → Decompose / Guard Clauses.
2. Rami diversi, **stesso esito**? → Consolidate.
3. Stesso `switch`/type code **ripetuto altrove**? → Polymorphism / Type Code → Subclasses/State/Strategy.
4. Stesso **caso speciale/null** controllato ovunque? → Special Case / Null Object.

Preferisci sempre la manovra meno invasiva che risolve lo smell dichiarato: non saltare al polimorfismo se bastano guard clause.
