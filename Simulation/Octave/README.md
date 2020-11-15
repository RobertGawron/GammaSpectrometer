# HVPowerSupplyElementsCalculator

## Summary

Simulation and calculation of HV DC/DC converter that powers PHT. Details are in comments in the code.

Calculations are based on:
- [Flyback Converter Design](http://www.simonbramble.co.uk/dc_dc_converter_design/flyback_converter/flyback_converter_design.htm).
- [Voltage divider](https://en.wikipedia.org/wiki/Voltage_divider) - feedback voltage divider.
- [What is the transformer inductance ratio? How is it determined?](https://www.quora.com/What-is-the-transformer-inductance-ratio-How-is-it-determined) - inductance of the secondary transformer winding.
- [SMPSChart](https://www.we-online.fr/web/fr/index.php/show/media/07_electronic_components/news_1/blog/midcom_blog_photos/SMPSChart.pdf) - efficiency of the converter.

## Usage

In command line, in this directory execute:

```octave-cli HVPowerSupplyElementsCalculator.m```

The script will print results of calculations.

## Results

```

```