include <ScintillationCrystalHolder.scad>;

scintillation_crystal_holder();

// Optional debug view of the wrapped crystal envelope inside the holder,
// showing the four 2x2 sub-groups separated by the internal 1 mm PTFE cross.
translate([ 0, 0, HOLDER_Z_OFFSET + HOLDER_Z / 2 ])
  wrapped_scintillation_crystal_debug();

// Optional debug view of the 2x2 SiPM array:
sipm_array();
