# Purpose

TBD

# Circuit

![](./GammaSpectrometer.svg)
![](./GammaSpectrometer-SiPMBiasRegulator.svg)
![](./GammaSpectrometer-SiPMOverlightProtection.svg)
![](./GammaSpectrometer-AFE.svg)
![](./GammaSpectrometer-ExternalConnector.svg)

# Simulated data

Max safe voltage = 24.2V (min Vbr) + 5.0V = 29.2V

ADC: 0V -> 4.5V (simulating 20degC → 35degC)

LDO: 28.89V -> 29.22V (+322.5mV over 15degC)

Expected slope: 322.5mV / 4.5V = 71.7 mV/V

![Output of the DC/DC Converter](../../Simulation/JupyterLab/Outputs/DcDcOutput.png)

![Full Output of the Linear Regulator](../../Simulation/JupyterLab/Outputs/LinearRegulatorOutputFull.png)

![Last 10ms of output of the DC/DC COnverter](../../Simulation/JupyterLab/Outputs/LinearRegulatorOutputLast10ms.png)

![Last 10ms of output of the DC/DC COnverter](../../Simulation/JupyterLab/Outputs/TemperatureAdjustmentTimeDomain.png)
