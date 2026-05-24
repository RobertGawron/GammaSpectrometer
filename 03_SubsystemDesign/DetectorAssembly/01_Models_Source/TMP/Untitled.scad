// Prototype 2D flat pattern for sheet-metal detector box
// Updated per user feedback:
// - box height reduced to 25 mm
// - mounting holes moved near the flange edges
//
// Quote-level geometry only.
// Final production blank must be adjusted by the fabricator for:
// - bend allowance / bend deduction
// - K-factor
// - inside bend radius
// - tooling / corner relief standard

$fn = 80;

// -----------------------------
// Main parameters
// -----------------------------
TOP_X = 32;              // top panel width  (mm)
TOP_Y = 42;              // top panel length (mm)
WALL_H = 25;             // wall height      (mm)  <-- updated from 30
FLANGE_W = 8;            // PCB mounting flange width (mm)
THICKNESS = 1.0;         // reference only; 2D file does not use thickness directly

OPENING_X = 22;          // top opening width
OPENING_Y = 8;           // top opening length

MOUNT_HOLE_D = 2.8;      // M2.5 clearance hole for prototype

// Mounting pattern options: 4, 6, or 8 holes.
// Default updated to 8 so holes can sit near the outer edges of all flanges.
MOUNT_HOLE_COUNT = 8;

// Distance of hole centers from flange ends, along the flange length.
// Kept fairly close to edges, but with enough material for prototype laser-cut sheet.
HOLE_EDGE_MARGIN = 5.0;

// All hole centers are placed on the flange mid-width.

// Optional preview-only fold lines.
// Leave false when exporting the cut geometry.
SHOW_FOLD_LINES = false;
FOLD_LINE_W = 0.20;

// -----------------------------
// Derived values
// -----------------------------
STRIP_W = WALL_H + FLANGE_W;      // side strip width in flat pattern
TOTAL_X = TOP_X + 2 * STRIP_W;    // nominal developed width
TOTAL_Y = TOP_Y + 2 * STRIP_W;    // nominal developed height

CENTER_X = TOP_X / 2;
CENTER_Y = TOP_Y / 2;

LEFT_HOLE_X   = -FLANGE_W / 2;
RIGHT_HOLE_X  = TOP_X + WALL_H + FLANGE_W / 2;
BOTTOM_HOLE_Y = -FLANGE_W / 2;
TOP_HOLE_Y    = TOP_Y + WALL_H + FLANGE_W / 2;

LOW_Y  = HOLE_EDGE_MARGIN;
HIGH_Y = TOP_Y - HOLE_EDGE_MARGIN;
LOW_X  = HOLE_EDGE_MARGIN;
HIGH_X = TOP_X - HOLE_EDGE_MARGIN;

// -----------------------------
// Modules
// -----------------------------
module flat_blank_outline() {
    union() {
        // Center top panel
        square([TOP_X, TOP_Y], center = false);

        // Left wall + flange strip
        translate([-(WALL_H + FLANGE_W), 0])
            square([WALL_H + FLANGE_W, TOP_Y], center = false);

        // Right wall + flange strip
        translate([TOP_X, 0])
            square([WALL_H + FLANGE_W, TOP_Y], center = false);

        // Bottom wall + flange strip
        translate([0, -(WALL_H + FLANGE_W)])
            square([TOP_X, WALL_H + FLANGE_W], center = false);

        // Top wall + flange strip
        translate([0, TOP_Y])
            square([TOP_X, WALL_H + FLANGE_W], center = false);
    }
}

module top_opening_cut() {
    translate([(TOP_X - OPENING_X) / 2, (TOP_Y - OPENING_Y) / 2])
        square([OPENING_X, OPENING_Y], center = false);
}

module left_right_holes() {
    translate([LEFT_HOLE_X, LOW_Y])   circle(d = MOUNT_HOLE_D);
    translate([LEFT_HOLE_X, HIGH_Y])  circle(d = MOUNT_HOLE_D);
    translate([RIGHT_HOLE_X, LOW_Y])  circle(d = MOUNT_HOLE_D);
    translate([RIGHT_HOLE_X, HIGH_Y]) circle(d = MOUNT_HOLE_D);
}

module top_bottom_outer_holes() {
    translate([LOW_X,  BOTTOM_HOLE_Y]) circle(d = MOUNT_HOLE_D);
    translate([HIGH_X, BOTTOM_HOLE_Y]) circle(d = MOUNT_HOLE_D);
    translate([LOW_X,  TOP_HOLE_Y])    circle(d = MOUNT_HOLE_D);
    translate([HIGH_X, TOP_HOLE_Y])    circle(d = MOUNT_HOLE_D);
}

module top_bottom_center_holes() {
    translate([CENTER_X, BOTTOM_HOLE_Y]) circle(d = MOUNT_HOLE_D);
    translate([CENTER_X, TOP_HOLE_Y])    circle(d = MOUNT_HOLE_D);
}

module cut_features() {
    top_opening_cut();

    if (MOUNT_HOLE_COUNT == 4) {
        // Four-hole version: one near each side edge pair only
        left_right_holes();
    }
    else if (MOUNT_HOLE_COUNT == 6) {
        // Six-hole version: side holes near edges, top/bottom centered
        left_right_holes();
        top_bottom_center_holes();
    }
    else {
        // Eight-hole version: holes near edges on every flange
        left_right_holes();
        top_bottom_outer_holes();
    }
}

module flat_pattern_cut() {
    difference() {
        flat_blank_outline();
        cut_features();
    }
}

// Preview-only fold lines. Do NOT export these as the manufacturing cut profile.
module fold_lines_preview() {
    // Top panel to walls
    translate([-FOLD_LINE_W/2, 0]) square([FOLD_LINE_W, TOP_Y], center = false);
    translate([TOP_X - FOLD_LINE_W/2, 0]) square([FOLD_LINE_W, TOP_Y], center = false);
    translate([0, -FOLD_LINE_W/2]) square([TOP_X, FOLD_LINE_W], center = false);
    translate([0, TOP_Y - FOLD_LINE_W/2]) square([TOP_X, FOLD_LINE_W], center = false);

    // Walls to mounting flanges
    translate([-(FLANGE_W + FOLD_LINE_W/2), 0]) square([FOLD_LINE_W, TOP_Y], center = false);
    translate([TOP_X + WALL_H - FOLD_LINE_W/2, 0]) square([FOLD_LINE_W, TOP_Y], center = false);
    translate([0, -(FLANGE_W + FOLD_LINE_W/2)]) square([TOP_X, FOLD_LINE_W], center = false);
    translate([0, TOP_Y + WALL_H - FOLD_LINE_W/2]) square([TOP_X, FOLD_LINE_W], center = false);
}

// -----------------------------
// Output
// -----------------------------
linear_extrude(height = 0.5)
flat_pattern_cut();

// Uncomment only for on-screen reference; keep disabled for DXF/SVG export.
// if (SHOW_FOLD_LINES) %color("blue") fold_lines_preview();

// Reference notes:
// - Nominal flat size = TOTAL_X x TOTAL_Y = 98 x 108 mm
// - Default hole count = 8, placed near flange edges
// - To switch hole count: set MOUNT_HOLE_COUNT to 4, 6, or 8
