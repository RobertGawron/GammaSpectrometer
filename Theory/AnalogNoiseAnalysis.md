# Analog Noise Analysis and Energy Resolution

## 1. Purpose

Basis for analyzing analog front-end (AFE) noise.

---

## 2. Definition of Noise Metrics

### 2.1 Output RMS Noise

Output RMS noise is defined as:

$$
V_{rms} = \sqrt{\int_{f_{low}}^{f_{high}} S_v^2(f) \, df}
$$

Where:

- $S_v(f)$ is voltage noise spectral density in V/sqrt(Hz)
- $f_{low}$ and $f_{high}$ define the effective bandwidth

The integration limits must be explicitly defined because RMS noise
is bandwidth dependent.

---

### 2.2 Differential Noise

For a differential ADC input:

$$
V_{diff}(t) = V_P(t) - V_N(t)
$$

All RMS noise calculations relevant to ADC performance
shall be performed on the differential signal:

$$
V_{diff,rms}
$$

---

## 2.3 Bandwidth Definition

Noise integration bandwidth must match the system sampling domain.

For an ADC operating at sampling frequency $f_s$:

$$
f_{Nyquist} = \frac{f_s}{2}
$$

Noise shall be integrated from DC to Nyquist frequency,
unless an analog anti-alias filter limits the effective bandwidth.

If an anti-alias filter is present, its transfer function
must be included in the noise model:

$$
S_{v,shaped}(f) = |H(f)|^2 \cdot S_v(f)
$$

---

## 2.4 Noise Spectral Density Integration

Noise spectral density ($S_v$) is expressed in units of:

$$\text{V} / \sqrt{\text{Hz}}$$

To compute the total **RMS noise** ($V_{rms}$) over a defined frequency bandwidth from $f_{low}$ to $f_{high}$:

$$V_{rms} = \sqrt{\int_{f_{low}}^{f_{high}} S_v^2(f) \, df}$$

### Key principles:
* The spectral density must be squared before integration.
* Integration must be performed in the linear domain.
* Units consistency must be preserved.

---

### 2.5 Input-Referred Noise (Charge Amplifier)

For a charge-sensitive amplifier (CSA):

$$
V_{out} = \frac{Q_{in}}{C_f}
$$

Where:

- $Q_{in}$ is the input charge
- $C_f$ is the feedback capacitor

Thus, the input-referred charge noise is:

$$
Q_{noise,rms} = V_{noise,rms} \cdot C_f
$$

Convert to equivalent number of electrons:

$$
N_e = \frac{Q_{noise,rms}}{e}
$$

Where:

- $e = 1.602 \times 10^{-19}$ C is the elementary charge

### Key Principles

1. Input-referred noise for a CSA is expressed in coulombs or electrons.
2. Smaller $C_f$ reduces output noise but decreases dynamic range.
3. Equivalent Noise Charge (ENC) is the standard metric used to quantify the noise performance of a charge-sensitive amplifier.
4. ENC allows direct comparison between detector resolution and electronic noise.
5. Input-referred charge noise is independent of detector capacitance.


## 2.6 Input-Referred Noise (TIA)
For a transimpedance amplifier (TIA):
$$V_{out} = I_{in} \cdot R_f$$

Thus, the input-referred current noise is:
$$I_{noise,rms} = \frac{V_{noise,rms}}{R_f}$$

**Where:**
* $R_f$: Feedback resistor.
* $V_{noise,rms}$: Output RMS noise.

Input-referred noise is the relevant metric for detector comparison.

---

## 2.7 RSS Combination of Independent Noise Sources
If multiple independent noise sources exist (AFE noise, ADC intrinsic noise, Reference noise, Detector shot noise), the total RMS noise is:

$$V_{total,rms} = \sqrt{V_1^2 + V_2^2 + V_3^2 + \dots}$$

**This assumes:**
* Statistical independence.
* Gaussian distribution.
* No deterministic correlation.
* **Note:** Noise powers add, not amplitudes.

---

## 2.8 Cumulative Integrated Noise
To evaluate the noise contribution versus frequency:

$$V_{rms}(f) = \sqrt{\int_{f_{low}}^{f} S_v^2(f') \, df'}$$

**This representation allows:**
* Identification of dominant frequency regions.
* Validation of bandwidth assumptions.
* Verification of anti-alias filtering impact.

---

## 2.9 Conversion to ENOB
Signal-to-Noise Ratio (SNR):

$$SNR = 20 \log_{10} \left( \frac{V_{signal,rms}}{V_{noise,rms}} \right)$$

Effective Number of Bits (ENOB):

$$ENOB = \frac{SNR - 1.76}{6.02}$$

**Where:**
* $1.76$ dB arises from ideal quantization error.
* $6.02$ dB per bit arises from $20 \log_{10}(2)$.

System ENOB is limited by the dominant noise source.

---

## 2.10 Equivalent Noise Charge (ENC)
Input-referred current noise can be converted to charge noise:

$$Q_{noise} = I_{noise,rms} \cdot \tau$$

**Where:**
* $\tau$: Shaping time constant.

Convert to electrons ($N_e$):

$$N_e = \frac{Q_{noise}}{e}$$

**Where:**
* $e = 1.602 \times 10^{-19}$ C.

ENC provides a direct linkage between electronic noise and spectroscopy energy resolution.

---

## 2.11 Impact on Energy Resolution
Energy resolution (FWHM) degradation due to noise:

$$\Delta E_{noise} \propto ENC$$

Total resolution combines statistical detector variance and electronic noise variance in quadrature:

$$\sigma_{total}^2 = \sigma_{detector}^2 + \sigma_{electronics}^2$$

