include <Constants.scad>;

module sipm_single() {
  rotate([ 90, 0, 0 ]) {
    import("../../../02_Models_COTS/MICROFC-60035-SMT-TR1.stl", center = true);
  }
}

module sipm_array() {
  for (x_pos = [ -SIPM_PITCH_X / 2, SIPM_PITCH_X / 2 ]) {
    for (y_pos = [ -SIPM_PITCH_Y / 2, SIPM_PITCH_Y / 2 ]) {
      translate([ x_pos, y_pos, 0 ]) {
        sipm_single();
      }
    }
  }
}
