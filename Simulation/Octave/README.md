# HVPowerSupplyElementsCalculator

## Summary

Simulation and calculation of **LT3580IMS8E#PBF** used as HV DC/DC converter that powers photomultiplier tube.

[Datasheet LT3580IMS8E#PBF](https://www.tme.eu/Document/68ac11f4f26b33b9606fcb99dec7a7aa/LT3580IMS8EPBF.pdf)

## Usage

In command line, in this directory execute:

```octave-cli HVPowerSupplyElementsCalculator.m```

The script will print results of calculations.

Note: script mixes different unit prefixes but this inconsistency is already present in the datasheet, so I stick to it.

## Assumed constants

### Mode constants

- Input power supply = 12V (variable: power_supply_voltage)
- Photomultiplier's cathode voltage = 1.2kV (variable: v_cathode)
- Upper resistor in feedback voltage divider = 500 MOhn (variable: r_divider_top. resistorsR25, ..., R30 on schematic)
- DC/DC clock frequency = 0.8 Mhz (variable: f_osc)
      
### Formula to calculate r_t 

It's resistor that sets clock frequency, R15 on schematic.

```r_t = (91.9 / f_osc) - 1```

Units:

- r_t: kOhm
- f_osc: Mhz

Source: datasheet.

### Formula to calculate r_fb 

It's resistor that sets voltage feedback, R16 on schematic.

```r_fb = |v_out - 1.215V| / 83.3uA```

Units:

- r_fb: Ohm
- v_out: V

Source: datasheet.

### Formula to calculate v_divider 

It's the voltage on an output of feedback resistor divider, label V_DIVIDER on schematic.

Keep the op-amp happy, so that input voltage doesn't go too high.

```v_divider = power_supply_voltage / 2```

Units:

- v_divider: V
- power_supply_voltage: V

Source: me :-)

### Formula to calculate r_divider_bottom

Bottom resistor in feedback voltage divider, R17+R18 on schematic.

```r_divider_bottom = r_divider_top * (1 / ((v_cathode / v_divider) - 1))```

Units:

- r_divider_top: Ohm
- r_divider_bottom: Ohm
- v_cathode: V
- v_divider: V

Source: [voltage divider formula](https://en.wikipedia.org/wiki/Voltage_divider).
