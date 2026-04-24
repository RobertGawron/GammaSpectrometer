## Purpose
Validate that the device meets system requirements before electrical design finalization and hardware assembly.

## Requirements
* LTspice installed on the host machine
* [Docker environment properly configured](../../DevOps/README.md)

## Workflow
* Modify or run LTspice simulations.
* Execute analysis scripts using the Jupyter Notebook environment.
* Compare results against defined system requirements.
* System Verification Workflow


![System Verification Workflow](../../Documentation/Diagrams/SystemVerificationWorkflow.svg)

## LTspice–Jupyter Execution Matrix
Matrix defining which LTspice models must be executed prior to running specific Jupyter analysis notebooks.






|                                   | AFE/TbACGain | AFE/TbNoise | AFE/TbOutputLoad | AFE/TbTransientPulseFast | AFE/TbTransientPulseSlow | Power/SiPMBiasInitial | Power/TemperatureCompensation | Protection |
| :-------------------------------- | :----------- | :---------- | :--------------- | :----------------------- | :----------------------- | :-------------------- | :---------------------------- | :--------- |
| **AnalogNoise**                   |              | run         |                  |                          |                          |                       |                               |            |
| **Bandwidth/Frequency**           | run          |             |                  |                          |                          |                       |                               |            |
| **Bandwidth/Time**                |              |             |                  | run                      |                          |                       |                               |            |
| **DigitalTiming**                 |              |             |                  |                          |                          |                       |                               |            |
| **DynamicRange**                  |              |             |                  |                          |                          |                       |                               |            |
| **Jitter**                        |              |             |                  |                          |                          |                       |                               |            |
| **Linearity**                     |              |             |                  |                          | run                      |                       |                               |            |
| **Power/Initial**                 |              |             |                  |                          |                          |                       |                               |            |
| **Power/TemperatureCompensation** |              |             |                  |                          |                          |                       |                               |            |
| **ReferenceStability**            |              |             |                  |                          |                          |                       |                               |            |
| **Thermal**                       |              |             |                  |                          |                          |                       |                               |            |
