# HVPowerSupplyElementsCalculator

## Summary

Simulation and calculation of **LT3580IMS8E#PBF** used as HV DC/DC converter that powers photomultiplier tube.

[Datasheet LT3580IMS8E#PBF](https://www.tme.eu/Document/68ac11f4f26b33b9606fcb99dec7a7aa/LT3580IMS8EPBF.pdf)

## Usage

In command line, in this directory execute:

```octave-cli HVPowerSupplyElementsCalculator.m```

The script will print results of calculations.

## Assumed constants

### User constant parameters

- LT3580IMS8E#PBF clock frequency = 800kHz (variable: f_osc)
- Photomultiplier's cathode voltage = 1.2kV (variable: v_cathode)
- Input power supply = 12V (variable: v_in)
- i_out = 20e-3;
- v_divider = 2.5;
- Upper resistor in feedback voltage divider = 500 MOhn (variable: r_divider_top; resistorsR25, ..., R30 on schematic)

### Chip constant parameters

- Minimum off time of LT3580IMS8E internal transistor that drives transformer = 60ns (variable: minimum_off_time)
- diode forward voltage drop = 600mV (variable: v_d)
- Vcesat = 300mV (variable: v_cesat)
- Diode forward voltage drop 600e-3 (variable: v_d), note: what exactly diode? 
- Power conversion efficiency = 0.88 (variable n), note: it might be smaller.
- Minimum current ripple = 98e-3 (variable: i_min_riple )
- switch current limit 2.4 (variable: i_lim), note: it might be smaller.

## Formulas

### Resistor that sets clock frequency, R15 on schematic

```r_t = ((91.9 / (f_osc / 1e6)) - 1) * 1e3```

Source: datasheet (section "Oscillator").

**Note: calculation r_t in "TYPICAL APPLICATION" section in datasheet, doesn't work correctly. There is an error somewhere.**

### Resistor that sets voltage feedback, R16+R32 on schematic.

```r_fb = |v_out - 1.215V| / 83.3uA```

Source: datasheet (section "Setting Output Voltage").

### Bottom resistor in voltage divider for LT3580IMS8E FB pin, R17+R18 on schematic.

```r_divider_bottom = r_divider_top * (1 / ((v_cathode / v_divider) - 1))```

Source: [voltage divider formula](https://en.wikipedia.org/wiki/Voltage_divider).

### Maximum allowable duty cycle of LT3580IMS8E internal transistor that drives transformer

```duty_cycle_max = ((t_p - minimum_off_time) / t_p) * 100%```

```t_p = 1 / f_osc```

Source: datasheet (section "Power Switch Duty Cycle").

### Actual duty cycle of LT3580IMS8E internal transistor that drives transformer

```duty_cycle = (v_out - v_in + v_d) / (v_out + v_d - v_cesat)```

Source: datasheet (section "Power Switch Duty Cycle").

### Minimum transformer inductance, TR1 on schematic

```l = d_c * v_in / (2 * f * (i_lim - (|v_out| * i_out)/(v_in * n)))```

Source: datasheet (section "Adequate Load Current").

### Minimum transformer inductance to avoid subharmonic oscillations, TR1 on schematic

```l_min_to_avoid_subharmonic = v_in * ((2 * duty_cycle) - 1) / ((1 - duty_cycle) * f_osc)```

Source: datasheet (section "Avoiding Subharmonic Oscillations").

### Maximum transformer inductance, TR1 on schematic

```l_max = ((v_in - v_cesat)/(i_min_riple)) * (duty_cycle / f_osc)```

Source: datasheet (section "Maximum Inductance").

### Calculate maximum transformer current, TR1 on schematic

```l1 = l_min_to_avoid_subharmonic```

```i_peak = |v_out * i_out| / (v_in * n) + (v_in * duty_cycle)/(2 * l1 * f_osc)```

Source: datasheet (section "Current Rating").

Note: I'm not sure about l1 value.


## Results

```
-------- 2020-11-06 14:07:56 --------

-------- User constant parameters:
f_osc: 800000.000 Hz
v_in: 12.000 V
v_cathode: 1.200e+03 V
v_cathode: 2.000e-02 V
v_divider: 2.500e+00 V
r_divider_top: 5.000e+08 Ohm

-------- Calculated parameters:
duty_cycle_max: 9.520e-01 s
duty_cycle: 8.833e-01 s
r_t: 1.149e+05 Ohm
r_fb: 1.186e+06 Ohm
v_divider: 2.500e+00 V
r_divider_bottom: 1.044e+06 Ohm
l_min: 2.997e-06 H
l_min_to_avoid_subharmonic: 9.859e-05 H
l_max: 1.318e-04 H
i_peak: 2.566e-01 A
-------------------------------------
```