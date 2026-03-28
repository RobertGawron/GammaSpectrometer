# Silicon Photomultiplier Gamma Spectrometer

[![Formal Verification](https://github.com/RobertGawron/GammaSpectrometer/actions/workflows/formal-verify.yml/badge.svg)](https://github.com/RobertGawron/GammaSpectrometer/actions/workflows/formal-verify.yml) [![Unit Tests](https://github.com/RobertGawron/GammaSpectrometer/actions/workflows/unit-tests.yml/badge.svg)](https://github.com/RobertGawron/GammaSpectrometer/actions/workflows/unit-tests.yml) [![Build Firmware](https://github.com/RobertGawron/GammaSpectrometer/actions/workflows/build-firmware.yml/badge.svg)](https://github.com/RobertGawron/GammaSpectrometer/actions/workflows/build-firmware.yml)

## Principle of operation

This device allows for the quantitative measurement of the amount of different isotopes in an analyzed sample.

It consists of a scintillator (a material that converts gamma particles into photons) and a photomultiplier that multiplies those photons and converts them into electric current pulses. By measuring the amplitude of these pulses, it is possible to calculate the original energy of the gamma ray that produced the pulse.

Sampling data over time and plotting its histogram reveals which radioactive isotopes are present in the measured sample and their respective ratios.

## Design Philosophy

### Silicon Photomultiplier vs Traditional PMT

Traditional gamma spectrometers use vacuum photomultiplier tubes (PMT) that require high voltage (1-2kV), are fragile, bulky, and sensitive to magnetic fields.

This project uses a **Silicon Photomultiplier (SiPM)** - a modern solid-state alternative that solves the mentioned issues of PMTs.

### Digital vs Analog Processing

Traditional spectrometers use analog CR-RC pulse shaping circuits and peak detectors. 

Thanks to modern ADCs and FPGAs, it is possible to do all of this in software, making modifications much easier. The disadvantage is that the project is more costly due to higher requirements for the ADC and FPGA.

## Hardware

![Architecture Overview](./Documentation/Diagrams/ArchitectureOverview.svg)

The hardware consists of three PCBs:

### Data Acquisition Unit

Handles low-level currents produced by the sensor (typically 1µA - 1mA 
pulses, 10mV - 1V after amplification):


* **[NaI(Tl) Scintillator Crystal](https://www.ost-photonics.com/product/diameter-1-inch-x-1-inch-naitl-scintillator/)** - Converts gamma rays into visible light pulses through scintillation
* **Silicon Photomultiplier ([MICROFC-60035-SMT-TR1 SiPM](https://www.onsemi.com/pdf/datasheet/microc-series-d.pdf))** - Converts light pulses from the scintillator crystal into electrical current pulses
* **Transimpedance Amplifier ([LTC6268](https://www.analog.com/media/en/technical-documentation/data-sheets/62689f.pdf))** - Amplifies current pulses from SiPM and converts to voltage
* **Differential ADC Driver ([AD8139](https://www.analog.com/media/en/technical-documentation/data-sheets/AD8139.pdf))** - Shifts the signal to +1v5 common-mode voltage required by the ADC
* **Temperature Sensing (TBD)** - Monitors SiPM temperature for bias compensation
* **Bias Supply ([TPS7A4901](https://www.ti.com/lit/ds/symlink/tps7a49.pdf?ts=1774505770499))** - Provides stable, filtered 29V bias voltage for the SiPM, automatically adjusted for SIPM's temperature changes
* **Overcurrent Protection (TBD)** - Cuts bias voltage if SiPM is exposed to external light source, preventing sensor damage from excessive photocurrent

> **Note:** Analog pulse shaping and peak detection are not used - raw signal is digitized directly and processed in FPGA.

[More info.](./Hardware/DataAcquisitionUnit/)

### Data Processing Unit

Handles high-speed data processing and provides power for all nodes:

- **ADC ([AD9226](https://www.analog.com/media/en/technical-documentation/data-sheets/ad9226.pdf))** - 12-bit, 65 MSPS sampling rate, produces 780 Mbps (97 MB/s) of raw data
- **FPGA ([iCE40HX4K](https://www.latticesemi.com/en/Products/FPGAandCPLD/iCE40#_21E33C7EC0BD48AA80FE384ED73CC895))** - Real-time digital pulse processing (trapezoidal filtering, peak detection, histogram generation)
- **SPI Flash (TBD)** - Stores FPGA configuration bitstream
- **SPI Port** - External header for FPGA programming
- **UART to USB Converter (TBD)** - Communication interface to PC.

[More info.](./Hardware/DataProcessingUnit/)

### Main Board

Provides mechanical and electrical connections between the two boards above, power distribution and external interfaces (Power and USB socket).

[More info.](./Hardware/MainBoard/)

Tools: KiCad.

## Software

The project is developed using a **completely open-source FPGA toolchain**. The RTL code is written in VHDL-2008, synthesized with [Yosys](https://github.com/YosysHQ/yosys) + [GHDL](https://github.com/ghdl/ghdl), and targets iCE40 FPGAs via [nextpnr](https://github.com/YosysHQ/nextpnr). All code is **formally verified** using [SymbiYosys](https://github.com/YosysHQ/sby) with PSL assertions and **unit tested** using the [VUnit](https://vunit.github.io/) framework.

The entire toolchain is containerized in a Docker image.

[More info.](./Software/)

## Mechanical

The analog frontend requires a metal chassis for protection from electromagnetic interference and external light sources.

The scintillator crystal is mounted inside using a 3D-printed stand.

The crystal and SiPM are optically coupled using optical gel to minimize light pulse reflections at the interface

Tools: OpenSCAD and FreeCAD.

[More info.](./Mechanic/)

## Simulation

### LTspice

* Simulation: [Parts of the electronic circuit are simulated](./Simulation/LTspice/) in LTspice.
* Visualization (optional): The results can be either observed in LTspice or [imported into a Docker-based Jupyter Notebook.](./Simulation/JupyterLab/) This allows for further simulation analysis (although it's not really used for now). Also, the graphs are more aesthetic this way.

## DevOps

[More info.](./DevOps/)
