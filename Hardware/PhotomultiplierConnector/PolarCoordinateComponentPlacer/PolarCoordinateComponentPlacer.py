import pcbnew
import math


# took me a while to see that GetPosition() takes milidegrees
milidegrees_in_degree = 100

degree_full_turn = 360
degree_half_turn = degree_full_turn / 2
degree_quarter_turn = degree_full_turn / 4

filepath = "../PhotomultiplierConnector.kicad_pcb"

resitors_negative_polarity = ['R1', 'R2', 'R3', 'R4',
                              'R5', 'R6', 'R7', 'R8',
                              'R9', 'R10', 'R11']

capacitors_negative_polarity = ['C1', 'C2', 'C3', 'C4',
                                'C5', 'C6', 'C7', 'C8',
                                'C9', 'C10', 'C11']

resitors_positive_polarity = ['R14', 'R15', 'R16', 'R17',
                              'R18', 'R19', 'R20', 'R21',
                              'R22', 'R23', 'R24']

capacitors_positive_polarity = ['C12', 'C13', 'C14', 'C15',
                                'C16', 'C17', 'C18',
                                'C19', 'C20', 'C21', 'C22']

resistor_photomultiplier_distance = 19.5
capacitor_photomultiplier_distance = 22.75

# used to move WHOLE design on the screen
# while keeping distances between components
x_display_center = 0
y_display_center = 0

# 10cm x 10cm is cheepsest option in chineese PCB factories,
# so it's preferable to fit into those dimmensions.
pcb_width = 100
pcb_height = 2*capacitor_photomultiplier_distance + 10


def PlaceComponentsAroundPhotomultiplier(pcb,
                                         photomultiplier,
                                         components,
                                         radius):
    empty_pads = 1
    total_pads = len(components) + empty_pads

    initial_position = photomultiplier.GetPosition()
    target_rotation = (-degree_full_turn/total_pads + degree_quarter_turn) \
        * milidegrees_in_degree
    photomultiplier.SetOrientation(target_rotation)

    # TODO magic is here
    off = -1.25*degree_full_turn/(total_pads) / 100.0
    phi = off - degree_quarter_turn

    for component in components:
        c = pcb.FindModuleByReference(component)

        (x, y) = initial_position
        # KiCAD is inconsistent about length units
        (x, y) = (x/1000000, y/1000000)

        x -= radius * math.cos(phi)
        y -= radius * math.sin(phi)

        c.SetPosition(pcbnew.wxPointMM(x, y))
        c.SetOrientation((-math.degrees(phi) + degree_quarter_turn) * 10)

        phi += math.radians(360.0 / (total_pads + 1))


def addEdgeCut(pcb, start, stop):
    (start_x, start_y) = start
    (stop_x, stop_y) = stop
    line = pcbnew.DRAWSEGMENT(pcb)
    line.SetShape(pcbnew.S_SEGMENT)
    line.SetStart(pcbnew.wxPointMM(start_x, start_y))
    line.SetEnd(pcbnew.wxPointMM(stop_x, stop_y))
    line.SetLayer(pcb.GetLayerID('Edge.Cuts'))
    line.SetWidth(pcbnew.FromMM(1))
    pcb.Add(line)


def addEdgeCuts(pcb):
    addEdgeCut(pcb, (x_display_center, y_display_center),
               (x_display_center, pcb_height + y_display_center))

    addEdgeCut(pcb, (pcb_width + x_display_center, y_display_center),
               (pcb_width + x_display_center, pcb_height + y_display_center))

    addEdgeCut(pcb, (x_display_center, y_display_center),
               (pcb_width + x_display_center, y_display_center))

    addEdgeCut(pcb, (x_display_center, pcb_height + y_display_center),
               (pcb_width + x_display_center, pcb_height + y_display_center))


if __name__ == "__main__":
    pcb = pcbnew.LoadBoard(filepath)

    addEdgeCuts(pcb)

    photomultiplier = pcb.FindModuleByReference('EL1')
    photomultiplier_x = pcb_width / 4
    photomultiplier_y = pcb_height / 2

    photomultiplier_position = \
        pcbnew.wxPointMM(photomultiplier_x + x_display_center,
                         photomultiplier_y + y_display_center)

    photomultiplier.SetPosition(photomultiplier_position)

    PlaceComponentsAroundPhotomultiplier(pcb,
                                         photomultiplier,
                                         resitors_negative_polarity,
                                         resistor_photomultiplier_distance)
    PlaceComponentsAroundPhotomultiplier(pcb,
                                         photomultiplier,
                                         capacitors_negative_polarity,
                                         capacitor_photomultiplier_distance)

    photomultiplier = pcb.FindModuleByReference('EL2')
    photomultiplier_x += pcb_width/2
    photomultiplier_position = \
        pcbnew.wxPointMM(photomultiplier_x + x_display_center,
                         photomultiplier_y + y_display_center)

    photomultiplier.SetPosition(photomultiplier_position)

    PlaceComponentsAroundPhotomultiplier(pcb,
                                         photomultiplier,
                                         resitors_positive_polarity,
                                         resistor_photomultiplier_distance)
    PlaceComponentsAroundPhotomultiplier(pcb,
                                         photomultiplier,
                                         capacitors_positive_polarity,
                                         capacitor_photomultiplier_distance)

    pcb.Save(filepath)
