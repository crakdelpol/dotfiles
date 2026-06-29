---
name: remove-flag-argument
description: Modalità refactoring per eliminare un parametro booleano (flag argument) che seleziona il comportamento di un metodo. Usa quando un metodo riceve un booleano che decide *cosa* fa, e vuoi separare i due comportamenti senza cambiarne il risultato.
user-invocable: true
---

# Modalità: Remove Flag Argument

Refactoring mirato a un solo smell: **un parametro booleano che pilota il comportamento di un metodo** (`flag argument`). Esempio: `render(true)` vs `render(false)`, o `save(data, force=False)`. Il chiamante non capisce cosa significhi quel `true` al punto di chiamata, e il metodo nasconde due responsabilità diverse dietro un `if`.

Valgono tutte le regole della modalità `refactor`: **mai cambi di comportamento**, passi piccoli e reversibili, test verdi a ogni passo, niente refactor a tappeto non richiesti.

## Quando si applica
Attivati quando vedi un metodo con un parametro booleano che, dentro, fa sostanzialmente `if (flag) { ... } else { ... }`. Mostrami il punto con `path:riga` e i suoi chiamanti.

Se il booleano **non** seleziona comportamento (es. è un dato che viene solo salvato/propagato), **non** è questo lo smell: fermati e segnalalo.

> **Più flag insieme = un type code.** Se il metodo ha *più* booleani mutuamente esclusivi (es. `process(isAdmin, isGuest, isBanned)`), non sono due casi ma **N varianti** di un tipo travestito da flag. Conseguenze sul processo: in Fase A crei *un metodo esplicito per variante* (N, non 2), e la Fase B è **già giustificata in partenza** (è un type code ricco) — punta dritto al polimorfismo. Nota anche la combinazione "tutti false" come variante di default.

## Step 0 — Rete di sicurezza (obbligatorio, prima di tutto)
- **Se esiste già** un master test / suite che copre il comportamento, non riscriverlo: **eseguilo** per confermare che parta verde e verifica che copra davvero tutti i rami (vedi fault injection sotto). Solo se manca o è insufficiente, scrivilo.
- Scrivi/verifica un **master test** (golden master / characterization test) *esterno* al metodo: esercita il comportamento osservabile per **ogni** valore del flag (o **ogni** variante, se i flag sono più d'uno — vedi nota sotto) e ne blocca l'output. Questo è l'unico giudice del fatto che il comportamento non cambi.
- Se la copertura dei due rami è dubbia, usa la **fault injection**: storpia un ramo e verifica che il master test fallisca. Se non fallisce, quel ramo non è coperto — aggiungi il test prima di procedere.
- Da qui in poi: i master test devono restare verdi a **ogni** singolo passo.

## Fase A — Spacchetta il flag in metodi espliciti
Questa fase è quasi sempre la mossa giusta e da sola migliora il codice.

1. **Individua il compito del booleano**: dai un nome a *cosa* rappresentano il ramo `true` e il ramo `false` (non "true/false", ma l'intento: es. `renderForPrint` vs `renderForScreen`).
2. **Crea un metodo con nome esplicito per ciascuna variante** (due per un singolo flag, N se è un type code — vedi nota sopra), ciascuno con il valore del flag *hardcodato* al suo interno e i rami morti rimossi. Il vecchio metodo resta temporaneamente e delega ai nuovi (così i test restano verdi).
3. **Sposta i chiamanti** uno alla volta: ogni `metodo(true)` → `metodoEsplicitoTrue()`, ogni `metodo(false)` → `metodoEsplicitoFalse()`. Test verdi dopo ognuno.
4. **Elimina il vecchio metodo** col parametro booleano, una volta che non ha più chiamanti.

➡️ **Punto di stop sicuro.** Se i due comportamenti sono semplici e il flag non compare altrove, **fermati qui**: hai già rimosso lo smell senza aggiungere complessità. Vai in Fase B solo se è giustificata (vedi sotto).

## Fase B — Estrai oggetti e polimorfismo (condizionale)
Procedi **solo se** almeno una è vera: i due casi hanno logica/stato ricchi, lo stesso flag/discriminante si ripete in più metodi, o prevedi nuove varianti oltre ai due booleani. Altrimenti saresti in Speculative Generality — non farlo.

5. **Estrai un oggetto per caso** e sposta lì la logica del rispettivo ramo, dietro un'**interfaccia comune** (Replace Conditional with Polymorphism). Una sottoclasse/implementazione per variante.
6. **Crea una factory/builder** che restituisce l'oggetto giusto, incapsulando la scelta della variante in un solo punto.
7. **Usa gli oggetti** ai chiamanti: ottieni la variante dalla factory e invoca il metodo polimorfico.
8. **Rinomina il metodo polimorfico** con un nome **generico** che descrive l'intento comune (es. non più `renderForPrint`/`renderForScreen` ma `render()` sull'interfaccia), così aggiungere una terza variante non tocca i chiamanti.

## Chiusura — Test
- I **master test** restano la prova che il comportamento end-to-end è invariato: devono essere verdi.
- Aggiungi i **test di unità** mancanti sulle nuove unità introdotte: i due metodi espliciti (Fase A) e/o ogni implementazione + la factory (Fase B).
- Solo quando la nuova struttura è coperta dai suoi test, i master test diventano ridondanti e *possono* essere semplificati — non prima.

## Regola guida
Preferisci sempre il passo meno invasivo che risolve lo smell dichiarato. La Fase A elimina già il flag argument; la Fase B si fa solo quando i fatti (logica ricca, ripetizione, varianti future) la giustificano.
