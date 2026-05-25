$fn = 100;

/*
Detector crystal pack

- 16 x LYSO bars, each 4 x 4 x 22 mm
- Arranged as a 4 x 4 matrix in X/Y
- 22 mm side is vertical (Z)
- Nominal bare crystal pack = 16 x 16 x 22 mm

PTFE reflector strategy
- 1 mm PTFE wraps the OUTER vertical side faces of the pack.
- 1 mm PTFE dividers are inserted BETWEEN the four 2x2 crystal sub-groups,
  i.e. one divider strip in X and one in Y, aligned with the gaps between
  adjacent SiPMs of the 2x2 SiPM array. This optically isolates each SiPM
  quadrant.
- The SiPM coupling face (bottom) is left free for optical gel.
*/

CRYSTALS_NUM_X = 4;
CRYSTALS_NUM_Y = 4;
LYSO_BAR_SIDE = 4;
LYSO_BAR_Z = 22;

// Bare crystal pack dimensions
CRYSTAL_X = LYSO_BAR_SIDE * CRYSTALS_NUM_X;   // 16 mm
CRYSTAL_Y = LYSO_BAR_SIDE * CRYSTALS_NUM_Y;   // 16 mm
CRYSTAL_Z = LYSO_BAR_Z;                       // 22 mm

// PTFE reflector wrap assumptions
// Outer wrap on the four vertical side faces.
PTFE_THICKNESS = 1.0;

// Internal PTFE dividers between SiPM sub-groups.
// The 4x4 crystal pack is split into a 2x2 grid of 2x2 crystal sub-groups,
// one sub-group per SiPM. A single PTFE strip of this thickness sits in the
// gap between adjacent sub-groups in X, and another in Y.
PTFE_INTERNAL_THICKNESS = 1.0;

// Number of internal PTFE dividers along each in-plane axis.
// 2 SiPMs per axis -> 1 divider per axis between the sub-groups.
SIPM_GROUPS_X = 2;
SIPM_GROUPS_Y = 2;
PTFE_INTERNAL_COUNT_X = SIPM_GROUPS_X - 1;   // 1
PTFE_INTERNAL_COUNT_Y = SIPM_GROUPS_Y - 1;   // 1

CAVITY_CLEARANCE_XY = 0.2;

// Wrapped envelope = bare crystals + outer PTFE wrap + internal PTFE dividers
WRAPPED_CRYSTAL_X = CRYSTAL_X
                    + 2 * PTFE_THICKNESS
                    + PTFE_INTERNAL_COUNT_X * PTFE_INTERNAL_THICKNESS;  // 19 mm
WRAPPED_CRYSTAL_Y = CRYSTAL_Y
                    + 2 * PTFE_THICKNESS
                    + PTFE_INTERNAL_COUNT_Y * PTFE_INTERNAL_THICKNESS;  // 19 mm
WRAPPED_CRYSTAL_Z = CRYSTAL_Z;                       // unchanged in this open-frame concept

// Holder wall thickness around cavity
HOLDER_THICKNESS = 2.5;

// Optical coupling stack between SiPM top and crystal bottom face
GEL_GAP = 0.1;

// SiPM geometry
SIPM_XY_SIDE = 7.2;        // package size
SIPM_ACTIVE_XY_SIDE = 6.0; // active area, centered within package
SIPM_Z_SIDE = 0.65;

// 2x2 SiPM matrix pitch
// Default assumes the packages are placed edge-to-edge.
SIPM_PITCH_X = SIPM_XY_SIDE;
SIPM_PITCH_Y = SIPM_XY_SIDE;

// Brass threaded insert assumptions (provisional, per prior approval)
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
INSERT_SPACING_Y = 14.0;     // center-to-center spacing on each side flange
FLANGE_WIDTH = 10.0;         // outward from holder side
FLANGE_OVERHANG_Y = 3.5;     // flange extends beyond holder in +/-Y
FLANGE_EDGE_MARGIN_Y = 2.0;  // edge margin beyond boss envelope

// PTFE seam relief pocket inside cavity
PTFE_SEAM_RELIEF_WIDTH = 3.0;
PTFE_SEAM_RELIEF_DEPTH = 0.4;
