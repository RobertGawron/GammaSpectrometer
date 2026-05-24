include <Constants.scad>;
include <SiPM.scad>;
include <ScintillationCrystal.scad>;

// Internal cavity sized for PTFE-wrapped crystal + assembly clearance
CAVITY_X = WRAPPED_CRYSTAL_X + 2 * CAVITY_CLEARANCE_XY;
CAVITY_Y = WRAPPED_CRYSTAL_Y + 2 * CAVITY_CLEARANCE_XY;
CAVITY_Z = WRAPPED_CRYSTAL_Z;

// Main holder frame outer dimensions
HOLDER_X = CAVITY_X + 2 * HOLDER_THICKNESS;
HOLDER_Y = CAVITY_Y + 2 * HOLDER_THICKNESS;
HOLDER_Z = CAVITY_Z;

// Holder sits above the PCB by the SiPM thickness + optical gel gap
HOLDER_Z_OFFSET = SIPM_Z_SIDE + GEL_GAP;

// Full height from PCB top plane (z = 0) to top of holder
MOUNT_TOTAL_Z = HOLDER_Z + HOLDER_Z_OFFSET;

// Continuous side flanges sized to safely carry two heat-set inserts per side
FLANGE_Y = max(
  HOLDER_Y + 2 * FLANGE_OVERHANG_Y,
  INSERT_SPACING_Y + INSERT_BOSS_OD + 2 * FLANGE_EDGE_MARGIN_Y
);

module cavity_cutout() {
  // Open-frame holder: cavity is open through the full Z height.
  cube([ CAVITY_X, CAVITY_Y, HOLDER_Z + 1 ], center = true);
}

module ptfe_seam_relief() {
  // Small local relief in one inner wall to accommodate PTFE seam overlap.
  translate([
    0,
    CAVITY_Y / 2 + PTFE_SEAM_RELIEF_DEPTH / 2,
    0
  ]) {
    cube([
      PTFE_SEAM_RELIEF_WIDTH,
      PTFE_SEAM_RELIEF_DEPTH,
      HOLDER_Z + 1
    ], center = true);
  }
}

module holder_frame() {
  difference() {
    cube([ HOLDER_X, HOLDER_Y, HOLDER_Z ], center = true);
    cavity_cutout();
    ptfe_seam_relief();
  }
}

module insert_pilot_hole() {
  // Bottom-installed heat-set insert cavity.
  // Pilot diameter is provisional and must be verified against supplier data.
  union() {
    translate([ 0, 0, INSERT_PILOT_DEPTH / 2 ])
      cylinder(d = INSERT_PILOT_D, h = INSERT_PILOT_DEPTH + 0.02, center = true);

    translate([ 0, 0, INSERT_LEADIN_H / 2 ])
      cylinder(d1 = INSERT_LEADIN_D, d2 = INSERT_PILOT_D, h = INSERT_LEADIN_H, center = true);
  }
}

module flange_insert_boss(x_pos, y_pos) {
  translate([ x_pos, y_pos, INSERT_BOSS_HEIGHT / 2 ])
    cylinder(d = INSERT_BOSS_OD, h = INSERT_BOSS_HEIGHT, center = true);
}

module side_flange(side = 1) {
  flange_x = side * (HOLDER_X / 2 + FLANGE_WIDTH / 2);

  difference() {
    union() {
      // Continuous flange running from PCB plane to top of holder
      translate([ flange_x, 0, MOUNT_TOTAL_Z / 2 ])
        cube([ FLANGE_WIDTH, FLANGE_Y, MOUNT_TOTAL_Z ], center = true);

      // Local reinforcement bosses for inserts
      for (y_pos = [ -INSERT_SPACING_Y / 2, INSERT_SPACING_Y / 2 ]) {
        flange_insert_boss(flange_x, y_pos);
      }
    }

    // Blind pilot holes opening from the PCB side (bottom)
    for (y_pos = [ -INSERT_SPACING_Y / 2, INSERT_SPACING_Y / 2 ]) {
      translate([ flange_x, y_pos, 0 ])
        insert_pilot_hole();
    }
  }
}

module mounting_flanges() {
  side_flange(-1);
  side_flange(1);
}

module scintillation_crystal_holder() {
  union() {
    translate([ 0, 0, HOLDER_Z_OFFSET + HOLDER_Z / 2 ])
      holder_frame();

    mounting_flanges();
  }
}

scintillation_crystal_holder();
//

// Optional debug view of the wrapped crystal envelope inside the holder:
// %translate([ 0, 0, HOLDER_Z_OFFSET + HOLDER_Z / 2 ])
//   wrapped_scintillation_crystal_envelope();
// sipm_array();
