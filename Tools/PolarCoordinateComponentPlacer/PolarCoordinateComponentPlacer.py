import pcbnew
import math

# took me a while to see that GetPosition() takes milidegrees
milidegrees_in_degree = 100

degree_full_turn = 360
degree_quarter_turn = degree_full_turn / 4

filepath = "../../Hardware/PhotomultiplierConnector/PhotomultiplierConnector.kicad_pcb"

resistor_photomultiplier_distance = 19.5
capacitor_photomultiplier_distance = 22.75

resitors_negative_polarity = ['R1', 'R2', 'R3', 'R4', 'R5', 'R6', 'R7', 'R8', 'R9', 'R10', 'R11']
capacitors_negative_polarity = ['C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11'] 

resitors_positive_polarity = ['R14', 'R15', 'R16', 'R17', 'R18', 'R19', 'R20', 'R21', 'R22', 'R23', 'R24']
capacitors_positive_polarity = ['C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18', 'C19', 'C20', 'C21', 'C22'] 

# used to move WHOLE design on the screen while keeping distances between components
x_display_center = 100
y_display_center = 100


def PlaceComponentsAroundPhotomultiplier(pcb, photomultiplier, components, radius):
    empty_pads = 1
    total_pads = len(components) + empty_pads

    initial_position = photomultiplier.GetPosition()
    target_rotation = (-degree_full_turn/total_pads + degree_quarter_turn) * milidegrees_in_degree
    #photomultiplier.SetOrientation(target_rotation)
    print (target_rotation)

    # TODO magic is here
    off = -1.25*degree_full_turn/(total_pads) / 100.0
    phi = off -degree_quarter_turn

    for component in components:
        c = pcb.FindModuleByReference(component)
        
        (x,y) = initial_position
        (x, y) = (x/1000000, y/1000000) # KiCAD is inconsistent about length units
        
        x -= radius * math.cos(phi)
        y -= radius * math.sin(phi)

        c.SetPosition(pcbnew.wxPointMM(x, y))
        
        c.SetOrientation((-math.degrees(phi) +degree_quarter_turn) * 10)

        phi += math.radians(360.0 / (total_pads + 1))



def createEdgeCutsLine(pcb, (start_x, start_y), (stop_x, stop_y)):
    line = pcbnew.DRAWSEGMENT(pcb)
    line.SetShape(pcbnew.S_SEGMENT)
    line.SetStart(pcbnew.wxPointMM(start_x, start_y))
    line.SetEnd(pcbnew.wxPointMM(stop_x, stop_y))
    line.SetLayer(pcb.GetLayerID('Edge.Cuts'))
    line.SetWidth(pcbnew.FromMM(1))
    pcb.Add(line)


if __name__ == "__main__":
    pcb = pcbnew.LoadBoard(filepath)

    photomultiplier = pcb.FindModuleByReference('EL1')

    photomultiplier.SetPosition(pcbnew.wxPointMM(x_display_center, y_display_center))

    createEdgeCutsLine(pcb, (-30 + x_display_center, 20 + x_display_center), (30 + x_display_center, 20 + x_display_center))
    createEdgeCutsLine(pcb, (-30 + x_display_center, -20 + x_display_center), (30 + x_display_center, -20 + x_display_center))


    arc = pcbnew.DRAWSEGMENT(pcb)
    arc.SetShape(pcbnew.S_CIRCLE)
    arc.SetCenter(pcbnew.wxPointMM(x_display_center,y_display_center))

    arc.SetArcStart(pcbnew.wxPointMM(4,18))
    arc.SetLayer(pcb.GetLayerID('Edge.Cuts'))
    arc.SetWidth(pcbnew.FromMM(1))

    pcb.Add(arc)





    PlaceComponentsAroundPhotomultiplier(pcb, photomultiplier, resitors_negative_polarity, resistor_photomultiplier_distance)
    PlaceComponentsAroundPhotomultiplier(pcb, photomultiplier, capacitors_negative_polarity, capacitor_photomultiplier_distance)

    photomultiplier = pcb.FindModuleByReference('EL2')
    photomultiplier.SetPosition(pcbnew.wxPointMM(x_display_center, y_display_center))

    PlaceComponentsAroundPhotomultiplier(pcb, photomultiplier, resitors_positive_polarity, resistor_photomultiplier_distance)
    PlaceComponentsAroundPhotomultiplier(pcb, photomultiplier, capacitors_positive_polarity, capacitor_photomultiplier_distance)
    
    pcb.Save(filepath)