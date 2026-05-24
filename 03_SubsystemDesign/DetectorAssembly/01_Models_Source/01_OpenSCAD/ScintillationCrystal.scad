include <Constants.scad>;

module scintillation_crystal() {
  cube([ CRYSTAL_X, CRYSTAL_Y, CRYSTAL_Z ], center = true);
}

module wrapped_scintillation_crystal_envelope() {
  cube([ WRAPPED_CRYSTAL_X, WRAPPED_CRYSTAL_Y, WRAPPED_CRYSTAL_Z ], center = true);
}

// scintillation_crystal();
// wrapped_scintillation_crystal_envelope();
