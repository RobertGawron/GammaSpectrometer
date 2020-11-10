// datasheet: http://www.farnell.com/datasheets/1870439.pdf
CHASSIS_X_LENGTH = 26;
CHASSIS_Y_LENGTH = 26.75;
CHASSIS_Z_LENGTH = 14;

// Increase steps in render to have quality circles
$fs=0.01;


module Transformer() {
    
    linear_extrude(height = CHASSIS_Z_LENGTH, convexity = 10, twist = 0)
translate([-CHASSIS_X_LENGTH/2, -CHASSIS_Y_LENGTH/2,0])
        square([CHASSIS_X_LENGTH,CHASSIS_Y_LENGTH]);
}

Transformer();
