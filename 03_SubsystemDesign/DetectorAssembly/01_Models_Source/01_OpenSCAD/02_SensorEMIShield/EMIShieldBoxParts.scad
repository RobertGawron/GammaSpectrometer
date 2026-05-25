include <EMIShieldBoxConstants.scad>;

// =============================================================
// EMI shield enclosure - shared part modules
// =============================================================
//
// Single source of truth for:
//   - top panel (with aperture)
//   - wall  (with optional EMI overlap tabs at its ends)
//   - flange (with mounting holes)
//   - side strip = wall + flange laid out flat / in folded pose
//
// Each part comes in two paired forms:
//   side_strip_2d(...)    -> the same outline in the flat blank
//   folded_strip_3d(...)  -> the same parts in their folded pose
//
// PLUS one transform shared by 2D and 3D:
//   place_strip("side")   -> carries either form to one of the four
//                            outer edges of the centered top panel.
//
// Strip's own local frame (used by side_strip_2d / fold-line preview)
// ---------------------------------------------------------------------
//      y = 0                +-----------------------------+  PANEL-BEND edge
//                           |          WALL               |
//      y = -WALL_H          +-----------------------------+  WALL-FLANGE fold
//                           |          FLANGE             |
//      y = -(WALL_H+FLANGE_W) +---------------------------+  outer flange edge
//                           x = 0                          x = length
//
// Strip's own local frame (used by folded_strip_3d)
// ---------------------------------------------------------------------
//      strip-local +X  : along the wall length
//      strip-local +Y  : INWARD (toward the box interior)
//      strip-local +Z  : up (PCB plane is z = 0)
//
// EMI overlap tabs
// ---------------------------------------------------------------------
// In the flat blank a tab is a rectangular extension of the wall plate
// at the wall's left or right end, in line with the wall:
//   left  tab : strip-local x in [-TAB_LEN, 0],          y in [-WALL_H, 0]
//   right tab : strip-local x in [length, length+TAB_LEN], y in [-WALL_H, 0]
// A TAB_KERF-wide slot is then subtracted from the tab's top edge
// (strip-local y just below 0) to physically separate the tab from the
// adjacent perpendicular strip in the flat blank.
//
// In the folded pose a tab is a thin vertical plate, perpendicular to
// its wall, positioned to lap behind the inside face of the
// perpendicular (top/bottom) wall.

// =============================================================
// TOP PANEL
// =============================================================

module top_panel_2d() {
    difference() {
        square([TOP_X, TOP_Y], center = true);
        square([APERTURE_X, APERTURE_Y], center = true);
    }
}

module top_panel_3d() {
    translate([0, 0, WALL_H])
        linear_extrude(height = THICKNESS) top_panel_2d();
}

// =============================================================
// WALL  (2D, with optional EMI tabs + kerf slot to free them)
// =============================================================

module wall_2d(length, tab_left = false, tab_right = false) {
    difference() {
        union() {
            // Wall plate itself
            translate([0, -WALL_H]) square([length, WALL_H]);
            // Left tab : in-line extension of the wall
            if (tab_left)
                translate([-TAB_LEN, -WALL_H]) square([TAB_LEN, WALL_H]);
            // Right tab : in-line extension of the wall
            if (tab_right)
                translate([length, -WALL_H]) square([TAB_LEN, WALL_H]);
        }
        // ---- Kerf slots ----
        // Each tab shares the strip-local line y = 0 with the perpendicular
        // strip's wall (which sits at global x = +/-HALF_X). To make this
        // a real laser cut rather than a zero-width shared edge, we
        // subtract a TAB_KERF-wide slot from the tab's top edge.
        // The slot extends slightly past the tab in x for clean booleans.
        if (tab_left)
            translate([-TAB_LEN - 0.01, -TAB_KERF])
                square([TAB_LEN + 0.01, TAB_KERF + 0.01]);
        if (tab_right)
            translate([length, -TAB_KERF])
                square([TAB_LEN + 0.01, TAB_KERF + 0.01]);
    }
}

// =============================================================
// FLANGE  (2D, with two mounting holes near each end)
// =============================================================

module flange_2d(length) {
    difference() {
        translate([0, -FLANGE_W]) square([length, FLANGE_W]);
        translate([HOLE_EDGE_MARGIN,          -FLANGE_W / 2]) circle(d = MOUNT_HOLE_D);
        translate([length - HOLE_EDGE_MARGIN, -FLANGE_W / 2]) circle(d = MOUNT_HOLE_D);
    }
}

// =============================================================
// SIDE STRIP (2D) = wall + tabs (kerfed) + flange, laid flat
// =============================================================

