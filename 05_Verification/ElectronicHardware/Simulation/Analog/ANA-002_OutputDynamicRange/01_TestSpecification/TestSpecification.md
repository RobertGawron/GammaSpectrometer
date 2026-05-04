# Test Specification: ANA-002 AFE Pulse Amplitude Linearity

## Objective
Verify that the analog front-end (AFE) meets the integral non-linearity (INL) requirement over the defined full-scale output range.

## Requirement
ANA-002

The AFE shall exhibit INL <= 0.1 percent of full-scale over the differential output range:
$$
0 \le V_{out,diff} \le 2.0\ \text{Vpp}
$$

## Test Method
Transient simulation with stepped input stimulus.

A set of input pulses with increasing amplitude is applied to the AFE. For each step, the peak differential output voltage is measured.

A best-fit linear model is computed:
$$
V_{out,fit} = a \cdot I_{in} + b
$$

INL is defined as the deviation from the best-fit line:
$$
INL(V) = V_{out} - V_{out,fit}
$$

INL expressed as percent of full-scale:
$$
INL_{\%} = \frac{INL(V)}{V_{FS}} \times 100
$$

where:
$$
V_{FS} = 2.0\ \text{Vpp}
$$

## Test Conditions
- Simulation type: transient
- Input stimulus: stepped pulse amplitude
- Number of steps: >= 10
- Output metric: peak differential voltage
- Full-scale reference: 2.0 Vpp differential

## Acceptance Criteria
The maximum absolute INL within the valid range shall satisfy:
$$
\max |INL_{\%}| \le 0.1
$$

The valid range includes all measurements where:
$$
V_{out,diff} \le 2.0\ \text{Vpp}
$$

## Pass/Fail Criteria
- PASS: maximum INL within specified range is <= 0.1 percent
- FAIL: maximum INL exceeds 0.1 percent
- INVALID: test does not reach at least 2.0 Vpp output

## Outputs
- Linearity curve: input amplitude vs output peak
- INL plot: INL vs input amplitude
- Reported values:
  - maximum INL (percent)
  - maximum INL (volts)
  - maximum INL (LSB)