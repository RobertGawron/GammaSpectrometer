include <EMIShieldBoxConstants.scad>;
use     <EMIShieldBoxParts.scad>;

// =============================================================
// EMI shield enclosure - 3D folded preview (non-manufacturing)
// =============================================================
//
// Uses the SAME parts (wall, flange, tabs) and SAME placement helper
// (place_strip) as the 2D flat pattern. The only difference is that
// each side strip is rendered in its FOLDED pose by calling
// folded_strip_3d instead of side_strip_2d.
//
// World frame
//   - PCB top surface = z = 0
//   - Box centered on (0, 0) in XY
//   - Walls rise from z = 0 to z = WALL_H
//   - Top panel sits at z = WALL_H

module emi_shield_box() {
    color("silver") {
        top_panel_3d();

        // Tabs only on LEFT and RIGHT walls (matches the 2D pattern).
        place_strip("left")
            folded_strip_3d(strip_length("left"),
                            tab_left = true, tab_right = true);
        place_strip("right")
            folded_strip_3d(strip_length("right"),
                            tab_left = true, tab_right = true);

        place_strip("bottom") folded_strip_3d(strip_length("bottom"));
        place_strip("top")    folded_strip_3d(strip_length("top"));
    }
}

// -----------------------------
// Output
// -----------------------------

emi_shield_box();

// Faint PCB plane for visual context (comment out if it gets in the way).
%translate([-(HALF_X + FLANGE_W + 5),
            -(HALF_Y + FLANGE_W + 5),
            -1])
    color("green", 0.3)
        cube([TOP_X + 2 * (FLANGE_W + 5),
              TOP_Y + 2 * (FLANGE_W + 5),
              1]);

echo(str("EMI shield (3D) outside : ", TOP_X, " x ", TOP_Y, " x ", WALL_H, " mm"));
echo(str("Aperture (top, center)  : ", APERTURE_X, " x ", APERTURE_Y, " mm"));
echo(str("EMI tabs                : LEFT & RIGHT walls, both ends, ",
         TAB_LEN, " mm long"));
