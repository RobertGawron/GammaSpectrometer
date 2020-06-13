import pcbnew
import math

filepath = "../../Hardware/PhotomultiplierRadioactivityDetector/PhotomultiplierRadioactivityDetector.kicad_pcb"

pcb = pcbnew.LoadBoard(filepath)



resitors = ['R23', 'R24', 'R25', 'R26', 'R27', 'R28', 'R29', 'R30', 'R31', 'R32', 'R33']
capacitors = ['C18', 'C19', 'C20', 'C21', 'C22', 'C23', 'C24', 'C25', 'C26', 'C27', 'C28'] 

empty_pads = 1;
total_pads = len(resitors) + empty_pads +1

photomultiplier = pcb.FindModuleByReference('EL1')
initial_position = photomultiplier.GetPosition()

resistor_circle_radius = 19.5
capacitor_circle_radius = 22.75

phi = -math.radians(90) + math.radians(360 / total_pads)/2

for resistor in resitors:
    c = pcb.FindModuleByReference(resistor)
    
    (x,y) = initial_position
    (x, y) = (x/1000000, y/1000000) # KiCAD is inconsistent about length units
    
    x -= resistor_circle_radius * math.cos(phi)
    y -= resistor_circle_radius * math.sin(phi)

    c.SetPosition(pcbnew.wxPointMM(x, y))
    
    c.SetOrientation(( -math.degrees(phi) + 90 +180) * 10)
    phi += math.radians(360.0 / total_pads)



phi = -math.radians(90) + math.radians(360 / total_pads)/2

for capacitor in capacitors:
    c = pcb.FindModuleByReference(capacitor)
    
    (x,y) = initial_position
    (x, y) = (x/1000000, y/1000000) # KiCAD is inconsistent about length units
    
    x -= capacitor_circle_radius * math.cos(phi)
    y -= capacitor_circle_radius * math.sin(phi)

    c.SetPosition(pcbnew.wxPointMM(x, y))
    
    c.SetOrientation(( -math.degrees(phi) + 90 +180) * 10)
    phi += math.radians(360.0 / total_pads)


pcb.Save(filepath)