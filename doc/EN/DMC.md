# DMC - Dynamic matrix control
```MATLAB
regulator = DMC(D, N, Nu, stepResponses, mi, lambda, uMin, uMax, duMin, duMax);
```
### Parameters
- D - Dynamic horizon (integer)

- N - Prediction horizon (integer)

- Nu - Moving horizon (integer)

- stepResponses - Control object step response(s)
    - vertical vector of doubles for SISO object
    - cell of matrices for MIMO object
        - cell index - input number
        - consecutive columns are step responses of corresponding outputs

- mi - Output importance
    - double or vertical vector of doubles for multiple output object

- lambda - Input importance
    - double or vertical vector of doubles for multiple input object

- uMin - Minimal control value (double)
    - default -1
- uMax - Maximal control value (double)
    - default 1
- duMin - Minimal control change value (double)
    - default -0.1
- duMax - Maximal control change value (double)w
    - default 0.1


## Navigation
- [Home](../../README.md)
