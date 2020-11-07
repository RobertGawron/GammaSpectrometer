# HighVoltagePowerSupply

## Architecture Overview of High Voltage Power Supply

<img src="../../Documentation/Diagrams/ArchitectureHighVoltagePowerSupply.svg"  width="100%">

## Assumptions

- All elements in Cockcroft–Walton generator should be rated 150V or more.
- All resistors in voltage divider should be rated 150V or more and have the same temperature coefficient.
- op-amp should be input/output rail to rail, low noise, low input bias currents, unity gain (e.g. [MCP6V51](https://ww1.microchip.com/downloads/en/DeviceDoc/MCP6V51-Data-Sheet-DS20006136A.pdf))

