# Purpose

The 3D printed holder needs to:
* Attach the grid of scintillator crystals to the PCB in a way that maximizes surface contact with the SiPM detectors
* Attach reflection pads to the sides of the scintillator crystals to maximize photons deposited on the SiPMs
* Provide space for optical gel between the scintillator crystals and the SiPMs
* Make no obstruction to mounting a Peltier-based cooling module on the opposite side of the PCB

# Tools

* ***OpenSCAD*** for creating 3D models (model-as-code, easy for version control).
* ***FreeCAD*** for adding rivets and final inspection before printing (it has the "measure" tool to verify dimensions, which OpenSCAD lacks).
