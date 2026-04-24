# ENOB and ADC Performance Limitations

## 1. Purpose
This document defines the relationship between nominal ADC resolution ($N$ bits), intrinsic ADC SNR, and achievable system ENOB. It establishes why system requirements must be derived from real ADC performance rather than ideal quantization assumptions.

---

## 2. Definitions

### 2.1 Ideal Quantization SNR
For an ideal $N$-bit ADC:

$$SNR_{ideal} = 6.02N + 1.76 \text{ dB}$$

This represents the theoretical limit assuming quantization noise is the only error source.

---

### 2.2 Correct Engineering Approach
The system ENOB must satisfy:

$$ENOB_{system} \le ENOB_{ADC}$$

A practical requirement must include a margin ($\Delta$):

$$ENOB_{system} \ge ENOB_{ADC} - \Delta$$

Where $\Delta$ is typically $0.2$ to $0.5$ bits to account for:
* Analog front-end noise
* Bandwidth limitations
* Clock jitter
* Anti-alias filtering
* Implementation/thermal variation

---

### 2.3 Deriving Noise Requirement from ENOB
Given a target ENOB, we find the required SNR:

$$SNR = 6.02 \cdot ENOB + 1.76$$

Using the relationship to RMS voltage:

$$SNR = 20 \log_{10} \left( \frac{V_{signal,rms}}{V_{noise,rms}} \right)$$

Solving for the allowable noise floor ($V_{noise,max}$):

$$V_{noise,max} = \frac{V_{signal,rms}}{10^{SNR/20}}$$


