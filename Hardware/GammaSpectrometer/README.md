# GammaSpectrometer Main Board (Data Acquisition + High Voltage Power Supply)

## Data Acquisition

### Architecture

<img src="../../Documentation/Diagrams/ArchitectureDataAcquisition.svg"  width="100%">

### Assumptions

1 Msps, 16bit ADC will be used [MCP33131-10](https://www.tme.eu/Document/a5a4283a1bfa7721eddf2e7bc5de5352/MCP33131-MCP33121-MCP33111.pdf)

Least significant bit (LSB) voltage:

```Q = 2.5V / (2^16) = 35uV```

## High Voltage Power Supply

## Architecture

<img src="../../Documentation/Diagrams/ArchitectureHighVoltagePowerSupply.svg"  width="100%">

<!--
## Render of the PCB

![render of the device](../../Documentation/Pictures/render_10_11_2020.png)
-->

### Assumptions

Topology: Flyback
Mode: Discontinuous Conduction Mode

All resistors in voltage divider should be rated 150V or more and have the same temperature coefficient.


### PCB clearance for High Voltage tracks

Calculations based on [IPC-2221A](http://www-eng.lbl.gov/~shuman/NEXT/CURRENT_DESIGN/TP/MATERIALS/IPC-2221A(L).pdf#page=52&zoom=100,0,0), Table 1-6.


1100V - 500V = 600V
0.25 mm + (600V * 0.0025 mm) = 
0.25  + (600 * 0.0025) = 1.75mm
