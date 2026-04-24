# System Theory

## Purpose
This folder contains the theoretical foundation for the SiPM-based gamma spectrometer.

It defines the mathematical models, signal relationships, and performance limits governing the detector, analog front-end (AFE), clocking, and ADC stages.

---

## Document Structure

* [SiPM and Charge Amplifier Readout](./SiPMAndCSA.md) - defines the detector and analog front-end signal model.
  * SiPM gain and charge generation: $$Q_{total} = N \cdot G \cdot q_e$$
  * Equivalent SiPM capacitance ($C_{SiPM}$)
  * Microcell recharge time constant ($\tau_{cell}$)
  * Charge-to-voltage conversion: $$V_{out} = \frac{Q_{in}}{C_f}$$
  * Feedback component relationships ($R_f, C_f$)

* [Analog Noise Analysis and Energy Resolution](./AnalogNoiseAnalysis.md) - defines the system noise budgeting methodology.
  * RMS noise definition and spectral density integration: $$V_{rms} = \sqrt{\int S_v^2(f) \, df}$$
  * Differential noise treatment
  * Input-referred noise (CSA and TIA)
  * Equivalent Noise Charge (ENC)
  * Root-sum-square (RSS) noise combination
  * ENOB conversion from SNR: $$ENOB = \frac{SNR - 1.76}{6.02}$$
  * Impact of electronic noise on energy resolution

* [Clock Jitter and SNR Limitation](./ClockJitterAnalysis.md) - defines timing-related performance limitations.
  * RMS jitter definition ($\sigma_t$)
  * Jitter-induced amplitude error derivation
  * Jitter-limited SNR equation: $$SNR_{jitter} = -20 \log_{10}(2\pi f_{in} \sigma_t)$$
  * ENOB relationship
  * Combination of multiple jitter sources (RSS combination)

* [ENOB and ADC Performance Limitations](./ENOBAndADCPerformance.md) - defines ADC-driven system constraints.
  * Ideal quantization SNR: $$6.02N + 1.76$$
  * Practical ENOB limits based on datasheet SNR
  * Margin definition ($\Delta$) for system design
  * Derivation of allowable noise from ENOB target: $$V_{noise,max} = \frac{V_{signal,rms}}{10^{SNR/20}}$$
