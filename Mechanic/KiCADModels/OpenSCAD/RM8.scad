// datasheet: https://www.tdk-electronics.tdk.com/inf/80/db/fer/rm_8.pdf
// This is very primitive model, but it will do the job

CHASSIS_Z_LENGTH = 14.3;

// Increase steps in render to have quality circles
$fs=0.01;


module Transformer() {
    rotate([0,0,90])
    linear_extrude(height = CHASSIS_Z_LENGTH, convexity = 10, twist = 0)
        polygon(points = [
            [-11.43, -11.43],
            [-1.27,  -11.43],
            [-1.27, -10.16],
            [10.16, -10.16],
            [10.16,   1.27],
            [11.43,   1.27],
            [11.43,  11.43],
            [1.27,   11.43],
            [1.27,   10.16],
            [-10.16, 10.16],
            [-10.16, -1.27],
            [-11.43, -1.27],
            [-11.43, -11.43]] // return back to the first point
        );
}

Transformer();