module side_strip_2d(length, tab_left = false, tab_right = false) {
    wall_2d(length, tab_left, tab_right);
    // Flange is attached at the wall's bottom edge (y = -WALL_H) which is
    // also the flange's local y = 0 edge.
    translate([0, -WALL_H]) flange_2d(length);
}

// =============================================================
// SIDE STRIP (3D) = same wall + flange + tabs, in their folded pose
// =============================================================
//
// Wall placement
// --------------
// Wall is a vertical plate with its OUTER face at strip-local y = 0
// (which maps via place_strip(...) to the matching outer edge of the
// top panel, e.g. global x = -HALF_X for the LEFT strip) and its INNER
// face at strip-local y = THICKNESS (inside the box).
//
// Tab placement (inward overlap)
// ------------------------------
// Each tab is a thin plate parallel to the PERPENDICULAR wall, sitting
// just INSIDE that wall's inner face (one sheet-thickness inboard) so
// it provides conductive overlap without trying to occupy the same
// volume as the perpendicular wall itself.
//
// In strip-local terms (LEFT strip is the easiest example - left tab
// laps behind the top wall, right tab laps behind the bottom wall):
//
//   * Tab plate thickness    : THICKNESS along strip-local X
//                              (parallel to this wall's length axis)
//   * Tab plate "inward" run : TAB_LEN along strip-local Y
//                              (the inward direction)
//   * Tab plate height       : WALL_H - TAB_KERF along strip-local Z
//                              (slightly shorter than wall, matching the
//                              kerf cut in the flat blank, also avoids
//                              fighting the top panel for the same z=WALL_H
//                              voxel).
//   * Tab X position         : just inside the wall's end, offset by
//                              THICKNESS so the tab does NOT intersect
//                              the wall material itself.
//   * Tab Y position         : starts at THICKNESS (one wall thickness
//                              inward), so the tab is exactly behind the
//                              inner face of the perpendicular wall, not
//                              coincident with it.

module folded_strip_3d(length, tab_left = false, tab_right = false) {
    // ---- Wall (vertical plate) ----
    cube([length, THICKNESS, WALL_H]);

    // ---- Flange (lying on PCB plane), shares its 2D outline with the
    // flat-pattern flange so the hole pattern is automatically the same.
    linear_extrude(height = THICKNESS) flange_2d(length);

    // ---- EMI overlap tabs ----
    // Left tab : just inside the wall's left corner, behind the perpendicular wall.
    if (tab_left)
        translate([THICKNESS,           THICKNESS, 0])
            cube([THICKNESS, TAB_LEN, WALL_H - TAB_KERF]);

    // Right tab : just inside the wall's right corner, behind the perpendicular wall.
    if (tab_right)
        translate([length - 2 * THICKNESS, THICKNESS, 0])
            cube([THICKNESS, TAB_LEN, WALL_H - TAB_KERF]);
}

// =============================================================
// FOLD LINES (preview overlay only - never exported as a cut)
// =============================================================

FOLD_LINE_W = 0.20;

module _fold_line_h(length, y) {
    translate([0, y - FOLD_LINE_W / 2]) square([length, FOLD_LINE_W]);
}

module _fold_line_v(height_, x, y0) {
    translate([x - FOLD_LINE_W / 2, y0]) square([FOLD_LINE_W, height_]);
}

module side_strip_fold_lines(length, tab_left = false, tab_right = false) {
    // wall <-> top-panel fold
    _fold_line_h(length, 0);
    // wall <-> flange fold
    _fold_line_h(length, -WALL_H);
    // EMI tab folds (vertical lines at the wall ends, only in the wall region)
    if (tab_left)  _fold_line_v(WALL_H, 0,      -WALL_H);
    if (tab_right) _fold_line_v(WALL_H, length, -WALL_H);
}

// =============================================================
// STRIP PLACEMENT  (pure XY transform, identical for 2D and 3D)
// =============================================================
//
// place_strip(side) maps the strip's local frame so that:
//   - its panel-bend edge (strip-local y = 0, x in [0, length])
//     coincides with the matching outer edge of the centered top panel,
//   - its OUTWARD direction (strip-local -y) points outward in the world.
//
// Z is preserved, so the same call works for 2D (Z = 0) and 3D (Z > 0).

module place_strip(side) {
    if (side == "bottom") {
        translate([-HALF_X, -HALF_Y]) children();
    } else if (side == "top") {
        translate([ HALF_X,  HALF_Y]) rotate([0, 0, 180]) children();
    } else if (side == "left") {
        translate([-HALF_X,  HALF_Y]) rotate([0, 0, -90]) children();
    } else if (side == "right") {
        translate([ HALF_X, -HALF_Y]) rotate([0, 0,  90]) children();
    }
}

function strip_length(side) =
    (side == "bottom" || side == "top") ? TOP_X : TOP_Y;
