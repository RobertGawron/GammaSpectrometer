# LTspice simulations

## Purpose

Simulate parts of the circuit to find bugs before real design and assembly.

## Tools

LTspice download URL: https://www.analog.com/en/resources/design-tools-and-calculators/ltspice-simulator.html

Notes:

* LTspice works on Windows and macOS natively but can be launched on Linux using Wine as well.
* Maybe KiCad could be used as well (it has a simulation option in recent releases), but since LTspice is an industry standard, I will stick to it.

## Project Structure

```
.
├── Library/
│   ├── Datasheets/          # Component datasheets (PDF)
│   ├── Models/              # SPICE models (.cir, .lib, .sub)
│   │   ├── DigitalICs/
│   │   ├── Discrete/
│   │   ├── OpAmps/
│   │   └── Passives/
│   └── Symbols/             # Custom LTspice symbols (.asy)
│
├── Results/
│   ├── Measurements/        # Exported measurement data
│   ├── Reports/             # Simulation reports
│   └── Waveforms/           # Saved waveform plots
│
├── Schematics/              # Main circuit schematics (.asc)
│
├── Scripts/                 # Automation scripts
│
├── Verification/
│   ├── ComponentTests/      # Individual component test circuits
│   └── ValidationReports/   # Test results and validation docs
│
└── README.md
```
