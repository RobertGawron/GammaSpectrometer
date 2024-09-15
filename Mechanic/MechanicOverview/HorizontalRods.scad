ROD_RADIUS = 2.5;
ROD_HOLDER_RADIUS = ROD_RADIUS + 5;


module Horizontal_Rods_Rods(length)
{
    linear_extrude(height = length, convexity = 10, twist = 0)
    {
        translate([ROD_OFFSET_X, ROD_OFFSET_Y, 0])
            circle(r = ROD_RADIUS);  

        translate([ROD_OFFSET_X, -ROD_OFFSET_Y, 0])
            circle(r = ROD_RADIUS);  

        translate([-ROD_OFFSET_X, ROD_OFFSET_Y, 0])
            circle(r = ROD_RADIUS);  
            
        translate([-ROD_OFFSET_X, -ROD_OFFSET_Y, 0])
            circle(r = ROD_RADIUS); 
    }
 
}

module Horizontal_Rods_Mountings (ROD_OFFSET_X, ROD_OFFSET_Y)
{
    // spheres around rod mounting points
    translate([ROD_OFFSET_X, ROD_OFFSET_Y, 0])
        circle(r = ROD_HOLDER_RADIUS);  

    translate([ROD_OFFSET_X, -ROD_OFFSET_Y, 0])
        circle(r = ROD_HOLDER_RADIUS);  

    translate([-ROD_OFFSET_X, ROD_OFFSET_Y, 0])
        circle(r = ROD_HOLDER_RADIUS);  
        
    translate([-ROD_OFFSET_X, -ROD_OFFSET_Y, 0])
        circle(r = ROD_HOLDER_RADIUS);   
}

module Horizontal_Rods_Inner_Holes (ROD_OFFSET_X, ROD_OFFSET_Y)
{
    // rod mounting points
    translate([ROD_OFFSET_X, ROD_OFFSET_Y, 0])
        circle(r = ROD_RADIUS);  

    translate([ROD_OFFSET_X, -ROD_OFFSET_Y, 0])
        circle(r = ROD_RADIUS);  

    translate([-ROD_OFFSET_X, ROD_OFFSET_Y, 0])
        circle(r = ROD_RADIUS);  
        
    translate([-ROD_OFFSET_X, -ROD_OFFSET_Y, 0])
        circle(r = ROD_RADIUS);  
}
