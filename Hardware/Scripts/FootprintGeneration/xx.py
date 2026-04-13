#!/usr/bin/env python3
"""
KiCad Footprint Generator — BUD Industries CU-470 … CU-479 Econoboxes
======================================================================
Generates .kicad_mod files from datasheet hb470-1 dimensions.

  python3 cu470_footprint.py              # CU-470 (default)
  python3 cu470_footprint.py CU-473       # a specific model
  python3 cu470_footprint.py --all        # every model in the table

Output is KiCad 7/8 compatible (.kicad_mod).

⚠ Mounting-hole centres are *estimated* at the inner-wall corners.
  Verify against the real enclosure before ordering PCBs!
"""

import sys

INCH = 25.4  # mm per inch

# ── Datasheet table (inches) ── hb470-1, rev 10-14-09 ──────
# A=body length  B=body width  C=assy height  D=int depth
# E=int length   F=int width   G,H=guide dims (may be None)
# J=lip height   K=lip width   L=cover overlap
MODELS = {
    "CU-470": dict(A=2.000, B=2.000, C=1.250, D=1.094,
                   E=1.625, F=1.625, J=0.065, K=0.065, L=0.188),
    "CU-471": dict(A=4.330, B=3.250, C=1.750, D=1.594,
                   E=3.955, F=2.875, J=0.094, K=0.078, L=0.188),
    "CU-472": dict(A=4.750, B=3.150, C=2.330, D=2.174,
                   E=4.375, F=2.775, J=0.094, K=0.078, L=0.188),
    "CU-473": dict(A=4.688, B=3.688, C=1.340, D=1.184,
                   E=4.313, F=3.313, J=0.094, K=0.078, L=0.188),
    "CU-474": dict(A=4.750, B=4.750, C=2.330, D=2.174,
                   E=4.375, F=4.375, J=0.094, K=0.078, L=0.188),
    "CU-475": dict(A=4.750, B=4.750, C=3.750, D=3.594,
                   E=4.375, F=4.375, J=0.094, K=0.078, L=0.188),
    "CU-476": dict(A=6.000, B=3.250, C=2.000, D=1.844,
                   E=5.610, F=2.860, J=0.094, K=0.078, L=0.195),
    "CU-477": dict(A=7.390, B=4.703, C=1.500, D=1.344,
                   E=7.000, F=4.313, J=0.094, K=0.078, L=0.195),
    "CU-478": dict(A=7.500, B=7.500, C=2.620, D=2.464,
                   E=7.110, F=7.110, J=0.094, K=0.078, L=0.195),
    "CU-479": dict(A=4.375, B=2.375, C=2.136, D=1.980,
                   E=4.000, F=2.000, J=0.065, K=0.078, L=0.188),
}

# ── PCB parameters (mm) ────────────────────────────────────
DRILL_MM   = 3.6     # clearance for #6 screw (shaft ≈ 3.5 mm)
PAD_MM     = 7.0     # copper annular ring
CRT_MM     = 1.0     # courtyard gap
BOSS_INCH  = 0.312   # estimated screw-boss OD (from drawing)


# ── helpers ─────────────────────────────────────────────────
def _rect(cx, cy, w, h, layer, lw):
    """Return four fp_line strings forming a centred rectangle."""
    x1, y1 = cx - w / 2, cy - h / 2
    x2, y2 = cx + w / 2, cy + h / 2
    segs = [(x1,y1,x2,y1),(x2,y1,x2,y2),(x2,y2,x1,y2),(x1,y2,x1,y1)]
    return [
        f'  (fp_line (start {a:.4f} {b:.4f}) (end {c:.4f} {d:.4f})'
        f' (layer "{layer}") (width {lw:.2f}))'
        for a, b, c, d in segs
    ]


