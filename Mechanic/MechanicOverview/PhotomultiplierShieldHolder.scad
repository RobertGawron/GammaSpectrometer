module Photomultiplier_Shield_Holder (ROD_OFFSET_X, ROD_OFFSET_Y, PHOTOMULTIPLIER_SHIELD_OUTER_RADIUS, BAR_THICKNESS) 
{
    // params for ring holding shield
    SHIELD_HOLDER_OUTER_THICKNESS = 8;
    SHIELD_HOLDER_INNER_RADIUS = PHOTOMULTIPLIER_SHIELD_OUTER_RADIUS;
    SHIELD_HOLDER_OUTER_RADIUS = SHIELD_HOLDER_INNER_RADIUS + SHIELD_HOLDER_OUTER_THICKNESS;
    

    linear_extrude(height = SHIELD_MOUNTING_BAR_HEIGHT, convexity = 10, twist = 0)
    {
        difference()
        {
            union(){
                // bar from bottom left to upper right
                BAR_THICKNESS = SHIELD_MOUNTING_BAR_THICKNESS / 2;
                polygon (points= [
                        [-ROD_OFFSET_X + BAR_THICKNESS, -ROD_OFFSET_Y],
                        [-ROD_OFFSET_X - BAR_THICKNESS, -ROD_OFFSET_Y],
                        [ROD_OFFSET_X - BAR_THICKNESS, ROD_OFFSET_Y],
                        [ROD_OFFSET_X + BAR_THICKNESS, ROD_OFFSET_Y]] );

                polygon (points= [
                        [ROD_OFFSET_X + BAR_THICKNESS, -ROD_OFFSET_Y],
                        [ROD_OFFSET_X - BAR_THICKNESS, -ROD_OFFSET_Y],
                        [-ROD_OFFSET_X - BAR_THICKNESS, ROD_OFFSET_Y],
                        [-ROD_OFFSET_X + BAR_THICKNESS, ROD_OFFSET_Y]] );
    
                Horizontal_Rods_Mountings (ROD_OFFSET_X, ROD_OFFSET_Y);            
              
                // ring to hold shield
                circle(SHIELD_HOLDER_OUTER_RADIUS);

            }

            circle(SHIELD_HOLDER_INNER_RADIUS);
            Horizontal_Rods_Inner_Holes (ROD_OFFSET_X, ROD_OFFSET_Y);
        }
    }
}