# Gamma Spectrometer

**This project is unfinished.**

## Principle of operation

The Gamma Spectrometer enables quantitative analysis of different isotopes within a sample. It operates using a scintillator, a material that converts incoming gamma radiation into visible photons, and a photomultiplier tube (PMT), which amplifies the photons and converts them into electrical pulses. By analyzing the amplitude of these pulses, the energy of the original gamma rays that produced the pulses can be accurately deduced.

By sampling data over a period of time and plotting the resulting histogram, the system is capable of identifying the specific radioactive isotopes present in the sample and their relative abundances.

## System architecture

The system is designed for remote operation, allowing it to function independently of a direct connection to the user’s PC, such as via a USB cable.

<img src="./Documentation/Diagrams/ArchitectureOverview.svg"  width="100%">


## Overview of the mechanical design

![render of the device](./Documentation/Pictures/render_28_10_2020.png)


On the left side of the image, you can see a shield designed for the photomultiplier tube. This shield is essential for protecting the detector from external light sources and electromagnetic interference (EMI). The detector is connected to a small PCB, located in the center, which contains the circuitry for polarizing the tube and various connectors.

On the right side, the lower section displays the shield for the high-voltage generator, while the upper section reveals the shield for data acquisition.

The parts for 3D printing, along with the full model of the device, were created using OpenSCAD. For further details, [see the mechanical overview](./Mechanic/MechanicOverview/README.md). The above render was produced in Blender.


## Hardware

* [Photomultiplier principles](./Hardware/README.md)
* [Acquisition and HV power supply](./Hardware/GammaSpectrometer/README.md). Note: values of elements were calculated using model made in Octave [[more info]](./Simulation/Octave/README.md).

PCBs were designed in KiCAD.

## Software

For more information about the software architecture, [see the UMLs I made](./Documentation/UML/README.md).

## Hazards

**This device operates at high voltage. Although the maximum current is limited, it still presents a potential health risk.**
