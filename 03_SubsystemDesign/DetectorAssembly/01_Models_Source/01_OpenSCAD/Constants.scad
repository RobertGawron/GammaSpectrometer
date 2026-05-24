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