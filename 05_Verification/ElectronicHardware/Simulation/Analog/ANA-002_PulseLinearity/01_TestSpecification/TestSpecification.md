# ANA-002 Pulse Linearity Test Specification

## 1. Purpose

This document defines the verification procedure for requirement ANA-002:

"The analog front-end (AFE) shall exhibit integral non-linearity (INL) not exceeding 0.1 percent of full-scale over the differential output range from 0 V to 2.0 Vpp."

This test verifies dynamic pulse amplitude linearity of the AFE using transient simulation.

---

## 2. Scope

This test applies to:

- Complete analog front-end (CSA plus differential stage)
- Differential output at ADC input pins
- Nominal operating conditions

This test does not evaluate:

- Noise performance (covered by ANA-001)
- Dynamic range headroom (covered by ANA-003)
- Bandwidth (covered by ANA-004)
- Transient settling behavior (covered by ANA-005)

---

## 3. Definitions

Full-scale voltage (FS):

Differential ADC full-scale input range = 2.0 Vpp

Peak full-scale amplitude:

$$
V_{FS,peak} = \frac{2.0}{2} = 1.0 \text{ V}
$$

Integral Non-Linearity (INL):

Maximum deviation of measured output amplitude from best-fit linear regression line, normalized to full-scale peak amplitude.

$$
INL_{percent} = \frac{V_{measured} - V_{fit}}{V_{FS,peak}} \times 100
$$

---

## 4. Test Configuration

### 4.1 Simulation Model

- Charge Sensitive Amplifier topology
- Differential output stage
- SiPM input modeled as exponential current pulse

### 4.2 Stimulus

Input current pulse:

$$
I(t) = I_{amp} \cdot e^{-(t - t_0)/\tau_{scint}} \quad \text{for } t > t_0
$$

Where:

- $$ \tau_{scint} = 230 \text{ ns} $$
- $$ I_{amp} $$ is stepped to cover 0 to full-scale output

The sweep must include:

- Near-zero amplitude
- Amplitude sufficient to produce approximately 1.0 V peak differential output

---

## 5. Test Procedure

### Step 1 - DC Operating Point Validation

Verify:

- Differential baseline near 0 V
- Common-mode near VREF
- No saturation at nominal bias

If invalid, abort linearity evaluation.

---

### Step 2 - Sweep Coverage Validation

Measure:

- Minimum differential peak output
- Maximum differential peak output

Verify:

$$
V_{min} \approx 0
$$

$$
V_{max} \approx V_{FS,peak}
$$

The sweep must cover near 0 to near full-scale.

If sweep does not span near 0 to near FS, test is invalid.

---

### Step 3 - Peak Extraction

For each sweep step:

Compute differential output:

$$
V_{diff} = V(out\_p) - V(out\_n)
$$

Subtract baseline and extract peak absolute amplitude.

---

### Step 4 - Best-Fit Linear Regression

Perform first-order linear regression:

$$
V_{fit} = a \cdot I + b
$$

Using only points within the full-scale region.

---

### Step 5 - INL Calculation

For each valid point:

$$
INL_{volts} = V_{measured} - V_{fit}
$$

Normalize:

$$
INL_{percent} = \frac{INL_{volts}}{V_{FS,peak}} \times 100
$$

Determine:

$$
INL_{max} = \max(|INL_{percent}|)
$$

---

## 6. Acceptance Criteria

Requirement:

$$
INL_{max} \le 0.1 \text{ percent}
$$

Pass condition:

- DC operating point valid
- Sweep covers near 0 to near full-scale
- $$ INL_{max} \le 0.1 \text{ percent} $$

Fail condition:

- Any of the above criteria not met

---

## 7. Outputs

The verification shall produce:

- Differential output vs input current plot
- INL vs input current plot
- Numerical report of:
  - Maximum INL (percent FS)
  - Maximum INL (volts)
  - Maximum INL (LSB)
- Final PASS or FAIL verdict

All plots shall be archived as SVG artifacts.

---

## 8. Assumptions

- Nominal temperature
- Nominal supply voltage
- Nominal detector capacitance
- Pulse shape defined by $$ \tau_{scint} = 230 \text{ ns} $$
- No clipping or saturation within evaluated region

---

## 9. Traceability

Requirement ID: ANA-002  
Verification Method: Transient simulation  
Artifacts:
- ANA-002_PulseLinearity_OutputVsInput.svg
- ANA-PulseLinearity_INLPercentFS.svg

---

## 10. Notes

This test verifies dynamic pulse amplitude linearity only.

Gain magnitude accuracy and dynamic range margins are evaluated under separate requirements.