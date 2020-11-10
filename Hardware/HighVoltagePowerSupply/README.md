# HighVoltagePowerSupply

## Architecture Overview of High Voltage Power Supply

<img src="../../Documentation/Diagrams/ArchitectureHighVoltagePowerSupply.svg"  width="100%">

## Assumptions

- All elements in Cockcroft–Walton generator should be rated 150V or more.
- All resistors in voltage divider should be rated 150V or more and have the same temperature coefficient.
- op-amp should be input/output rail to rail, low noise, low input bias currents, unity gain (e.g. [MCP6V51](https://ww1.microchip.com/downloads/en/DeviceDoc/MCP6V51-Data-Sheet-DS20006136A.pdf))

## PCB clearance 

Calculations based on[IPC-2221A](http://www-eng.lbl.gov/~shuman/NEXT/CURRENT_DESIGN/TP/MATERIALS/IPC-2221A(L).pdf#page=52&zoom=100,0,0), Table 1-6.

Voltage between n electrode and n+1 is around 110V, device will not be used above 3050m above see level. Looking on mentioned table, column B2, row 101-150V, the clearance should be at least 0.6mm.

Distance  between each multiplier stage and ground :

1100V - 500V = 600V
0.25 mm + (600V * 0.0025 mm) = 
0.25  + (600 * 0.0025) = 1.75mm

## Transformer

Transformer should be shielded (to avoid EMI), turns ratio 1:10.

I've choose [GA3459-BL](http://www.farnell.com/datasheets/1870439.pdf), alternative that I was considering too was [ATB322515](https://product.tdk.com/info/en/catalog/datasheets/trans_atb3225_en.pdf).

Search on the Internet for "capacitor charger transformer" or "photoflash transformer" to see similar transformers.