def build_footprint(part):
    """Return the full .kicad_mod text for *part*."""
    d    = MODELS[part]
    bw   = d["A"] * INCH                # body width  (mm)
    bh   = d["B"] * INCH                # body height (mm)
    iw   = d["E"] * INCH                # internal w  (mm)
    ih   = d["F"] * INCH                # internal h  (mm)
    wx   = (bw - iw) / 2                # wall X
    wy   = (bh - ih) / 2                # wall Y
    br   = BOSS_INCH * INCH / 2         # boss radius (mm)
    hx   = bw / 2 - wx                  # hole centre X
    hy   = bh / 2 - wy                  # hole centre Y
    name = f"BUD_{part}_{bw:.1f}x{bh:.1f}mm"

    o = []          # output lines
    a = o.append
    e = o.extend

    # ── header ──
    a(f'(footprint "{name}"')
    a(f'  (layer "F.Cu")')
    a(f'  (descr "BUD Industries {part} Econobox,'
      f' {d["A"]:.3f} x {d["B"]:.3f} x {d["C"]:.3f} in, aluminium")')
    a(f'  (tags "enclosure box aluminium BUD {part} econobox")')
    a(f'  (attr board_only exclude_from_pos_file exclude_from_bom)')
    a('')

    # ── text ──
    ry = -(bh / 2 + 3)
    vy =   bh / 2 + 3
    for kind, txt, y, lay in [("reference","REF**",ry,"F.SilkS"),
                               ("value",name,vy,"F.Fab"),
                               ("user","${REFERENCE}",0,"F.Fab")]:
        a(f'  (fp_text {kind} "{txt}" (at 0 {y:.2f}) (layer "{lay}")')
        a(f'    (effects (font (size 1 1) (thickness 0.15)))')
        a(f'  )')
    a('')

    # ── rectangles ──
    a('  ; ── body outline (external) ──')
    e(_rect(0, 0, bw, bh, "F.Fab", 0.10))
    a('')
    a('  ; ── internal cavity ──')
    e(_rect(0, 0, iw, ih, "Dwgs.User", 0.10))
    a('')
    a('  ; ── silkscreen ──')
    e(_rect(0, 0, bw, bh, "F.SilkS", 0.12))
    a('')
    a('  ; ── courtyard ──')
    e(_rect(0, 0, bw + 2*CRT_MM, bh + 2*CRT_MM, "F.CrtYd", 0.05))
    a('')

    # ── screw-boss circles & mounting holes ──
    corners = [(-1,-1),(1,-1),(1,1),(-1,1)]

    a('  ; ── screw-boss indicators ──')
    for sx, sy in corners:
        cx, cy = sx * hx, sy * hy
        a(f'  (fp_circle (center {cx:.4f} {cy:.4f})'
          f' (end {cx+br:.4f} {cy:.4f})'
          f' (layer "F.Fab") (width 0.10))')
    a('')

    a('  ; ── mounting holes  #6-32 clearance ──')
    for i, (sx, sy) in enumerate(corners, 1):
        px, py = sx * hx, sy * hy
        a(f'  (pad "{i}" thru_hole circle'
          f' (at {px:.4f} {py:.4f})'
          f' (size {PAD_MM} {PAD_MM})'
          f' (drill {DRILL_MM})'
          f' (layers "*.Cu" "*.Mask"))')

    a(')')
    return '\n'.join(o)


# ── main ────────────────────────────────────────────────────
def main():
    targets = ["CU-470"]
    if len(sys.argv) > 1:
        arg = sys.argv[1].upper()
        if arg == "--ALL":
            targets = list(MODELS.keys())
        elif arg in MODELS:
            targets = [arg]
        else:
            sys.exit(f"Unknown model '{arg}'.  "
                     f"Choose from {', '.join(MODELS)} or --all")

    for part in targets:
        d = MODELS[part]
        content = build_footprint(part)
        fname   = f"../../GammaSpectrometer.pretty/BUD_{part}.kicad_mod"

        with open(fname, "w") as fh:
            fh.write(content)

        bw, bh = d["A"]*INCH, d["B"]*INCH
        iw, ih = d["E"]*INCH, d["F"]*INCH
        wall   = (bw - iw) / 2
        hx, hy = bw/2 - wall, bh/2 - wall

        print(f"✅  {fname}")
        print(f"    Body      {bw:7.2f} × {bh:.2f} mm")
        print(f"    Internal  {iw:7.2f} × {ih:.2f} mm")
        print(f"    Depth     {d['D']*INCH:7.2f} mm")
        print(f"    Wall      {wall:7.2f} mm")
        print(f"    Holes     {2*hx:7.2f} × {2*hy:.2f} mm spacing  "
              f"(Ø{DRILL_MM} drill, Ø{PAD_MM} pad)")
        print()

    print("⚠  Hole positions are ESTIMATED from wall thickness.")
    print("   Measure the real enclosure before fabricating PCBs!")


if __name__ == "__main__":
    main()