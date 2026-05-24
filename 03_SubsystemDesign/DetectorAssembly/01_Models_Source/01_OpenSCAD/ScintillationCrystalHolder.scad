include <Constants.scad>;
include <SiPM.scad>;
include <ScintillationCrystal.scad>;

HOLDER_X = CRYSTAL_X + HOLDER_THICKNESS;
HOLDER_Y = CRYSTAL_Y + HOLDER_THICKNESS;
HOLDER_Z = CRYSTAL_Z;

HOLDER_Z_OFFSET = SIPM_Z_SIDE + GEL_GAP;

// Total Z size of each mounting block:
// from PCB plane up to a little above the holder bottom for strength
MOUNT_BLOCK_Z = HOLDER_Z_OFFSET + MOUNT_BLOCK_RISE;

// Y position of the front/back blocks
MOUNT_BLOCK_Y_POS = HOLDER_Y / 2 - MOUNT_BLOCK_Y / 2 - MOUNT_BLOCK_INSET_Y;

module mounting_block(x_sign, y_pos) {
  translate([
    x_sign * (HOLDER_X / 2 + MOUNT_BLOCK_X / 2),
    y_pos,
    -HOLDER_Z / 2 - HOLDER_Z_OFFSET + MOUNT_BLOCK_Z / 2
  ]) {
    difference() {
      cube([ MOUNT_BLOCK_X, MOUNT_BLOCK_Y, MOUNT_BLOCK_Z ], center = true);

      // Rivet hole, vertical into PCB
      cylinder(d = RIVET_HOLE_D, h = MOUNT_BLOCK_Z + 1, center = true);
    }
  }
}

module mounting_blocks() {
  for (x_sign = [-1, 1]) {
    for (y_pos = [-MOUNT_BLOCK_Y_POS, MOUNT_BLOCK_Y_POS]) {
      mounting_block(x_sign, y_pos);
    }
  }
}

module scintillation_crystal_holder() {
  union() {
    difference() {
      cube([ HOLDER_X, HOLDER_Y, HOLDER_Z ], center = true);
      scintillation_crystal();
    }

    mounting_blocks();
  }
}

translate([ 0, 0, HOLDER_Z / 2 + HOLDER_Z_OFFSET ])
  scintillation_crystal_holder();

sipm_array();