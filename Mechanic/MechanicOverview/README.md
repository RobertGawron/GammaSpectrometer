# 3D models of 3d printed parts + model of the whole device

## Summary

```MechanicOverview.scad``` is the main project.

## Exporting .stl files

### Summary

OpenSCAD doesn't allow export from single .scad file to multiple .stl files - the exported single .stl will be an union of all of modules in .scad file. This is problematic when importing to e.g. Blender, because it's impossible to add different surfaces to different model's parts (there's only one model). 

Here a workaround in the Python + shell was made.

The Python script analyzes .scad file provided as command line argument, it finds all modules and for each module generate a .scad file with only this module active. It also generates a shell script that renders all those .scad files to .stl files.

### Usage

1. Open ```MechanicOverview.scad```m comment execution of all modules (render image should be clean)
1. ```python ./GenerateMultipleSTL.py MechanicOverview.sca```
2. ```run_exports.s```

This will create Render*.stl that can be now imported to other CAD tools, e.g. Blender.

