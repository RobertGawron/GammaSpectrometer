// =============================================================
// EMI shield enclosure - shared parameters
// =============================================================
//
// Concept
// - Single sheet-metal blank, laser/water-jet cut flat then bent.
// - 4 side walls fold DOWN from a top panel.
// - Each wall ends in an outward PCB mounting flange in the PCB plane.
// - Bottom (PCB side) is OPEN; PCB itself closes the shield.
// - Top panel has a 17 x 17 mm aperture for the scintillator/SiPM stack.
// - EMI continuity at corners: LEFT and RIGHT walls carry L-shaped
//   overlap tabs at both ends. When folded, those tabs bend 90 deg
//   inward and lap behind the inside face of the TOP and BOTTOM walls.
//
// Sign conventions for the assembled box
// - PCB top surface = z = 0
// - Box extends upward in +Z
// - Assembled outside footprint = TOP_X x TOP_Y, centered on origin
// - Assembled outside height above PCB = WALL_H
//
// Manufacturing notes (quote-level)
// - All geometry is mid-line / nominal.
// - Final blank MUST be adjusted by the fabricator for bend allowance,
//   bend deduction, K-factor, inside bend radius and tooling corner relief.

$fn = 80;

// -----------------------------
// Main parameters
// -----------------------------

// Outside footprint of the assembled box (= outer dimensions of the top panel).
TOP_X = 50;              // mm
TOP_Y = 50;              // mm

// Height of the box wall above the PCB.
WALL_H = 20;             // mm

// PCB mounting flange (folded outward at the bottom of each wall).
FLANGE_W = 8;            // mm

// Sheet thickness (also used as physical THICKNESS in the 3D preview
// AND as the in-plane offset between an overlap tab and the perpendicular
// wall it sits behind).
THICKNESS = 1.0;         // mm

// Top aperture for the scintillation crystal / SiPM optical path.
APERTURE_X = 17;         // mm
APERTURE_Y = 17;         // mm

// PCB mounting hole pattern.
MOUNT_HOLE_D = 2.8;      // mm  (M2.5 clearance, prototype)
// Distance of hole centers from each end of a flange, along the flange length.
HOLE_EDGE_MARGIN = 5.0;  // mm
// Default = 2 holes per flange (one near each end) = 8 holes total.

// -----------------------------
// EMI overlap-tab parameters
// -----------------------------

// L-shaped overlap tab on the left/right wall ends.
// In the flat blank the tab is an in-line extension of the wall plate;
// in the folded box it bends 90 deg inward at the wall corner and
// overlaps the inside face of the perpendicular (top/bottom) wall.
TAB_LEN = 5;             // mm, length of the inward fold

// Width of the laser kerf cut that separates a tab from the adjacent
// perpendicular strip in the FLAT pattern (so the tab becomes a free
// flap that can be bent independently).
TAB_KERF = 0.3;          // mm

// -----------------------------
// Derived values
// -----------------------------

STRIP_W  = WALL_H + FLANGE_W;     // each side strip: wall + flange
TOTAL_X  = TOP_X + 2 * STRIP_W;   // nominal developed blank width
TOTAL_Y  = TOP_Y + 2 * STRIP_W;   // nominal developed blank height

HALF_X = TOP_X / 2;
HALF_Y = TOP_Y / 2;
