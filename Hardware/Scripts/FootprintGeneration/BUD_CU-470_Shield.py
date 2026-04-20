from KicadModTree import *
import os

INCH = 25.4

# Dimensions
A = 2.000 * INCH
B = 2.000 * INCH
E = 1.625 * INCH
F = 1.625 * INCH

HOLE_DRILL = 3.6
BOSS_PAD = 8.0
RING_EXTRA = 0.2

# Derived
hx = E / 2
hy = F / 2
ring_width = (A - E) / 2 + RING_EXTRA

footprint = Footprint("BUD_CU-470_Shield")
footprint.setDescription("BUD CU-470 aluminium shield enclosure")
footprint.setTags("BUD CU-470 shield enclosure EMI RF")

# Reference / value
footprint.append(Text(type='reference', text='REF**', at=[0, -A/2 - 5], layer='F.SilkS'))
footprint.append(Text(type='value', text='BUD_CU-470_Shield', at=[0, A/2 + 5], layer='F.Fab'))

# Mounting holes
for i, (x, y) in enumerate([(-hx,-hy),(hx,-hy),(hx,hy),(-hx,hy)], 1):
    footprint.append(
        Pad(number=str(i),
            type=Pad.TYPE_THT,
            shape=Pad.SHAPE_CIRCLE,
            at=[x, y],
            size=[BOSS_PAD, BOSS_PAD],
            drill=HOLE_DRILL,
            layers=Pad.LAYERS_THT)
    )

# Copper ring (4 rectangles)
footprint.append(
    Pad(number="5",
        type=Pad.TYPE_SMT,
        shape=Pad.SHAPE_RECT,
        at=[0, -A/2 + ring_width/2],
        size=[A, ring_width],
        layers=["F.Cu","F.Mask"])
)

footprint.append(
    Pad(number="5",
        type=Pad.TYPE_SMT,
        shape=Pad.SHAPE_RECT,
        at=[0, A/2 - ring_width/2],
        size=[A, ring_width],
        layers=["F.Cu","F.Mask"])
)

# Save
output_dir = "../../GammaSpectrometer.pretty"
os.makedirs(output_dir, exist_ok=True)

file_handler = KicadFileHandler(footprint)
file_handler.writeFile(os.path.join(output_dir, "BUD_CU-470_Shield.kicad_mod"))

print("Footprint generated successfully.")