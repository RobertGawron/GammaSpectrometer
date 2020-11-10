// datasheet: https://www.tme.eu/Document/adcdc895102d44b158b752608cb08ff1/DG300-5.0.pdf
CHASSIS_X_LENGTH = 10;
CHASSIS_Y_LENGTH = 9;
CHASSIS_Z_LENGTH = 12.6;

// Increase steps in render to have quality circles
$fs=0.01;


module Transformer() {
    
    linear_extrude(height = CHASSIS_Z_LENGTH, convexity = 10, twist = 0)
translate([-CHASSIS_X_LENGTH/2, -CHASSIS_Y_LENGTH/2,0])
        square([CHASSIS_X_LENGTH,CHASSIS_Y_LENGTH]);
}

Transformer();
