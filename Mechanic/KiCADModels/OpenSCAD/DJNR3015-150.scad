// datasheet: https://www.tme.eu/Document/e39540ac51bab732bf0cd6d66b280881/DJNR3015-series.pdf
CHASSIS_X_LENGTH = (2 * 0.9) + 1.2;
CHASSIS_Y_LENGTH = 3;
CHASSIS_Z_LENGTH = 1.5;

// Increase steps in render to have quality circles
$fs=0.01;


module Transformer() {
    
    linear_extrude(height = CHASSIS_Z_LENGTH, convexity = 10, twist = 0)
translate([-CHASSIS_X_LENGTH/2, -CHASSIS_Y_LENGTH/2,0])
        square([CHASSIS_X_LENGTH,CHASSIS_Y_LENGTH]);
}

Transformer();
