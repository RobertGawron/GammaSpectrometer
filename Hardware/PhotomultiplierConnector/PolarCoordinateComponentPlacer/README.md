# PolarCoordinateComponentPlacer

## Purpouse

KiCad can't place elements using polar coördinates, but photomultiplier tube pins are arranged around circle (like any other normal lamp pins). This is problematic because components for polarisation should be placed as close to photomultiplier  tube as possible.

Here a workaround was made in Python (using pcbnew library). The script (./PolarCoordinateComponentPlacer.py) arranges components in a proper way.

Note: pcbnew is not so easy library as it seems, also it lacks documentation and is basically only a wrapper for internal KiCad engine.

Note: originally it was planed that the PCB will have circular shape (two circles, each for one photomultiplier tube, connected in middle where would be placed connectors to data acquisition and high voltage generator). It looked as a good idea, but to calculate those edge cuts, a bit of trigonometry was needed and... floating points errors... It was a bad idea and a massive overengineering.

## Usage

- Open ../PhotomultiplierConnector.kicad_pcb using KiCad
- Delete photomultipliers and PCB edges
- Save ../PhotomultiplierConnector.kicad, close KiCad
- Run PolarCoordinateComponentPlacer.py script

Note: use Python provided with your KiCad installation. On my PC it's C:\Program Files\KiCad\bin\python.exe
