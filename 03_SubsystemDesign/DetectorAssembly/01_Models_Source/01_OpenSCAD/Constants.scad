$fn = 100;

/*
Detector crystal pack
- 8 x LYSO bars, each 22 x 4 x 4 mm
- Arranged as 2 x 4 to form a nominal 22 x 8 x 16 mm pack
*/
CRYSTALS_NUM_Z = 4;
CRYSTALS_NUM_Y = 2;

LYSO_BAR_X = 22;
LYSO_BAR_SIDE = 4;

// Bare crystal pack dimensions
CRYSTAL_X = LYSO_BAR_X;
CRYSTAL_Y = LYSO_BAR_SIDE * CRYSTALS_NUM_Y;   // 8 mm
CRYSTAL_Z = LYSO_BAR_SIDE * CRYSTALS_NUM_Z;   // 16 mm

// PTFE reflector wrap assumptions
// Current model assumes 1 mm PTFE on the outer side faces only.
// The SiPM coupling face is intentionally left free for optical gel.
PTFE_THICKNESS = 1.0;
CAVITY_CLEARANCE_XY = 0.2;

WRAPPED_CRYSTAL_X = CRYSTAL_X + 2 * PTFE_THICKNESS;  // 24 mm
WRAPPED_CRYSTAL_Y = CRYSTAL_Y + 2 * PTFE_THICKNESS;  // 10 mm
WRAPPED_CRYSTAL_Z = CRYSTAL_Z;                       // unchanged in this open-frame concept

// Holder wall thickness around cavity
HOLDER_THICKNESS = 2.5;

// Optical coupling stack between SiPM top and crystal bottom face
GEL_GAP = 0.1;
SIPM_XY_SIDE = 7;
SIPM_Z_SIDE = 0.65;

// Brass threaded insert assumptions (provisional, per user approval)
// These are heat-set inserts for plastic, not blind rivets.
INSERT_THREAD = 2.5;
INSERT_OD = 3.5;
INSERT_LENGTH = 5.0;

// PROVISIONAL pilot-hole diameter.
// Final value must be replaced by the exact supplier datasheet recommendation.
INSERT_PILOT_D = 3.2;
INSERT_PILOT_DEPTH = INSERT_LENGTH + 0.3;
INSERT_LEADIN_D = 3.6;
INSERT_LEADIN_H = 1.0;

// Reinforcement around each insert
INSERT_BOSS_OD = 7.2;
INSERT_BOSS_HEIGHT = 6.0;

// Mounting layout
INSERT_SPACING_Y = 12.0;     // center-to-center spacing on each side flange
FLANGE_WIDTH = 10.0;         // outward from holder side
FLANGE_OVERHANG_Y = 3.5;     // flange extends beyond holder in +/-Y
FLANGE_EDGE_MARGIN_Y = 2.0;  // edge margin beyond boss envelope

// PTFE seam relief pocket inside cavity
PTFE_SEAM_RELIEF_WIDTH = 3.0;
PTFE_SEAM_RELIEF_DEPTH = 0.4;
