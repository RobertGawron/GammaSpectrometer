include<Constants.scad>;

module sipm_single() {
  rotate([ 90, 0, 0 ]) {
    import("../../02_Models_COTS/MICROFC-60035-SMT-TR1.stl", center = true);
  }
}

module sipm_array() {
  // left sipm
  translate([ -SIPM_XY_SIDE, 0, 0 ]) {
    sipm_single();
  }

  // center sipm
  sipm_single();

  // right sipm
  translate([ SIPM_XY_SIDE, 0, 0 ]) {
    sipm_single();
  }
}
