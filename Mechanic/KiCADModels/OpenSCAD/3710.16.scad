// datasheet: https://www.tme.eu/Document/8721c1e12f28e68114c83752997c605d/3710.pdf
CHASSIS_X_LENGTH = 50;
CHASSIS_Y_LENGTH = 54;
CHASSIS_Z_LENGTH = 19;
CHASSIS_THICKNESS = 0.5;

// Increase steps in render to have quality circles
$fs=0.01;


module RFShieold() {
  
    linear_extrude(height = CHASSIS_Z_LENGTH, convexity = 10, twist = 0)
        translate([-CHASSIS_X_LENGTH/2, -CHASSIS_Y_LENGTH/2,0])
            difference()
            {
                square([CHASSIS_X_LENGTH, CHASSIS_Y_LENGTH]);
                translate([CHASSIS_THICKNESS, CHASSIS_THICKNESS, 0])
                square([CHASSIS_X_LENGTH-2*CHASSIS_THICKNESS, CHASSIS_Y_LENGTH-2*CHASSIS_THICKNESS]);
            }
}

RFShieold();
