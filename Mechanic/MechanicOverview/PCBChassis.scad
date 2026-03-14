


module PCB_Chassis_Screw_Holes (PCB_CHASIS_X_TOTAL, 
                        PCB_CHASIS_Y_TOTAL, 
                        PCB_CHASIS_Z_TOTAL, 
                        SCREW_HOLE_1_X_OFFSET,
                        SCREW_HOLE_2_X_OFFSET,
                        SCREW_RADIUS )
{
    translate([PCB_CHASIS_X_TOTAL/2 - SCREW_HOLE_1_X_OFFSET, PCB_CHASIS_Y_TOTAL/2, PCB_CHASIS_Z_TOTAL/2])
    {
        rotate([90,0,0])
        {
            linear_extrude(height = PCB_CHASIS_Y_TOTAL, convexity = 10, twist = 0)
            {
                circle (r = SCREW_RADIUS);
            }
        }
    }

    translate([PCB_CHASIS_X_TOTAL/2 - SCREW_HOLE_2_X_OFFSET, PCB_CHASIS_Y_TOTAL/2, PCB_CHASIS_Z_TOTAL/2])
    {
        rotate([90,0,0])
        {
            linear_extrude(height = PCB_CHASIS_Y_TOTAL, convexity = 10, twist = 0)
            {
                circle (r = SCREW_RADIUS);
            }
        }
    }
}

module PCB_Chassis (PCB_CHASIS_X_TOTAL, 
                PCB_CHASIS_Y_TOTAL, 
                PCB_CHASIS_Z_TOTAL, 
                PCB_CHASIS_X_INSIDE, 
                PCB_CHASIS_Y_INSIDE,
                PCB_CHASIS_Z_INSIDE,
                PCB_CHASIS_LID_HEIGH,
                SCREW_HOLE_1_X_OFFSET,
                SCREW_HOLE_2_X_OFFSET,
                SCREW_RADIUS ) 
{
    difference()
    {
        // outside of the chassis
        linear_extrude(height = PCB_CHASIS_Z_TOTAL, convexity = 10, twist = 0)
            square([PCB_CHASIS_X_TOTAL, PCB_CHASIS_Y_TOTAL], center= true);

        // inside of the chassis
        translate([0, 0, PCB_CHASIS_LID_HEIGH / 2]) // TODO: this /2 is a hack
            linear_extrude(height = PCB_CHASIS_Z_INSIDE, convexity = 10, twist = 0)
                square([PCB_CHASIS_X_INSIDE, PCB_CHASIS_Y_INSIDE], center= true);
       
        PCB_Chassis_Screw_Holes(PCB_CHASIS_X_TOTAL, 
                            PCB_CHASIS_Y_TOTAL, 
                            PCB_CHASIS_Z_TOTAL, 
                            SCREW_HOLE_1_X_OFFSET,
                            SCREW_HOLE_2_X_OFFSET,
                            SCREW_RADIUS );
    }
}
