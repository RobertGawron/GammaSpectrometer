# Detector Physics Analysis and Requirements Derivation

## Purpose

The objective is to establish detector physics limits and evaluate
whether electronic performance exceeds fundamental scintillation limits.

The fundamental design principle is:

$$
\sigma_{electronics} \ll \sigma_{scintillation}
$$

The detector physics sets the performance floor. Electronics should not
dominate it. Anything significantly exceeding this margin is cost overhead,
not performance gain.

---

## Design Flow Overview

The correct systems engineering flow for gamma spectrometer design:

1. Measurement Intent
2. Isotope Identification Requirements
3. Energy Resolution Requirements
4. Scintillator Selection (based on resolution, density, cost, ruggedness)
5. Crystal Geometry Selection (volume vs weight tradeoff)
6. SiPM Selection (PDE, dark count, size, radiation hardness)
7. Detector Physics Analysis (calculate sigma_scintillation)
8. Electronics Noise Budget Derivation (sigma_electronics <= 0.3 x sigma_scintillation)
9. Bandwidth Derivation (from SiPM pulse shape)
10. ADC Requirements Derivation (ENOB, sampling rate)
11. Component Selection (meets derived requirements)



---

## Section 1 - Scintillator Selection

### Selection Criteria

Scintillator selection is driven by multiple competing requirements:

| Property | Impact | Tradeoff |
|---|---|---|
| Light yield (photons/MeV) | Higher -> better resolution | Usually inversely related to density |
| Density (g/cm^3) | Higher -> better detection efficiency | Heavier, may reduce light yield |
| Decay time (ns) | Shorter -> higher count rate capability | May have lower light yield |
| Emission wavelength (nm) | Must match SiPM PDE peak | Material constraint |
| Hygroscopicity | Non-hygroscopic -> easier handling | May limit material choices |


### Common Scintillator Properties

| Material | Light Yield (ph/MeV) | Density (g/cm^3) | Decay Time (ns) | Emission Peak (nm) | Hygroscopic |
|---|---|---|---|---|---|
| NaI(Tl) | 38,000 | 3.67 | 230 | 415 | Yes |
| LaBr3(Ce) | 63,000 | 5.08 | 16 | 380 | Yes |
| CsI(Tl) | 54,000 | 4.51 | 1000 | 550 | Slightly |
| LYSO | 32,000 | 7.10 | 40 | 420 | No |
| BGO | 8,500 | 7.13 | 300 | 480 | No |

