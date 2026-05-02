# Signal Processing and Sampling Theory

## 1. Purpose

Defines the relationship between analog bandwidth, pulse dynamics, sampling rate, digital reconstruction, and processing gain.

This document covers the time-domain and discrete-time constraints of the spectroscopy system.

---

## 2. Bandwidth and Rise Time Relationship

For a first-order system:

$$t_r \approx \frac{0.35}{f_{3dB}}$$

Where:
* $t_r$: 10%-90% rise time.
* $f_{3dB}$: -3 dB bandwidth.

The constant arises from:

$$t_r = \frac{\ln(9)}{\omega_{3dB}} = \frac{2.2}{2\pi f_{3dB}}$$

Engineering Interpretation:
* Higher bandwidth -> faster rise time.
* Excess bandwidth increases integrated noise.

Bandwidth must preserve signal dynamics without unnecessarily increasing noise.

---

## 3. Sampling Theory

ADC sampling frequency:

$$f_s$$

Sampling period:

$$T_s = \frac{1}{f_s}$$

Samples across rising edge:

$$N_{rise} = \frac{t_r}{T_s}$$

---

## 4. The Rule of Three

For reliable amplitude estimation:

$$N_{rise} \ge 3$$

Reason:
* 1 sample -> no slope information.
* 2 samples -> unstable interpolation.
* 3+ samples -> reliable curve fitting and peak detection.

This requirement arises from discrete-time approximation limits.

---

## 5. Total Samples per Pulse

Pulse duration approximately:

$$T_{pulse} \approx 5\tau$$

Total samples per pulse:

$$N_{pulse} = \frac{5\tau}{T_s}$$

Determines:
* Digital integration capability
* Energy estimation stability
* Pile-up discrimination

---

## 6. Digital Integration and SNR Improvement

When integrating $N$ independent samples:

$$SNR \propto \sqrt{N}$$

Because:

$$\sigma_{avg} = \frac{\sigma}{\sqrt{N}}$$

Oversampling improves effective resolution through processing gain.

---

## 7. ADC Resolution vs Sampling Rate

Two orthogonal improvement mechanisms:

Increasing ADC bits:
* Reduces quantization noise
* Improves SNR by ~6 dB per bit

Increasing sampling rate:
* Increases $N$
* Improves SNR by $\sqrt{N}$ after integration

Total system variance:

$$\sigma_{total}^2 = \sigma_{detector}^2 + \sigma_{AFE}^2 + \sigma_{ADC}^2 + \sigma_{quantization}^2$$

Dominant variance determines performance limit.

---

## 8. Oversampling Ratio (OSR)

$$OSR = \frac{f_s}{2 \cdot BW}$$

Higher OSR:
* Improves digital filtering flexibility
* Reduces in-band noise after decimation
* Improves amplitude estimation stability

ADC speed enables digital processing gain even if analog bandwidth is lower.
