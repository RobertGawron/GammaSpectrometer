## Photomultiplier Tube (PHT) and Scintillation Crystal selection


[R1450](https://www.hamamatsu.com/resources/pdf/etd/R1450_TPMH1215E.pdf) will be used.

Sodium Iodide Crystal will be used. Plastic "crystals" are cheaper, but have poor pulse height resolution. Other crystals are better but much harder to obtain and more expensive.

TBD optical grease.

## Power supply for photomultiplier tube

- PHT needs around 1000V-1200V DC [[example datasheet #1]](https://datasheetspdf.com/pdf-file/95080/HamamatsuCorporation/1P28/1), [[example datasheet #2]](https://datasheetspdf.com/pdf-file/959054/HAMAMATSU/R10699/1). Higher voltages increases sensitivity and decreases lifetime.


- There are two main ways to apply the voltage to cathode and anode [[see paragraph 5.1.1]](http://lmu.web.psi.ch/docu/manuals/bulk_manuals/PMTs/Photonis_PM-Handbook.pdf):
    * positive polarity, cathode earthed and the anode at high positive potential - used in pulse counting
    * negative polarity, anode earthed and the cathode at high negative potential - continuous mode, detailed pulse analysts (as in spectrometer)

- There are two main ways to apply voltage to dynodes:
   * Apply it between anode and cathode, and use resistor dividers to provide required voltage for dynodes. Good thing is that each dynode can be at different voltage. Power consumption can be decreased using active lader of transistors [[example design #1]](https://www.osti.gov/servlets/purl/1117124)
   * Start with much smaller voltage, apply it to electrode, multiply it [(Cockcroft–Walton generator)](https://en.wikipedia.org/wiki/Cockcroft%E2%80%93Walton_generator), applying it to first dynode, second dynode.. until reach last electrode. [[example design #1]](https://arxiv.org/pdf/1606.00649.pdf), [[example design #2]](https://indico.cern.ch/event/83060/contributions/2101687/attachments/1069924/1525757/Presentation_TWEPP.pdf). Good thing is that less power is dissipated as heat.

Negative polarity + active lader of transistors looks like a good choose.

## Monitoring/Setting PHT polarization voltage, monitoring of input current of HV Power Supply

ADC on microcontroller will be used.

## Microcontroller

[PIC32MZ0512EFE064-I/PT](https://www.mouser.com/datasheet/2/268/PIC32MZ-EF-_Family-DS60001320F-1545741.pdf)

## User Interface

None, communication will be done via UART over USB.

## PMT protection

A photodiode will be placed in PMT enclosure, HV Power Supply should operate only if PMT is in complete dark (sensed by photodiode).

## Unknowns

- How to set C+R values in charge amplifier?
- Is the microcontroller sufficient in processing power?
- Noise (dark current) needs more analysis