Choice: [diameter 1 inch x 1 inch NaI(Tl) Scintillator, Energy Resolution: <=7.5%@662keV(Cs-137)](https://www.ost-photonics.com/product/diameter-1-inch-x-1-inch-naitl-scintillator/)
Reason: Cost/performance ratio. Price is a key factor because scintillator crystals are expensive ($95+ USD).

## Section 2 - SiPM Selection

### Selection Criteria

| Property | Impact | Target |
|---|---|---|
| Photon Detection Efficiency (PDE) | Higher -> more detected photons -> better resolution | Match to scintillator emission |
| Active area | Larger -> better coverage -> better resolution | Match to crystal geometry |
| Dark count rate (DCR) | Lower -> less noise at low energy | Temperature-dependent |
| Microcell size | Smaller -> lower crosstalk, higher DCR | Tradeoff: 15-50 um typical |
| Gain | Higher -> easier amplification | Must not saturate electronics |
| Timing resolution | Better -> improved coincidence performance | Not critical for spectroscopy |
| Radiation hardness | Critical for high-dose environments (not the case of this spectrometer) | Mission-dependent |
| Operating voltage | Lower -> simpler bias supply | 25-35 V typical for modern SiPMs |

Choice: [MICROFC-60035-SMT](https://www.onsemi.com/pdf/datasheet/microc-series-d.pdf)
Reason: Cost/performance ratio. SiPM are expensive ($12+ USD for 6x6mm variant).


## Section 3 - Detector Physics Calculation

### Statistical Energy Resolution Model

This subsections models the theoretical lower bound on energy resolution
assuming Poisson fluctuations in the number of detected photons dominate.

---

### Step 1 - Reference Gamma Energy

For system verification and calibration:

Cs-137 reference line:

$$
E_{\gamma} = 662 \text{ keV} = 0.662 \text{ MeV}
$$

---

### Step 2 - Scintillation Photon Production

Total photons produced by scintillation:

$$
N_{photons} = LY \times E_{\gamma}
$$

Where LY is the scintillator light yield.

For selected scintillators:

| Scintillator | Calculation | N_photons |
|---|---|---|
| NaI(Tl) | 38,000 x 0.662 | 25,156 |
| LaBr3(Ce) | 63,000 x 0.662 | 41,706 |

Note: the light output of the scintillator is a function of the deposited Gamma energy.

---

### Step 3 - Optical Collection Efficiency

Not all produced photons reach the SiPM face.

Optical efficiency factor (accounts for reflector losses, absorption):

$$
\eta_{optical} \approx 0.70
$$

Geometric coverage fraction:

$$
C_{geom} = \frac{A_{SiPM}}{A_{crystal}}
$$

Effective coverage including optical transport losses:

$$
C_{eff} = C_{geom} \times \eta_{optical}
$$

Collected photons reaching SiPM active area:

$$
N_{collected} = N_{photons} \times C_{eff}
$$

---

### Step 4 - SiPM Photon Detection

Photon Detection Efficiency (PDE) from MICROFC-60035-SMT datasheet:

$$
PDE \approx 0.35
$$

Number of detected photoelectrons:

$$
N_{detected} = N_{collected} \times PDE
$$

Full expression (combining all stages):

$$
N_{detected} = LY \times E_{\gamma} \times C_{geom} \times \eta_{optical} \times PDE
$$

---

### Step 5 - Statistical Fluctuation (Poisson Statistics)

Photoelectron generation follows Poisson statistics.

Standard deviation:

$$
\sigma_{N} = \sqrt{N_{detected}}
$$

Relative RMS fluctuation:

$$
\sigma_{rel} = \frac{\sigma_{N}}{N_{detected}} = \frac{1}{\sqrt{N_{detected}}}
$$

---

### Step 6 - Convert RMS to FWHM

### Derivation of FWHM Conversion Factor

The constant 2.355 comes from Gaussian distribution geometry:

For a Gaussian with standard deviation sigma, the FWHM is:

$$
FWHM = 2\sqrt{2\ln(2)} \times \sigma \approx 2.355 \times \sigma
$$

This assumes the energy distribution is Gaussian, which is valid when:
- N_detected >> 100 (Central Limit Theorem applies)
- Poisson distribution -> Gaussian for large N

For our configuration (N_detected = 1755), this assumption is valid.


Energy resolution is conventionally expressed as Full Width at Half Maximum (FWHM).

For a Gaussian distribution:

$$
FWHM = 2.355 \times \sigma
$$

Therefore:

$$
FWHM = 2.355 \times \sigma_{rel}
$$

Convert to percentage:

$$
FWHM = \frac{2.355}{\sqrt{N_{detected}}} \times 100
$$

---

### Step 7 - Final Statistical Resolution Formula

$$
\boxed{
FWHM = \frac{2.355}{\sqrt{N_{detected}}} \times 100
}
$$

Where:

$$
N_{detected} = LY \times E_{\gamma} \times C_{geom} \times \eta_{optical} \times PDE
$$

This is the **detector statistical limit** -- the physics floor
that cannot be improved by electronics.

---

### Step 8 - Worked Example (Selected Configuration)

Configuration:

| Parameter | Value |
|---|---|
| Scintillator | NaI(Tl) |
| Light yield | 38,000 photons/MeV |
| Crystal diameter | 25.4 mm |
| SiPM model | MICROFC-60035-SMT |
| SiPM size | 6.0 x 6.0 mm |
| PDE | 0.35 |
| Optical efficiency | 0.70 |
| Reference energy | 662 keV (0.662 MeV) |

**Calculation:**

Crystal face area:

$$
A_{crystal} = \pi \times \left(\frac{25.4}{2}\right)^2 = \pi \times 12.7^2 \approx 506.7 \text{ mm}^2
$$

SiPM configuration: 4 x (6x6 mm) array

Single SiPM active area:

$$
A_{SiPM,single} = 6.0^2 = 36.0 \text{ mm}^2
$$

Total SiPM array active area:

$$
A_{SiPM,total} = 4 \times 36.0 = 144.0 \text{ mm}^2
$$

Geometric coverage:

$$
C_{geom} = \frac{144.0}{506.7} \approx 0.284 \text{ (28.4\%)}
$$

Effective coverage:

$$
C_{eff} = 0.284 \times 0.70 \approx 0.199
$$

Photons produced:

$$
N_{photons} = 38000 \times 0.662 = 25156
$$

Detected photoelectrons:

$$
N_{detected} = 25156 \times 0.199 \times 0.35 \approx 1755
$$

Statistical RMS:

$$
\sigma_{rel} = \frac{1}{\sqrt{1755}} = \frac{1}{41.89} \approx 0.0239
$$

$$
\sigma_{scintillation} = 2.39\% \text{ RMS}
$$

Statistical FWHM:

$$
FWHM = \frac{2.355}{\sqrt{1755}} \times 100 \approx 5.6\%
$$

**Result:**

For NaI(Tl) 25.4 mm + 4 x MICROFC-60035-SMT (6x6 mm array):

$$
\boxed{
\sigma_{scintillation} = 2.39\% \text{ RMS at 662 keV}
}
$$

$$
\boxed{
FWHM_{statistical} = 5.6\%
}
$$

This is the detector physics floor.

### Step 9 - SiPM Configuration Comparison

| SiPM Size | Area (mm^2) | Effective Coverage (%) | $$\sigma$$ | FWHM  |
|---|---|---|---|---|
| 3x3 mm | 9 | 1.24% | 9.56% | 22.51% |
| 6x6 mm | 36 | 4.97% | 4.78% | 11.25% |
| array of 4 x (6x6 mm) | 144 | 19.89% | 2.39% | 5.63% |

Choice: array of 4 x (6x6 mm) [MICROFC-60035-SMT](https://www.onsemi.com/pdf/datasheet/microc-series-d.pdf)
Reason: Cost/performance ratio.

### Step 10 - Model Assumptions and Limitations

This model includes **statistical photon noise only**.

Effects **NOT** included:

| Effect | Impact on Resolution |
|---|---|
| Electronic noise | Adds in quadrature: $\sigma_{total}^2 = \sigma_{scint}^2 + \sigma_{elec}^2$ |
| Dark count rate (DCR) | Adds false counts, raises low-energy noise floor |
| Optical crosstalk | Inflates apparent N_detected, degrades resolution |
| After-pulsing | Distorts pulse shape, affects energy measurement |
| Crystal non-proportionality | Introduces energy-dependent bias |
| Optical non-uniformity | Position-dependent resolution variation |
| Temperature effects on PDE | Shifts gain and resolution |
| SiPM gain non-uniformity | Cell-to-cell variation |

Therefore:

$$
FWHM_{calculated} \leq FWHM_{measured}
$$

The calculated value is a **theoretical lower bound**.

Real measured resolution will always be larger due to additional noise sources.

---

## Section 4 - Electronics Requirements Derivation

### Noise Budget Allocation

From Section 3, we determined (for 4 x 6x6 mm SiPM array):

$$
\sigma_{scintillation} = 2.39\% \text{ RMS}
$$

### Design Rule

To remain detector-limited:

$$
\sigma_{electronics} \leq 0.3 \times \sigma_{scintillation}
$$

This ensures total degradation is negligible:

$$
\sigma_{total} = \sqrt{\sigma_{scint}^2 + \sigma_{elec}^2}
$$

### Calculate Electronics Budget

$$
\sigma_{electronics} \leq 0.3 \times 2.39\% = 0.72\% \text{ RMS}
$$

$$
\sigma_{electronics} \leq 0.72\%
$$

### Verify Degradation

If electronics contributes 0.72% RMS:

$$
\sigma_{total} = \sqrt{2.39^2 + 0.72^2} = \sqrt{5.71 + 0.52} = \sqrt{6.23} \approx 2.50\%
$$

Degradation:

$$
\frac{2.50 - 2.39}{2.39} \times 100 \approx 4.6\%
$$

Acceptable (< 5% degradation threshold).

### Derived Requirement

$$
\boxed{
\sigma_{electronics} \leq 0.72\% \text{ RMS of full-scale energy}
}
$$

This is **traceable** to detector physics, not arbitrary.

---

### Detector-Limited SNR

Convert detector resolution to SNR:

For FWHM ~= 5.6% (4 x 6x6 mm SiPM array):

$$
\sigma = \frac{FWHM}{2.355} = \frac{5.6}{2.355} \approx 2.38\%
$$

Equivalent SNR:

$$
SNR = \frac{1}{\sigma} = \frac{1}{0.0238} \approx 42
$$

In dB:

$$
SNR_{dB} = 20 \log_{10}(42) \approx 32.5 \text{ dB}
$$

**The detector physics limit is approximately 32.5 dB SNR at 662 keV.**

---

### ADC Specification Comparison

Typical ADC specifications:

- Ideal ADC SNR: 65-70 dB
- Detector-limited SNR: ~32.5 dB
- Margin: ~37 dB

**Conclusion:**

The ADC intrinsic noise floor is **not** the system bottleneck.

Detector photon statistics dominate system resolution.

Even with improved detector (4 SiPM array), ADC still has ~37 dB margin.

---

### Important Clarification on ENOB

ENOB (Effective Number of Bits) is a **sinusoidal continuous-wave metric**
based on SNR of a full-scale sine wave.

Gamma spectroscopy resolution is a **statistical pulse-area metric**
based on Poisson photon counting.

**These are not directly equivalent.**

Blindly applying ENOB-based ADC selection can lead to over-specification
of dynamic performance relative to detector physics.

---

## Section 5 -- Bandwidth Requirements Derivation

### SiPM Microcell Pulse Physics

After a photon triggers an avalanche in a SiPM microcell:

1. Microcell capacitance discharges rapidly (~1 ns)
2. Quench resistor stops the avalanche
3. Microcell recharges exponentially toward bias voltage

The recharge voltage follows:

$$
V(t) = V_{bias} \left(1 - e^{-t / \tau_{cell}}\right)
$$

Where the cell time constant is:

$$
\tau_{cell} = R_{quench} \times C_{cell}
$$

For MICROFC-60035-SMT (from datasheet):

| Parameter | Value |
|---|---|
| Microcell recharge time constant | tau_cell ~= 95 ns |
| Anode-cathode capacitance | C = 3400 pF |
| Dark count rate (21degC) | ~100 kHz/mm^2 |

**Important:**

tau_cell = 95 ns is the exponential recharge constant of each microcell.

It defines the **pulse tail time constant** at the anode.

It does NOT mean the pulse rise time is 95 ns (rise is faster).

The tail dominates the observable pulse envelope.

**Note:** When using 4 SiPMs in parallel, the individual microcell time constant
remains the same (95 ns). The combined pulse shape is the sum of 4 independent
SiPM pulses, but the characteristic time constant does not change.

---

### ADC Sampling Constraint

Selected ADC sampling rate: 40 MSPS

Sampling period:

$$
T_s = \frac{1}{40 \times 10^6} = 25 \text{ ns}
$$

To adequately reconstruct pulse shape:

**Required: 3 to 5 samples across rising edge**

Therefore required analog rise time:

$$
t_{rise,min} = 3 \times T_s = 75 \text{ ns}
$$

$$
t_{rise,pref} = 5 \times T_s = 125 \text{ ns}
$$

Target rise time range:

$$
t_{rise} \approx 75 \text{ to } 125 \text{ ns}
$$

This naturally aligns with tau_cell ~= 95 ns.

---

### Bandwidth Derivation

Using standard rise time to bandwidth conversion:

$$
f_{3dB} \approx \frac{0.35}{t_{rise}}
$$

For t_rise = 100 ns:

$$
f_{3dB} \approx \frac{0.35}{100 \times 10^{-9}} = 3.5 \text{ MHz}
$$

**Derived Bandwidth Requirement:**

$$
\boxed{
f_{3dB} = 3 \text{ to } 6 \text{ MHz}
}
$$

**Note:** Bandwidth requirement is independent of SiPM array size.
It is determined by pulse shape (tau_cell) and ADC sampling constraints,
not by detector resolution.

