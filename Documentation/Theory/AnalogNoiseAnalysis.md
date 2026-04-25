# Analog Noise Analysis and Energy Resolution

## 1. Purpose

Basis for analyzing analog front-end (AFE) noise.

---

## 2. Definitions

### 2.1 Noise Spectral Density and RMS Integration
Voltage noise spectral density $S_v(f)$ is expressed in units of:

$$\text{V} / \sqrt{\text{Hz}}$$

The RMS noise over a defined bandwidth from $f_{low}$ to $f_{high}$ is:

$$V_{rms} = \sqrt{\int_{f_{low}}^{f_{high}} S_v^2(f) \, df}$$

**Principles:**
* Spectral density must be squared before integration (working in the power domain).
* Integration must be performed in the linear domain.
* RMS noise is strictly bandwidth dependent.
* Integration limits must always be explicitly stated.

---

### 2.2 Bandwidth Definition
The integration bandwidth shall match the effective system bandwidth. For an ADC sampling at $f_s$:

$$f_{Nyquist} = \frac{f_s}{2}$$

Noise shall be integrated from DC to Nyquist unless limited by an analog anti-alias filter. If an anti-alias filter is present, the shaped spectral density is used:

$$S_{v,shaped}(f) = |H(f)| \cdot S_v(f)$$

The resulting $S_{v,shaped}^2(f)$ shall be used in the integration defined in Section 2.1.

---

### 2.3 Differential Noise
For differential ADC inputs:

$$V_{diff}(t) = V_P(t) - V_N(t)$$

All RMS noise calculations relevant to ADC performance shall be performed on the differential signal. The integration method defined in Section 2.1 applies to the differential spectral density.

---

### 2.4 Input-Referred Noise
The total integrated RMS noise may be referred to the detector domain.

**Transimpedance Amplifier (TIA):**

$$I_{noise,rms} = \frac{V_{noise,rms}}{R_f}$$

**Charge-Sensitive Amplifier (CSA):**

$$Q_{noise,rms} = V_{noise,rms} \cdot C_f$$

**Convert charge noise to electrons ($N_e$):**

$$N_e = \frac{Q_{noise,rms}}{e}$$

Where $e = 1.602 \times 10^{-19} \text{ C}$. This quantity represents the complete integrated analog front-end noise referred to the detector input.

---

### 2.5 Total RMS Noise (RSS Combination)
Independent noise sources shall be combined in variance form:

$$V_{total,rms} = \sqrt{V_1^2 + V_2^2 + V_3^2 + \dots}$$

**Assumptions:**
* Statistical independence.
* Gaussian distribution.
* No deterministic correlation.
* **Note:** Noise powers add, not amplitudes.

---

### 2.6 Integrated Noise vs Frequency (Cumulative Form)
To evaluate noise contribution as a function of bandwidth:

$$V_{rms}(f) = \sqrt{\int_{f_{low}}^{f} S_v^2(f') \, df'}$$

This representation allows for the identification of dominant frequency regions and verification of anti-alias filter effectiveness.

---

### 2.7 Conversion to SNR and ENOB
**Signal-to-Noise Ratio (SNR):**

$$SNR = 20 \log_{10} \left( \frac{V_{signal,rms}}{V_{noise,rms}} \right)$$

**Effective Number of Bits (ENOB):**

$$ENOB = \frac{SNR - 1.76}{6.02}$$

---

### 2.8 Equivalent Noise Charge (ENC)
For charge-based systems:

$$Q_{noise} = I_{noise,rms} \cdot \tau$$

$$N_e = \frac{Q_{noise}}{e}$$

**Where:**
* $\tau$: Shaping time constant.
* $e$: Elementary charge.

ENC provides a direct linkage between electronic noise and spectroscopy energy resolution.

---

### 2.9 Scintillation Statistical Limit

From Poisson statistics, the relative energy resolution is limited by the number of scintillation photons:

$$\frac{\sigma_E}{E} \propto \frac{1}{\sqrt{N_{ph}}}$$

This represents the **fundamental detector limit**.

Even with perfect electronics, the resolution cannot exceed this bound.

---

### 2.10 Electronics Contribution

Electronic noise introduces additional variance:

$$\sigma_{electronics}$$

Total variance combines in quadrature:

$$\sigma_{total}^2 = \sigma_{scintillation}^2 + \sigma_{electronics}^2$$

---

### 2.11 Physics-Limited Regime

If:

$$\sigma_{electronics} \ll \sigma_{scintillation}$$

Then:

$$\sigma_{total} \approx \sigma_{scintillation}$$

In this regime, system performance is limited by scintillator physics rather than electronics.

The design goal of the analog front-end is therefore to ensure:

$$ENC_{electronics} \ll ENC_{detector}$$
ENC provides a direct linkage between electronic noise and system energy resolution.
