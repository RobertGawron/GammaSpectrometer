PHOTOMULTIPLIER_PCB_MAX_LENGTH = 100;
PHOTOMULTIPLIER_CONNECTOR_RADIUS = 20;
PHOTOMULTIPLIER_LEFT_CONNECTOR_DISTANCE_PCB_CENTER = (PHOTOMULTIPLIER_PCB_MAX_LENGTH / 2) /2;
PHOTOMULTIPLIER_RIGHT_CONNECTOR_DISTANCE_PCB_CENTER = - PHOTOMULTIPLIER_LEFT_CONNECTOR_DISTANCE_PCB_CENTER;

// this will done on PCB, so to reduce manufacture cost it must fit to 10cm x 10xm space
module Photomultiplier_PCB_Connector (Pcb_Thickness) 
{
    PHOTOMULTIPLIER_CENTER_CONNECTOR_THICKNESS = 30;

    linear_extrude(height = Pcb_Thickness, convexity = 10, twist = 0)
        union()
        {
            // only left or right connector will  be used, other will be cut-out,
            // on this simmulation, left connector is not present (cut-out)
            //translate([PHOTOMULTIPLIER_LEFT_CONNECTOR_DISTANCE_PCB_CENTER, 0, 0])
            //    circle(r=PHOTOMULTIPLIER_CONNECTOR_RADIUS);

            // center connector (power supply)
            square([PHOTOMULTIPLIER_LEFT_CONNECTOR_DISTANCE_PCB_CENTER, PHOTOMULTIPLIER_CENTER_CONNECTOR_THICKNESS], center = true);

            // right connector (photomultiplier)
            translate([PHOTOMULTIPLIER_RIGHT_CONNECTOR_DISTANCE_PCB_CENTER, 0, 0])
                circle(r=PHOTOMULTIPLIER_CONNECTOR_RADIUS);
        }
}