include <EMIShieldBoxConstants.scad>;
use     <EMIShieldBoxParts.scad>;

// =============================================================
// EMI shield enclosure - 2D flat pattern (manufacturing blank)
// =============================================================
//
// Assembly = top panel + 4 side strips (wall + flange).
// EMI overlap tabs are placed on the LEFT and RIGHT walls at BOTH ends.
// When folded, those tabs bend 90 deg inward and lap behind the TOP and
// BOTTOM walls on the inside of the box, ensuring conductive continuity
// at every vertical corner.
//
// All actual geometry lives in EMIShieldBoxParts.scad. This file only
// places the parts around the top panel using place_strip().

SHOW_FOLD_LINES = false;

module flat_pattern() {
    top_panel_2d();

    // Tabs only on LEFT and RIGHT side strips
    place_strip("left")   side_strip_2d(strip_length("left"),   tab_left = true, tab_right = true);
    place_strip("right")  side_strip_2d(strip_length("right"),  tab_left = true, tab_right = true);

    place_strip("bottom") side_strip_2d(strip_length("bottom"));
    place_strip("top")    side_strip_2d(strip_length("top"));
}

module fold_lines_overlay() {
    place_strip("left")   side_strip_fold_lines(strip_length("left"),   tab_left = true, tab_right = true);
    place_strip("right")  side_strip_fold_lines(strip_length("right"),  tab_left = true, tab_right = true);
    place_strip("bottom") side_strip_fold_lines(strip_length("bottom"));
    place_strip("top")    side_strip_fold_lines(strip_length("top"));
}

// -----------------------------
// Output (manufacturing geometry only)
// -----------------------------

flat_pattern();

if (SHOW_FOLD_LINES) %color("blue") fold_lines_overlay();

echo(str("EMI shield flat blank   : ", TOTAL_X, " x ", TOTAL_Y, " mm"));
echo(str("Top panel               : ", TOP_X,   " x ", TOP_Y,   " mm"));
echo(str("Wall height             : ", WALL_H,  " mm"));
echo(str("Flange width            : ", FLANGE_W," mm"));
echo(str("EMI tab length          : ", TAB_LEN, " mm (on left/right walls)"));
echo(str("Aperture (top, center)  : ", APERTURE_X, " x ", APERTURE_Y, " mm"));
echo(str("Mount hole diameter     : ", MOUNT_HOLE_D, " mm"));
echo(str("Holes per flange        : 2 (", HOLE_EDGE_MARGIN, " mm in from each end)"));
