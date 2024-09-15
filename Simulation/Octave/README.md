# HVPowerSupplyElementsCalculator

## Summary

Simulation and calculation of HV DC/DC converter that powers PHT. Details are in comments in the code.

Calculations are based on:
- [Flyback Converter Design](http://www.simonbramble.co.uk/dc_dc_converter_design/flyback_converter/flyback_converter_design.htm).
- [Voltage divider](https://en.wikipedia.org/wiki/Voltage_divider) - feedback voltage divider.
- [What is the transformer inductance ratio? How is it determined?](https://www.quora.com/What-is-the-transformer-inductance-ratio-How-is-it-determined) - inductance of the secondary transformer winding.
- [SMPSChart](https://www.we-online.fr/web/fr/index.php/show/media/07_electronic_components/news_1/blog/midcom_blog_photos/SMPSChart.pdf) - efficiency of the converter.
- [Flyback Switchmode PSU for Powering Legacy Equipment 
](http://www.g4jnt.com/HV_SMPSU.pdf) - calculating minimum turns on primary side of transformer.
- [Input and Output Capacitor Selection](https://www.ti.com/lit/an/slta055/slta055.pdf?ts=1605600750266) - calculating input bulk and ceramic capacitors.


## Usage

In command line, in this directory execute:

```octave-cli HVPowerSupplyElementsCalculator.m```

The script will print results of calculations.
<<<<<<< HEAD
=======

Note: script mixes different unit prefixes but this inconsistency is already present in the datasheet, so I stick to it.
>>>>>>> f43d284 (Fix grammar mistakes (found by Code Spell Checker add-on in VSCode). (fix #62))

## Results

```

```