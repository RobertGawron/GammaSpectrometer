$fn = 100;

/*
Crystals are stacked in a grid to create bigger crystal.
X-Y-Z coordinates are to match:
    * sipm are placed side by side horizontally
*/

CRYSTALS_NUM_Z = 4;
CRYSTALS_NUM_Y = 2;
CRYSTAL_XY_SIDE = 4;

// Gap for optical gel
GEL_GAP = 0.1;

CRYSTAL_X = 22;
CRYSTAL_Y = (CRYSTAL_XY_SIDE + GEL_GAP) * CRYSTALS_NUM_Y;
CRYSTAL_Z = (CRYSTAL_XY_SIDE + GEL_GAP) * CRYSTALS_NUM_Z;

HOLDER_THICKNESS = 2.5;

// Active area is 6x6 mm, but the SIPM has a bit of a border
SIPM_XY_SIDE = 7;
SIPM_Z_SIDE = 0.65;


// PCB mounting blocks / rivet holes
MOUNT_BLOCK_X = 5;       // outward from holder side
MOUNT_BLOCK_Y = 4;       // block length along Y
MOUNT_BLOCK_RISE = 3;    // how high the block rises above PCB
MOUNT_BLOCK_INSET_Y = 1; // distance from holder front/back edge
RIVET_HOLE_D = 2.2;      // adjust for your rivet diameter + print clearance