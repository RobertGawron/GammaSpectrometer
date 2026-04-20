from KicadModTree import *
import os

INCH = 25.4

# =============================================
# BUD CU-470 Dimensions (inches)
# =============================================
BODY_W = 2.000 * INCH      # Outer body width (X)
BODY_H = 2.000 * INCH      # Outer body height (Y)
CAVITY_W = 1.625 * INCH    # Internal cavity width
CAVITY_H = 1.625 * INCH    # Internal cavity height

HOLE_DRILL = 3.6
BOSS_PAD = 8.0
RING_EXTRA = 2.5           # Increase this to expand ring both ways

# Output
OUTPUT_DIR = "../../GammaSpectrometer.pretty"
FILENAME = "BUD_CU-470_Shield.kicad_mod"

# =============================================
footprint = Footprint("BUD_CU-470_Shield")
footprint.setDescription("BUD CU-470 aluminium shield enclosure, open end down, EMI grounding ring")
footprint.setTags("BUD CU-470 shield enclosure EMI RF aluminium")

# Reference and Value
footprint.append(Text(type='reference', text='REF**', at=[0, -BODY_H/2 - 6], layer='F.SilkS'))
footprint.append(Text(type='value',   text='BUD_CU-470_Shield', at=[0, BODY_H/2 + 6], layer='F.Fab'))

# ====================== MOUNTING HOLES ======================
hx = CAVITY_W / 2
hy = CAVITY_H / 2

for pos in [(-hx, -hy), (hx, -hy), (hx, hy), (-hx, hy)]:
    footprint.append(
        Pad(number="1",
            type=Pad.TYPE_THT,
            shape=Pad.SHAPE_CIRCLE,
            at=pos,
            size=[BOSS_PAD, BOSS_PAD],
            drill=HOLE_DRILL,
            layers=Pad.LAYERS_THT)
    )

# ====================== COPPER RING (EMI Ground) ======================


# Four rectangular pads forming the frame
# Top and Bottom
footprint.append(Pad(number="5", type=Pad.TYPE_SMT, shape=Pad.SHAPE_RECT,
                     at=[0, -BODY_H/2 ],
                     size=[BODY_W, RING_EXTRA],
                     layers=["F.Cu", "F.Mask"]))

footprint.append(Pad(number="5", type=Pad.TYPE_SMT, shape=Pad.SHAPE_RECT,
                     at=[0, BODY_H/2],
                     size=[BODY_W, RING_EXTRA],
                     layers=["F.Cu", "F.Mask"]))


# Left and Right
footprint.append(Pad(number="5", type=Pad.TYPE_SMT, shape=Pad.SHAPE_RECT,
                     at=[-BODY_W/2 , 0],
                     size=[RING_EXTRA, BODY_H],
                     layers=["F.Cu", "F.Mask"]))

footprint.append(Pad(number="5", type=Pad.TYPE_SMT, shape=Pad.SHAPE_RECT,
                     at=[BODY_W/2 , 0],
                     size=[RING_EXTRA, BODY_H],
                     layers=["F.Cu", "F.Mask"]))

# ====================== GRAPHICS ======================
# Body outline (actual enclosure size)
footprint.append(RectLine(start=[-BODY_W/2, -BODY_H/2],
                          end=[BODY_W/2, BODY_H/2],
                          layer='F.Fab', width=0.15))

# Cavity outline
footprint.append(RectLine(start=[-CAVITY_W/2, -CAVITY_H/2],
                          end=[CAVITY_W/2, CAVITY_H/2],
                          layer='Dwgs.User', width=0.10))

# Silkscreen outline (slightly larger)
footprint.append(RectLine(start=[-BODY_W/2 - 0.5, -BODY_H/2 - 0.5],
                          end=[BODY_W/2 + 0.5, BODY_H/2 + 0.5],
                          layer='F.SilkS', width=0.12))

# Courtyard
footprint.append(RectLine(start=[-BODY_W/2 - 1.0, -BODY_H/2 - 1.0],
                          end=[BODY_W/2 + 1.0, BODY_H/2 + 1.0],
                          layer='F.CrtYd', width=0.05))

# Screw boss indicators
for x, y in [(-hx, -hy), (hx, -hy), (hx, hy), (-hx, hy)]:
    footprint.append(Circle(center=[x, y], radius=3.0, layer='F.Fab', width=0.10))

# ====================== SAVE ======================
os.makedirs(OUTPUT_DIR, exist_ok=True)
full_path = os.path.join(OUTPUT_DIR, FILENAME)

KicadFileHandler(footprint).writeFile(full_path)
print(f"Footprint successfully written to:\n   {full_path}")