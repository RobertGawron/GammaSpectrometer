

include<Constants.scad>;
include<ScintillationCrystal.scad>;

module scintillation_crystal_holder() {
  HOLDER_X = CRYSTAL_X + HOLDER_THICKNESS;
  HOLDER_Y = CRYSTAL_Y + HOLDER_THICKNESS;
  HOLDER_Z = CRYSTAL_Z;

  difference() {
    cube([ HOLDER_X, HOLDER_Y, HOLDER_Z ], center = true);
    scintillation_crystal();
  }
}

translate([ 0, 0, 100 ]) scintillation_crystal_holder();

rotate([ 90, 0, 0 ]) {
  import("../../02_Models_COTS/MICROFC-60035-SMT-TR1.stl", center = true);
}
