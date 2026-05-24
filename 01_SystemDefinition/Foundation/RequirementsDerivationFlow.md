## Purpose

This document is [the foundation for requirement IDs](../Requirements/)

---

## Derivation Flow

| Step | Detail / Value |
| :--- | :--- |
| **Measurement Intent** | First HW version, capability to be determined experimentally. |
| **Scintillator Selection** | NaI(Tl) 25.4 mm diameter, light yield 38,000 ph/MeV, cost-effective, good timing (230 ns decay) |
| **SiPM Selection** | 4 x MICROFC-60035-SMT (6x6 mm each), PDE 35%, cost-effective, effective coverage 28.4% |
| **Detector Physics Analysis** ($\sigma_{scintillation}$ calculated) | N_detected = 1755 PE @ 662 keV, $\sigma_{scintillation} = 2.39\%$, FWHM_statistical = 5.6% |
| **Electronics Noise Budget** ($\sigma_{electronics} \leq 0.18 \times \sigma_{scintillation}$) | Derived: $\sigma_{electronics} \leq 0.43\%$ RMS; Total degradation < 1.5% acceptable |
| **Bandwidth Derived** (from pulse shape) | SiPM t_cell = 95 ns -> f_-3dB ~= 3.5 MHz; ADC sampling at 40 MSPS adequate for pulse reconstruction |
| *ADC* | 12-bit, 40 MSPS |

**Detector Physics Analysis and Requirements Derivation**
(See: [Detector Physics Analysis and Requirements Derivation](./DetectorPhysicsAnalysis.md))
 
