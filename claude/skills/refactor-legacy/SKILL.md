---
name: refactor-legacy
description: Modalità refactoring di un flusso legacy end-to-end. Usa quando l'utente vuole ristrutturare un intero flusso di lavoro (dall'entry point fino alla fine) senza cambiarne il comportamento — non una singola classe, ma il percorso completo e le sue dipendenze.
user-invocable: true
---

# Modalità: Refactor Legacy (end-to-end)

Refactoring di un **flusso completo**, dall'entry point fino all'output finale.
Differenza dal refactor classico: lì il bersaglio è di solito una singola classe o metodo; qui è l'intero percorso end-to-end, spesso codice legacy poco o per niente testato.

- **MAI cambi di comportamento.** Il comportamento osservabile dell'intero flusso (input → output, side-effect, contratti verso l'esterno) deve restare identico. Se serve cambiarlo, è un'altra fase: fermati e segnalalo.
- **Aggancia prima il comportamento con i characterization test**: ai confini del flusso, cattura l'output attuale così com'è — anche se sembra "sbagliato" — e usalo come rete di sicurezza. Sono diversi dai test del refactor classico: non verificano una classe, ma il percorso completo.
- Se il flusso non è testabile end-to-end, **trova i seam** (punti dove puoi alterare il comportamento senza modificare il codice in place) per inserire i test e spezzare le dipendenze.
- Identifica **change point** e **test point** prima di toccare il codice; pianifica dove intervenire e dove agganciare i test.
- Procedi a **piccoli passi**, mantenendo i characterization test verdi a ogni passo; ricostruisci la copertura man mano che spezzi le dipendenze.
- **Quando il lavoro scende al livello di un singolo metodo o classe, applica le regole di `/refactor`**: individuazione e segnalazione dei code smell (catalogo di Fowler) e fault injection per verificare la copertura. Questa modalità governa il flusso; `/refactor` governa la singola unità.
- Non mischiare refactor e cambi di comportamento nello stesso commit.

## Catalogo di riferimento
Tecniche da *Working Effectively with Legacy Code* (Michael Feathers).

- **Characterization Test**: test che documenta il comportamento attuale del flusso, per congelarlo prima di cambiarlo.
- **Golden Master / Approval Test**: cattura l'output completo del flusso e confrontalo a ogni modifica — adatto a flussi lunghi con output ricco.
- **Seam ed enabling point**: punto dove cambiare comportamento senza editare in place. Tipi: object seam, link seam, preprocessing seam.
- **Sensing & Separation**: le due ragioni per spezzare una dipendenza — *sensing* (osservare valori altrimenti invisibili) e *separation* (isolare il codice per metterlo sotto test).
- **Effect Sketch**: schizza come una modifica si propaga (cosa influenza cosa) per ragionare sull'impatto lungo il flusso prima di intervenire.
- **Sprout Method / Sprout Class**: scrivi il codice nuovo in un'unità nuova e testabile, poi chiamala dal codice esistente.
- **Wrap Method / Wrap Class**: avvolgi il comportamento esistente per estenderlo senza modificarlo dall'interno.
- **Break dependencies**: Extract Interface, Parameterize Constructor/Method, Extract and Override Call/Factory Method, Introduce Instance Delegator — per isolare ciò che impedisce di testare.
- **Preserve Signatures**: quando spezzi le dipendenze, mantieni le firme identiche per ridurre il rischio di errore manuale.
- **Lean on the Compiler**: sfrutta compilatore/type system per trovare tutti i punti d'impatto di un rename o cambio di firma lungo il flusso.
- **Scratch Refactoring**: refactor usa-e-getta solo per *capire* il flusso (poi lo butti, non lo committi) — collegato a `/discovery`.

## Algoritmo (dal libro)
1. Identifica i change point.  2. Trova i test point.  3. Spezza le dipendenze.  4. Scrivi i test.  5. Modifica e refactora con i test verdi.
