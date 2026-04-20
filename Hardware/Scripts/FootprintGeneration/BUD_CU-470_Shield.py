from KicadModTree import *
import os

INCH = 25.4

# Dimensions
A = 2.000 * INCH
B = 2.000 * INCH
E = 1.625 * INCH
F = 1.625 * INCH
J = 0.065 * INCH

HOLE_DRILL = 3.6
BOSS_PAD = 8.0
RING_EXTRA = 0.2

# Derived
hx = E / 2
hy = F / 2
ring_width = J + RING_EXTRA
corner_radius = 0.125 * INCH + RING_EXTRA / 2   # as per datasheet + adjustment

PAD_NUMBER = "1"

footprint = Footprint("BUD_CU-470_Shield")
footprint.setDescription("BUD CU-470 aluminium shield enclosure")
footprint.setTags("BUD CU-470 shield enclosure EMI RF")

# Reference / value
footprint.append(Text(type='reference', text='REF**', at=[0, -A/2 - 5], layer='F.SilkS'))
footprint.append(Text(type='value', text='BUD_CU-470_Shield', at=[0, A/2 + 5], layer='F.Fab'))

# Mounting holes
for i, (x, y) in enumerate([(-hx,-hy),(hx,-hy),(hx,hy),(-hx,hy)], 1):
    footprint.append(
        Pad(number=PAD_NUMBER,
            type=Pad.TYPE_THT,
            shape=Pad.SHAPE_CIRCLE,
            at=[x, y],
            size=[BOSS_PAD, BOSS_PAD],
            drill=HOLE_DRILL,
            layers=Pad.LAYERS_THT)
    )

# Copper ring - straight parts
# Top
footprint.append(
    Pad(number=PAD_NUMBER,
        type=Pad.TYPE_SMT,
        shape=Pad.SHAPE_RECT,
        at=[0, -B/2 ],
        size=[A  -ring_width, ring_width],
        layers=["F.Cu","F.Mask"])
)

# Bottom
footprint.append(
    Pad(number=PAD_NUMBER,
        type=Pad.TYPE_SMT,
        shape=Pad.SHAPE_RECT,
        at=[0, B/2 ],
        size=[A -ring_width, ring_width],
        layers=["F.Cu","F.Mask"])
)


# Left 
footprint.append(
    Pad(number=PAD_NUMBER,
        type=Pad.TYPE_SMT,
        shape=Pad.SHAPE_RECT,
        at=[-A/2 , 0],
        size=[ring_width , B-ring_width],
        layers=["F.Cu","F.Mask"])
)


# Right
footprint.append(
    Pad(number=PAD_NUMBER,
        type=Pad.TYPE_SMT,
        shape=Pad.SHAPE_RECT,
        at=[A/2 , 0],
        size=[ring_width, B-ring_width],
        layers=["F.Cu","F.Mask"])
)

# External corner circles to fill the dent (as requested)
"""corner_offset_x = A/2 - 5
corner_offset_y = B/2 - corner_radius- RING_EXTRA
r = corner_radius

footprint.append(Circle(center=[-corner_offset_x, -corner_offset_y], radius=r, 
                       layer="F.Cu", width=0))
footprint.append(Circle(center=[ corner_offset_x, -corner_offset_y], radius=r, 
                       layer="F.Cu", width=0))
footprint.append(Circle(center=[ corner_offset_x,  corner_offset_y], radius=r, 
                       layer="F.Cu", width=0))
footprint.append(Circle(center=[-corner_offset_x,  corner_offset_y], radius=r, 
                       layer="F.Cu", width=0))

# Also add same circles on F.Mask so the solder mask follows
footprint.append(Circle(center=[-corner_offset_x, -corner_offset_y], radius=r, 
                       layer="F.Mask", width=0))
footprint.append(Circle(center=[ corner_offset_x, -corner_offset_y], radius=r, 
                       layer="F.Mask", width=0))
footprint.append(Circle(center=[ corner_offset_x,  corner_offset_y], radius=r, 
                       layer="F.Mask", width=0))
footprint.append(Circle(center=[-corner_offset_x,  corner_offset_y], radius=r, 
                       layer="F.Mask", width=0))
"""
# Save
output_dir = "../../GammaSpectrometer.pretty"
os.makedirs(output_dir, exist_ok=True)

file_handler = KicadFileHandler(footprint)
file_handler.writeFile(os.path.join(output_dir, "BUD_CU-470_Shield.kicad_mod"))

print("Footprint generated successfully.")