include <HorizontalRods.scad>


module PCB_Chassis_Holder_Screw_Holes (PCB_CHASIS_X_TOTAL, 
                                    PCB_CHASIS_Y_TOTAL, 
                                    SHIELD_MOUNTING_BAR_HEIGHT,
                                    SHIELD_MOUNTING_BAR_THICKNESS,
                                    SCREW_HOLE_1_Y_OFFSET,
                                    SCREW_HOLE_2_Y_OFFSET,
                                    SCREW_RADIUS) 
{
    translate([-PCB_CHASIS_X_TOTAL/2, /*-PCB_CHASIS_Y_TOTAL/2 +*/ SCREW_HOLE_1_Y_OFFSET, SHIELD_MOUNTING_BAR_HEIGHT/2])
    {
        rotate([0,90,0])
        {
            linear_extrude(height = PCB_CHASIS_X_TOTAL, convexity = 10, twist = 0)
            {
                circle (r = SCREW_RADIUS);
            }
        }
    }

    translate([-PCB_CHASIS_X_TOTAL/2, /*-PCB_CHASIS_Y_TOTAL/2 +*/ SCREW_HOLE_2_Y_OFFSET, SHIELD_MOUNTING_BAR_HEIGHT/2])
    {
        rotate([0,90,0])
        {
            linear_extrude(height = PCB_CHASIS_X_TOTAL, convexity = 10, twist = 0)
            {
                circle (r = SCREW_RADIUS);
            }
        }
    }
}

module PCB_Chassis_Holder (ROD_OFFSET_X,
                        ROD_OFFSET_Y, 
                        PCB_CHASIS_X_TOTAL, 
                        PCB_CHASIS_Y_TOTAL,
                        SHIELD_MOUNTING_BAR_HEIGHT, 
                        SHIELD_MOUNTING_BAR_THICKNESS,
                        SCREW_HOLE_1_Y_OFFSET,
                        SCREW_HOLE_2_Y_OFFSET,
                        SCREW_RADIUS) 
{
    BAR_THICKNESS = SHIELD_MOUNTING_BAR_THICKNESS / 2;

    difference()
    {
        linear_extrude(height = SHIELD_MOUNTING_BAR_HEIGHT, convexity = 10, twist = 0)
        {
            difference()
            {
                union()
                {
                    polygon (points= [
                            [-ROD_OFFSET_X - BAR_THICKNESS, -ROD_OFFSET_Y],
                            [-ROD_OFFSET_X + BAR_THICKNESS, -ROD_OFFSET_Y],
                            [-PCB_CHASIS_Y_TOTAL/2, -30],
                            [-PCB_CHASIS_Y_TOTAL/2, 30],
                            [-ROD_OFFSET_X + BAR_THICKNESS, ROD_OFFSET_Y],
                            [-ROD_OFFSET_X - BAR_THICKNESS, ROD_OFFSET_Y],
                            [-PCB_CHASIS_Y_TOTAL/2 - 2*BAR_THICKNESS, 30],
                            [-PCB_CHASIS_Y_TOTAL/2 - 2*BAR_THICKNESS, -30],

                        ] );

                        polygon (points= [
                            [ROD_OFFSET_X + BAR_THICKNESS, -ROD_OFFSET_Y],
                            [ROD_OFFSET_X - BAR_THICKNESS, -ROD_OFFSET_Y],
                            [PCB_CHASIS_Y_TOTAL/2, -30],
                            [PCB_CHASIS_Y_TOTAL/2, 30],
                            [ROD_OFFSET_X - BAR_THICKNESS, ROD_OFFSET_Y],
                            [ROD_OFFSET_X + BAR_THICKNESS, ROD_OFFSET_Y],
                            [PCB_CHASIS_Y_TOTAL/2 + 2*BAR_THICKNESS, 30],
                            [PCB_CHASIS_Y_TOTAL/2 + 2*BAR_THICKNESS, -30],

                        ] );

                        Horizontal_Rods_Mountings(ROD_OFFSET_X, ROD_OFFSET_Y);
                }
                Horizontal_Rods_Inner_Holes(ROD_OFFSET_X, ROD_OFFSET_Y);
            }
        }

        PCB_Chassis_Holder_Screw_Holes(PCB_CHASIS_X_TOTAL, 
                                    PCB_CHASIS_Y_TOTAL, 
                                    SHIELD_MOUNTING_BAR_HEIGHT,
                                    SHIELD_MOUNTING_BAR_THICKNESS,
                                    SCREW_HOLE_1_Y_OFFSET,
                                    SCREW_HOLE_2_Y_OFFSET,
                                    SCREW_RADIUS);
        }
}
