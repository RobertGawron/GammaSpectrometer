// Values taken from datasheet
// http://www.farnell.com/datasheets/1337718.pdf?_ga=2.65563566.1225228608.1593261089-1855792729.1592068583

TRANSFORMER_LENGTH = 32.31;
TRANSFORMER_WIDTH = 27.03;
TRANSFORMER_HEIGHT = 13.69;


// Increase steps in render to have quality circles
$fs=0.01;

module BasicShape() {
    linear_extrude(height = TRANSFORMER_HEIGHT, convexity = 10, twist = 0)
        square([TRANSFORMER_WIDTH, TRANSFORMER_LENGTH], center= true);
}

module CompleteModel() {
    BasicShape();
}

CompleteModel();
