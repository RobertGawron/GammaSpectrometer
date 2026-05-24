include<Constants.scad>;

module scintillation_crystal() {
  cube([ CRYSTAL_X, CRYSTAL_Y, CRYSTAL_Z ], center = true);
}

// scintillation_crystal();
