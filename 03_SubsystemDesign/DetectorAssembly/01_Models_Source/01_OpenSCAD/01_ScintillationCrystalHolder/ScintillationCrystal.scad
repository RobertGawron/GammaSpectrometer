include <Constants.scad>;

// Bare monolithic 4x4 crystal pack envelope (no dividers).
module scintillation_crystal() {
  cube([ CRYSTAL_X, CRYSTAL_Y, CRYSTAL_Z ], center = true);
}

// 4x4 crystal pack drawn as four 2x2 sub-groups separated by the
// internal PTFE dividers. Useful for visual checks of the holder cavity.
module scintillation_crystal_subgroups() {
  subgroup_x = LYSO_BAR_SIDE * (CRYSTALS_NUM_X / SIPM_GROUPS_X); // 8 mm
  subgroup_y = LYSO_BAR_SIDE * (CRYSTALS_NUM_Y / SIPM_GROUPS_Y); // 8 mm

  // Center-to-center spacing of sub-groups, including the PTFE divider gap.
  pitch_x = subgroup_x + PTFE_INTERNAL_THICKNESS;
  pitch_y = subgroup_y + PTFE_INTERNAL_THICKNESS;

  for (ix = [0 : SIPM_GROUPS_X - 1]) {
    for (iy = [0 : SIPM_GROUPS_Y - 1]) {
      x = (ix - (SIPM_GROUPS_X - 1) / 2) * pitch_x;
      y = (iy - (SIPM_GROUPS_Y - 1) / 2) * pitch_y;
      translate([ x, y, 0 ])
        cube([ subgroup_x, subgroup_y, CRYSTAL_Z ], center = true);
    }
  }
}

// Internal PTFE divider strips between the four 2x2 sub-groups.
// One strip in X, one strip in Y, forming a cross.
module ptfe_internal_dividers() {
  // Span includes the outer wrap so the dividers visually butt against it.
  span_x = CRYSTAL_X + 2 * PTFE_THICKNESS;
  span_y = CRYSTAL_Y + 2 * PTFE_THICKNESS;

  // Divider parallel to Y (separates the two X sub-groups).
  if (PTFE_INTERNAL_COUNT_X > 0) {
    cube([ PTFE_INTERNAL_THICKNESS, span_y, CRYSTAL_Z ], center = true);
  }
  // Divider parallel to X (separates the two Y sub-groups).
  if (PTFE_INTERNAL_COUNT_Y > 0) {
    cube([ span_x, PTFE_INTERNAL_THICKNESS, CRYSTAL_Z ], center = true);
  }
}

// Full wrapped envelope: outer PTFE wrap + internal PTFE dividers + crystals.
// Size matches WRAPPED_CRYSTAL_X x WRAPPED_CRYSTAL_Y x WRAPPED_CRYSTAL_Z.
module wrapped_scintillation_crystal_envelope() {
  cube([ WRAPPED_CRYSTAL_X, WRAPPED_CRYSTAL_Y, WRAPPED_CRYSTAL_Z ], center = true);
}

// Exploded debug view: shows crystal sub-groups + internal dividers
// inside the wrapped envelope.
module wrapped_scintillation_crystal_debug() {
  %wrapped_scintillation_crystal_envelope();
  color("white") scintillation_crystal_subgroups();
  color("lightgray") ptfe_internal_dividers();
}

// scintillation_crystal();
// wrapped_scintillation_crystal_envelope();
// wrapped_scintillation_crystal_debug();
