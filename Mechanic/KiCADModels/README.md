# KiCADModels


## Summary

3D models for PCB renderings in KiCad.

## Usage

1.  Use OpenSCAD IDE to dit or add an element in ./OpenSCAD directory, pres F6 (render), Click File, Export, Export to .cfg.
2. Open FreeCad, select KiCadStepUp, click "Load Kicad PCB footprint", select footprint in ../../Mechanical/[project name]/[project name].pretty directory. Footprint will be loaded
3. Click File -> Import, select previously generated .cfg file. **Make sure it's .cfg file!!**
4. Click on imported model, then click "Export 3D model To Kicad", export it to ./GeneratedModel


To be continued..
