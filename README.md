# PIN Photodiode Gamma Spectrometer

**This project is unfinished.**

## Principle of operation

This device allows for the quantitative measurement of the amount of different isotopes in an analyzed sample.

It consists of a scintillator (a material that converts gamma particles into photons) and a photomultiplier tube that multiplies those photons and converts them into electric current pulses. By measuring the amplitude of these pulses, it is possible to calculate the original energy of the gamma ray that produced the pulse.

Sampling data over time and plotting its histogram reveals which radioactive isotopes are present in the measured sample and their respective ratios.

## Hardware

![Architecture Overview](./Documentation/Diagrams/ArchitectureOverview.svg)

Tools: KiCad.

## Software

TBD

## Mechanical

Tools: OpenSCAD and FreeCAD.

## Simulation

* Parts of the electronic circuit were simulated using LTspice, [click here for more details](./Simulation/LTspice/README.md).

## DevOps

TBD

## Hazards

The sensor polarization voltage is 70V. Although the maximum output current is very low, it could still pose a safety risk.
