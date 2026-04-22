# Core Theory

## Signal-to-Noise Ratio (SNR)

In power terms:
$$SNR = \\frac{P_{signal}}{P_{noise}}$$

In decibel form:
$$SNR_{dB} = 10 \\log_{10} \\left( \\frac{P_{signal}}{P_{noise}} \\right)$$

## RMS Clock Jitter
RMS (Root Mean Square) jitter represents the statistical standard deviation of sampling time uncertainty. 

If an ideal sampling instant occurs at time $t_0$, the actual sampling time is:
$$t = t_0 + \\Delta t$$
where $\\Delta t$ is a random timing deviation.

The RMS jitter is defined as:
$$\\sigma_t = \\sqrt{E[(\\Delta t)^2]}$$
where $E[\\cdot]$ denotes the expectation operator (see $$\\sigma_{t}$$ in chapter below, this is "the same"). RMS jitter therefore quantifies the average magnitude of time uncertainty in the sampling process.

## Total RMS Jitter from Multiple Sources
If multiple independent timing jitter sources exist in the clock path (e.g., oscillator, buffer, driver, interconnect effects), the total RMS jitter is the quadratic (geometrical) sum:
$$\\sigma_{t} = \\sqrt{\\sigma_1^2 + \\sigma_2^2 + \\sigma_3^2 + \\dots}$$

This follows from statistical variance addition:
$$\\sigma_{t}^2 = \\sigma_1^2 + \\sigma_2^2 + \\sigma_3^2 + \\dots$$

This summation applies when jitter sources are uncorrelated random processes. In practice, the largest contributor typically dominates the total RMS jitter.

## Jitter-Limited SNR
For an ADC sampling a sinusoidal input signal, the SNR degradation due to RMS sampling clock jitter is:
$$SNR_{jitter}(f_{in}) = -20 \\log_{10}(2\\pi f_{in} \\sigma_t)$$

Where:
* $f_{in}$ = input signal frequency (Hz)
* $\\sigma_t$ = RMS clock jitter (seconds)

This relationship follows from the fact that sampling time uncertainty produces an amplitude error proportional to the signal slope:
$$\\frac{dx}{dt} \\propto 2\\pi f_{in}$$

Thus, jitter-induced noise increases proportionally with input frequency.

## ENOB from SNR
Effective Number of Bits (ENOB) is derived from SNR using:
$$ENOB = \\frac{SNR - 1.76}{6.02}$$

Where:
* SNR is expressed in dB.
* The constants arise from ideal quantization assumptions.
* This formula assumes an ideal ADC dominated by quantization noise.

## Total SNR with Multiple Noise Sources
When multiple independent noise sources exist (e.g., ADC intrinsic noise and clock jitter), they must be combined in the linear power domain.

If $SNR_{ADC}$ is the intrinsic ADC signal-to-noise ratio, and $SNR_{jitter}$ is the jitter-limited SNR, then the total system SNR is:
$$\\frac{1}{SNR_{total}} = \\frac{1}{SNR_{ADC}} + \\frac{1}{SNR_{jitter}}$$

This equation must be evaluated in linear scale (not dB), because independent noise powers add:
$$P_{noise,total} = P_{noise,ADC} + P_{noise,jitter}$$

**Conversion from dB to Linear:**
$$SNR_{linear} = 10^{SNR_{dB}/10}$$

**Convert Back to dB:**
$$SNR_{dB} = 10 \\log_{10}(SNR_{linear})$$

## Engineering Interpretation
- Jitter budgeting must include:
  - Clock source jitter
  - PLL additive jitter
  - ADC aperture jitter
  - Power supply noise-induced jitter

# References

- [Analog Devices MT-007](https://www.analog.com/media/en/training-seminars/tutorials/MT-007.pdf)
- [Texas Instruments SBAA147](https://www.ti.com/lit/an/sbaa147b/sbaa147b.pdf?ts=1776873829321)
