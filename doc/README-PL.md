# libmpcalg
Biblioteka algorytmów regulacji predykcyjnej w środowisku MATLAB i GNU Octave.

## Jak skorzystać z biblioteki?
Aby skorzystać z zaimplementowanych algorytmów należy w wykorzystywanym
skrypcie dodać ścieżkę do folderu src biblioteki i wywołać funkcję
dodającą konieczne foldery do ścieżki wyszukiwań.
```MATLAB
    addpath('<scieżka-do-libmpcalg>/libmpcalg/src');
    init();
```
Po wykonaniu powyższych komend dostępne staną się funkcje pozwalające stworzyć
obiekty regulatorów predykcyjnych. Dokładniejsze instrukcje dla poszczególnych
algorytmów w poniższej liście.

## Przykłady:
- [SISO DMC](../mwe/mweSISO_DMC.m)
- [SISO GPC](../mwe/mweSISO_GPC.m)
- [SISO MPCS](../mwe/mweSISO_MPCS.m)
- [MIMO DMC](../mwe/mweMIMO_DMC.m)
- [MIMO GPC](../mwe/mweMIMO_GPC.m)
- [MIMO MPCS](../mwe/mweMIMO_MPCS.m)
- [MIMO MPC-NO](../mwe/mweMIMO_MPCNO.m)

## Autor:
Karol Stepanienko

## Nawigacja
- [lang-EN](../README.md)
