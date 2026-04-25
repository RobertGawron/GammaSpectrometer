# Silicon Photomultiplier Gamma Spectrometer

[![Formal Verification](https://github.com/RobertGawron/GammaSpectrometer/actions/workflows/formal-verify.yml/badge.svg)](https://github.com/RobertGawron/GammaSpectrometer/actions/workflows/formal-verify.yml) [![Unit Tests](https://github.com/RobertGawron/GammaSpectrometer/actions/workflows/unit-tests.yml/badge.svg)](https://github.com/RobertGawron/GammaSpectrometer/actions/workflows/unit-tests.yml) [![firmware-build](https://github.com/RobertGawron/GammaSpectrometer/actions/workflows/firmware-build.yml/badge.svg)](https://github.com/RobertGawron/GammaSpectrometer/actions/workflows/firmware-build.yml)

## Principle of operation

Gamma Spectrometer allows for the quantitative measurement of the amount of different isotopes in an analyzed sample.

It consists of a scintillator (a material that converts gamma particles into photons) and a photomultiplier that multiplies those photons and converts them into electric current pulses. By measuring the amplitude of these pulses, it is possible to calculate the original energy of the gamma ray that produced the pulse.

Sampling data over time and plotting its histogram reveals which radioactive isotopes are present in the measured sample and their respective ratios.

[More info.](./Documentation/Theory/README.md)

## Design rationale

### Silicon photomultiplier vs traditional PMT

Conventional gamma spectrometers commonly use vacuum photomultiplier tubes (PMTs). These require high-voltage supplies in the kilovolt range, are mechanically fragile, and are sensitive to magnetic fields.

In this project, a Silicon Photomultiplier (SiPM) is used instead. The SiPM operates at significantly lower bias voltage (tens of volts rather than kilovolts), is mechanically robust, compact, and insensitive to magnetic fields. These characteristics simplify the power supply design and mechanical integration.

### Digital vs analog processing

Traditional spectrometers implement CR-RC shaping networks and peak detection entirely in analog hardware. This approach is cost-effective but offers limited flexibility, as parameter changes require hardware modification.

In this system, pulse shaping and peak detection are performed digitally after high-speed sampling. This increases flexibility and allows signal processing parameters to be modified in firmware without hardware changes. The trade-off is higher performance requirements for the ADC and the need for an FPGA rather than a microcontroller, which increases overall system cost.

## Hardware

![Architecture Overview](./Documentation/Diagrams/ArchitectureOverview.svg)

Tools: KiCad.

[More info.](./Hardware/Design/README.md)

## Hardware design verification

Hardware design analysis is performed using LTspice for circuit simulation and a Jupyter-based framework for numerical post-processing. These tools are used to validate the interaction between the SiPM, the analog front-end, and the system timing behavior before to PCB design. The goal is to verify theoretical models, evaluate noise and bandwidth limitations, and confirm that design requirements are satisfied.

[More info.](./Hardware/DesignVerification/README.md)

## Software

Target FPGA: iCE40.

The project is developed using a **completely open-source** FPGA toolchain containerized in Docker.

* RTL Language: VHDL‑2008
* Synthesis: [Yosys](https://github.com/YosysHQ/yosys), [GHDL](https://github.com/ghdl/ghdl)
* Place & Route: [nextpnr](https://github.com/YosysHQ/nextpnr)
* Formal Verification: [SymbiYosys](https://github.com/YosysHQ/sby), PSL assertions
* Unit Testing Framework: [VUnit](https://vunit.github.io/)

[More info.](./Software/README.md)

## Mechanical

The analog frontend requires a metal chassis for protection from electromagnetic interference and external light sources.

The scintillator crystal is mounted inside using a 3D-printed stand.

The crystal and SiPM are optically coupled using optical gel to minimize light pulse reflections at the interface

Tools: OpenSCAD and FreeCAD.

[More info.](./Mechanic/README.md)

## DevOps

The development environment is containerized using Docker to avoid polluting the host machine with all the necessary software. The only two software tools that are not containerized are LTspice and KiCad.

[More info.](./DevOps/README.md)
