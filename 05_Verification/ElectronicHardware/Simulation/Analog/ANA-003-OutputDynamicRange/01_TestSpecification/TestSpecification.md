# ANA-003 Output Dynamic Range Test Specification

## 1. Purpose

This document defines the verification procedure for requirement ANA-003:

"The analog front-end (AFE) shall provide sufficient differential output
headroom to ensure linear operation within the specified detector input
current range, without clipping or excessive gain compression."

This test verifies dynamic range margin, ADC utilization, clipping behavior,
and gain compression characteristics of the AFE.

---

## 2. Scope

This test applies to:

- Complete analog front-end (CSA plus differential stage)
- Differential output at ADC input pins
- Maximum specified detector current range
- Nominal operating conditions

This test does not evaluate:

- Linearity over full-scale range (ANA-002)
- Noise performance (ANA-001)
- Small-signal bandwidth (ANA-004)
- Transient settling metrics (ANA-005)

---

## 3. Definitions

ADC full-scale differential input range:

$$
V_{FS,pp} = 2.0 \text{ V}
$$

Peak full-scale amplitude:

$$
V_{FS,peak} = \frac{V_{FS,pp}}{2} = 1.0 \text{ V}
$$

ADC utilization:

$$
Utilization_{percent} = \frac{V_{peak}}{V_{FS,peak}} \times 100
$$

Gain compression:

$$
Gain_{compression,percent} =
\frac{G_{low} - G_{high}}{G_{low}} \times 100
$$

Where:

- $$ G_{low} $$ is slope measured in linear region
- $$ G_{high} $$ is slope measured near maximum detector current

Clipping:

Output waveform exceeding the linear operating region,
or reaching supply limits.

---

## 4. Test Configuration

### 4.1 Simulation Model

- Charge Sensitive Amplifier topology
- Differential output stage
- SiPM input modeled as exponential current pulse
- Maximum detector current defined in configuration

### 4.2 Stimulus

Input current pulse:

$$
I(t) = I_{amp} \cdot e^{-(t - t_0)/\tau}
$$

Where:

- $$ I_{amp} $$ is stepped from small amplitude up to and beyond
  maximum specified detector current
- $$ \tau $$ is scintillator decay constant

Sweep must include:

- Nominal operating range
- Maximum specified detector current
- Slightly beyond nominal to verify headroom

---

## 5. Test Procedure

### Step 1 - Baseline Verification

Verify:

- Differential output centered correctly
- No premature saturation at nominal input levels

Abort if DC operating point invalid.

---

### Step 2 - Maximum Output Swing

Measure maximum differential output peak:

$$
V_{max,peak}
$$

Compute differential peak-to-peak swing:

$$
V_{max,pp} = 2 \cdot V_{max,peak}
$$

Verify:

$$
V_{max,pp} \ge 2.4 \text{ V}
$$

---

### Step 3 - ADC Utilization at Maximum Detector Current

At maximum specified detector current:

$$
Utilization_{percent} =
\frac{V_{peak}}{V_{FS,peak}} \times 100
$$

Verify:

$$
70 \le Utilization_{percent} \le 95
$$

---

### Step 4 - Gain Compression Evaluation

1. Perform linear regression in mid-scale region to obtain:

   $$ G_{low} $$

2. Perform local slope estimation near maximum detector current to obtain:

   $$ G_{high} $$

3. Compute:

   $$ Gain_{compression,percent} $$

Verify:

$$
Gain_{compression,percent} \le 1.0
$$

---

### Step 5 - Clipping Check

Verify that within the specified detector input range:

- No waveform clipping occurs
- No saturation is observed
- Output does not flatten or abruptly limit

If clipping occurs within specified range, requirement fails.

---

## 6. Acceptance Criteria

The requirement is satisfied if all conditions below are met:

1. $$ V_{max,pp} \ge 2.4 \text{ V} $$
2. $$ 70 \le Utilization_{percent} \le 95 $$
3. $$ Gain_{compression,percent} \le 1.0 $$
4. No clipping within specified detector current range

---

## 7. Outputs

The verification shall produce:

- Differential output vs input current plot
- ADC utilization calculation
- Gain compression calculation
- Statement confirming absence of clipping
- Final PASS or FAIL verdict

All plots shall be archived as SVG artifacts.

---

## 8. Assumptions

- Nominal temperature
- Nominal supply voltage
- Nominal detector capacitance
- Maximum detector current defined in configuration
- Linearity verified separately under ANA-002

---

## 9. Traceability

Requirement ID: ANA-003  
Verification Method: Transient simulation  
Artifacts:
- ANA003_OutputVsInput.svg
- ANA003_ADCUtilizationReport.txt
- ANA003_GainCompressionReport.txt

---

## 10. Notes

This requirement verifies operating headroom and dynamic range margin.
It does not evaluate linearity over full-scale range.
Linearity is covered by ANA-002.