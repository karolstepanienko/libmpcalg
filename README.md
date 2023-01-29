# libmpcalg
Model predictive control algorithms library in MATLAB and GNU Octave.

<p align="center">
  <img src="./doc/img/libmpcalg_logo.png"  alt="libmpcalg's logo"/>
</p>

## How to use the library?
To use implemented algorithms in a script simply add the path to src directory
of the library to your environment's search path and run the initialisation
script.
```MATLAB
    addpath('<path-to-libmpcalg>/libmpcalg/src');
    init();
```
After executing those commands, constructors of regulators classes will be
accessible. For precise instructions about using specific algorithms see the
list below.

## Minimal working examples
- [SISO DMC](mwe/mweSISO_DMC.m)
- [SISO GPC](mwe/mweSISO_GPC.m)
- [SISO MPCS](mwe/mweSISO_MPCS.m)
- [MIMO DMC](mwe/mweMIMO_DMC.m)
- [MIMO GPC](mwe/mweMIMO_GPC.m)
- [MIMO MPCS](mwe/mweMIMO_MPCS.m)
- [MIMO MPC-NO](mwe/mweMIMO_MPCNO.m)

## Author:
Karol Stepanienko

## Navigation
- [lang-PL](./doc/README-PL.md)
