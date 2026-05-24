

include<Constants.scad>;
include<SiPM.scad>;
include<ScintillationCrystal.scad>;

HOLDER_X = CRYSTAL_X + HOLDER_THICKNESS;
HOLDER_Y = CRYSTAL_Y + HOLDER_THICKNESS;
HOLDER_Z = CRYSTAL_Z;


module mounting_sockets () {
  // left socket
/*  translate([ -HOLDER_X / 2 + HOLDER_THICKNESS / 2, 0, 0 ]) {
    cube([ HOLDER_THICKNESS, HOLDER_Y, HOLDER_Z ], center = true);
  }*/
    
    circle (r = 50);

/*
  // right socket
  translate([ HOLDER_X / 2 - HOLDER_THICKNESS / 2, 0, 0 ]) {
    cube([ HOLDER_THICKNESS, HOLDER_Y, HOLDER_Z ], center = true);
  }*/
}

module scintillation_crystal_holder() {
  difference() {
    cube([ HOLDER_X, HOLDER_Y, HOLDER_Z ], center = true);
    scintillation_crystal();
  }
}

HOLDER_Z_OFFSET = SIPM_Z_SIDE + GEL_GAP;
translate([ 0, 0, HOLDER_Z / 2 + HOLDER_Z_OFFSET ]) scintillation_crystal_holder();

sipm_array();

mounting_sockets ();