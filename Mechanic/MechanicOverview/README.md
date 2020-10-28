# 3D models of 3d printed parts +model of the whole device

## Summary

```MechanicOverview.scad``` is the main project.

## Exporting .stl files

### Summary

OpenSCAD doesn't allow export to multiple .scad files from single .scad file - the exported model will be an union of all of its models. This is problematic when importing to e.e. Blender, because it's impossible to add different surfaces to different modules (there's only one module). 

Here a workaround in the Python + shell was made.

The Python script analyzes .scad file provided as command line argument, it finds all modules and for each module generate a .scad file with only this.

### Usage

1. Open ```MechanicOverview.scad```m comment execution of all modules (render image should be clean)
1. ```python ./GenerateMultipleSTL.py MechanicOverview.sca```
2. ```run_exports.s```

This will create Render*.stl that can be now imported to other CAD (e.g.) Blender.

Note: I tried to be consistent and put this script in ../../Tools and here run only a wrapper, but it's hard to import python files that are located in parent dictionary. At the end, I left the script here. 
