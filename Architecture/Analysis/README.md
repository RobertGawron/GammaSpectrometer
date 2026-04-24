LTspice Circuit Simulation
Portions of the analog front-end are modeled and simulated in LTspice. These simulations include:

Charge-sensitive amplifier behavior
Transient response and pulse shaping
Stability verification
Noise analysis (spectral and RMS)
Bandwidth and filtering effects
LTspice is used to validate that the implemented circuit corresponds to the theoretical equations defined in the system documentation.

Numerical Post-Processing and System Analysis (Jupyter)
Simulation results may be exported and analyzed in a Docker-based Jupyter Notebook environment. This enables:

Numerical post-processing of waveform data
Noise integration and spectral analysis
Parametric sweeps and sensitivity analysis
System-level performance evaluation (e.g., ENOB, SNR, ENC)
Generation of publication-quality plots
Jupyter is used as a controlled computational environment for analytical validation and reproducible system analysis.
