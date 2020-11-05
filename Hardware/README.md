## Power supply for photomultiplier tube

- Tubes require around 1000V-1200V DC [[example datasheet #1]](https://datasheetspdf.com/pdf-file/95080/HamamatsuCorporation/1P28/1), [[example datasheet #2]](https://datasheetspdf.com/pdf-file/959054/HAMAMATSU/R10699/1).


- There are two main ways to apply the voltage to cathode and anode [[see paragraph 5.1.1]](http://lmu.web.psi.ch/docu/manuals/bulk_manuals/PMTs/Photonis_PM-Handbook.pdf):
    * positive polarity, cathode earthed and the anode at high positive potential - used in pulse counting
    * negative polarity, anode earthed and the cathode at high negative potential - continuous mode, detailed pulse analysts (as in spectrometer)

- There are two main ways to apply voltage to dynodes:
   * Apply it between anode and cathode, and use resistor dividers to provide required voltage for dynodes. Good thing is that each dynode can be at different voltage.
   * Start with much smaller voltage, apply it to electrode, multiply it [(Cockcroft–Walton generator)](https://en.wikipedia.org/wiki/Cockcroft%E2%80%93Walton_generator), applying it to first dynode, second dynode.. until reach last electrode. [[example design #1]](https://arxiv.org/pdf/1606.00649.pdf), [[example design #2]](https://indico.cern.ch/event/83060/contributions/2101687/attachments/1069924/1525757/Presentation_TWEPP.pdf). Good thing is that less power is dissipated as heat.

Negative polarity + Cockcroft–Walton generator looks like a good choose.

## Monitoring value of tube's polarization voltage

This needs to be added to the design. Use microcontroller's ADC?

## Setting value of tube's polarization voltage

This needs to be added to the design. Use microcontroller's DAC?

## Microcontroller

Arduino Uno

## User Interface

Arduino Uno 2.4 inch TFT LCD Shield
