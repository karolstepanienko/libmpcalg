# DMC - Dynamic matrix control
## Creating regulator object
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

---

## Calculating control value
```MATLAB
    reg = reg.calculateControl(Y_k, Yzad_k);
    u = reg.getControl();
```
Method ```calculateControl()``` returns updated regulator object with new 
control value, which is accessible with ```getControl()``` method.
### Parameters
- Y_k - output values in current moment k
    - horizontal vector of doubles

- Yzad_k - setpoint values in current moment k
    - horizontal vector of doubles

---

## Usage examples
- [1x1](../../test/test1x1DMC.m)
- [4x3](../../test/test4x3DMC.m)

## Navigation
- [Home](../../README.md)
