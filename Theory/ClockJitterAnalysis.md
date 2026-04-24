# Clock Jitter and SNR Limitation

## 1. Purpose

Theoretical basis for clock jitter analysis.

---

## 2. Definitions

### 2.1 Signal-to-Noise Ratio (SNR)

In power terms:

$$
\mathrm{SNR} = \frac{P_{\mathrm{signal}}}{P_{\mathrm{noise}}}
$$

In decibel form:

$$
\mathrm{SNR}_{dB} = 10 \log_{10}\left(\frac{P_{\mathrm{signal}}}{P_{\mathrm{noise}}}\right)
$$

For voltage quantities (equal impedance):

$$
\mathrm{SNR}_{dB} = 20 \log_{10}\left(\frac{V_{\mathrm{signal,rms}}}{V_{\mathrm{noise,rms}}}\right)
$$

---

### 2.2 RMS Clock Jitter

RMS jitter represents the statistical standard deviation of sampling time uncertainty.

If an ideal sampling instant occurs at time $t_0$, the actual sampling time is:

$$
t = t_0 + \Delta t
$$

where $\Delta t$ is a random timing deviation.

The RMS jitter is defined as:

$$
\sigma_t = \sqrt{E[(\Delta t)^2]}
$$

where $E[\cdot]$ denotes the expectation operator.

---

## 2.3 Derivation of Jitter-Limited SNR

Consider a sinusoidal input signal:

$$
x(t) = A \sin(2\pi f_{in} t)
$$

If sampling occurs with time error $\Delta t$, the amplitude error is:

$$
\Delta x = \frac{dx}{dt} \cdot \Delta t
$$

The derivative of the signal is:

$$
\frac{dx}{dt} = A \cdot 2\pi f_{in} \cos(2\pi f_{in} t)
$$

Thus:

$$
\Delta x = A \cdot 2\pi f_{in} \cos(2\pi f_{in} t) \cdot \Delta t
$$

The RMS value of $\cos(\cdot)$ is $1/\sqrt{2}$.

Therefore, jitter-induced RMS noise is:

$$
V_{\mathrm{jitter,rms}} = \frac{A}{\sqrt{2}} \cdot 2\pi f_{in} \sigma_t
$$

Signal RMS:

$$
V_{\mathrm{signal,rms}} = \frac{A}{\sqrt{2}}
$$

Thus:

$$
\mathrm{SNR} = \frac{V_{\mathrm{signal,rms}}}{V_{\mathrm{jitter,rms}}}
= \frac{1}{2\pi f_{in} \sigma_t}
$$

In decibel form:

$$
\mathrm{SNR}_{dB} = -20 \log_{10}(2\pi f_{in} \sigma_t)
$$

This shows jitter-induced SNR degradation increases linearly with input frequency.

---

## 2.4 Derivation of ENOB Formula

For an ideal N-bit ADC with full-scale peak-to-peak range $V_{FS,pp}$:

$$
\mathrm{LSB} = \frac{V_{FS,pp}}{2^N}
$$

Quantization noise RMS (uniform distribution):

$$
V_{q,rms} = \frac{\mathrm{LSB}}{\sqrt{12}}
$$

For a full-scale sine wave:

$$
V_{\mathrm{signal,rms}} = \frac{V_{FS,pp}}{2\sqrt{2}}
$$

Thus:

```math
\mathrm{SNR} =
\frac{V_{\mathrm{signal,rms}}}{V_{q,rms}}
=
\frac{\frac{V_{FS,pp}}{2\sqrt{2}}}
{\frac{V_{FS,pp}}{\sqrt{12} \cdot 2^N}}
=
\sqrt{\frac{3}{2}} \cdot 2^N
```

In decibel form, the ideal SNR for an $N$-bit converter is:

$$SNR_{dB} = 6.02N + 1.76$$

Rearranging to solve for the **Effective Number of Bits (ENOB)** based on measured SNR:

$$ENOB = \frac{SNR_{dB} - 1.76}{6.02}$$


## 2.5 Total SNR Combination
When multiple independent noise sources exist (e.g., ADC intrinsic noise and jitter noise), noise powers add in the linear domain.

If:

$$SNR_{ADC}$$
$$SNR_{jitter}$$

Then:

$$\frac{1}{SNR_{total,linear}} = \frac{1}{SNR_{ADC,linear}} + \frac{1}{SNR_{jitter,linear}}$$

Where:
$$SNR_{linear} = 10^{SNR_{dB}/10}$$

Convert back:

$$SNR_{total,dB} = 10 \log_{10}(SNR_{total,linear})$$

Noise powers must always be summed in linear scale.

---

## 2.6 RSS Jitter Combination
If multiple independent RMS jitter sources exist:

$$\sigma_{total} = \sqrt{\sigma_1^2 + \sigma_2^2 + \sigma_3^2 + \dots}$$

This follows from variance addition:

$$\sigma_{total}^2 = \sigma_1^2 + \sigma_2^2 + \sigma_3^2 + \dots$$

Valid only for uncorrelated jitter sources.
