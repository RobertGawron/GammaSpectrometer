PCB_THICKNESS = 1;


PHOTOMULTIPLIER_PCB_MAX_LENGTH = 100;
PHOTOMULTIPLIER_CONNECTOR_RADIUS = 20;
PHOTOMULTIPLIER_LEFT_CONNECTOR_DISTANCE_PCB_CENTER = (PHOTOMULTIPLIER_PCB_MAX_LENGTH / 2) /2;
PHOTOMULTIPLIER_RIGHT_CONNECTOR_DISTANCE_PCB_CENTER = - PHOTOMULTIPLIER_LEFT_CONNECTOR_DISTANCE_PCB_CENTER;


// docs: https://www.tme.eu/pl/details/alu-g0473/obudowy-uniwersalne/gainta/g-0473/
PCB_CHASIS_X_TOTAL   = 119;   // a dimmension 
PCB_CHASIS_Y_TOTAL   = 93;    // b dimmension
PCB_CHASIS_Z_TOTAL   = 34;    // c dimmension
PCB_CHASIS_Z_INSIDE  = 30;    // d dimmension
PCB_CHASIS_LID_HEIGH = 4;     // e dimmension
PCB_CHASIS_X_INSIDE  = 114.2; // f dimmension
PCB_CHASIS_Y_INSIDE  = 88.7;  // g dimmension
//                   = 109.5; // h dimmension
//                   = 84.2;  // i dimmension


// TODO those is totally arbitral values, TBD after buying tube and shield
PHOTOMULTIPLIER_SHIELD_LENGTH = 200;
PHOTOMULTIPLIER_SHIELD_THICKNESS = 4;

PHOTOMULTIPLIER_SHIELD_INNER_RADIUS = 20;
PHOTOMULTIPLIER_SHIELD_OUTER_RADIUS = PHOTOMULTIPLIER_SHIELD_INNER_RADIUS + PHOTOMULTIPLIER_SHIELD_THICKNESS;

DEVICE_FRAME_SPACE_FOR_SCREWS = 10;
DEVICE_FRAME_LENGTH = PCB_CHASIS_X_TOTAL + DEVICE_FRAME_SPACE_FOR_SCREWS;
DEVICE_FRAME_DISTANCE_ROD_TO_CENTER_DISTANCE = 0.9 * (DEVICE_FRAME_LENGTH / 2); // TODO find better name

ROD_RADIUS = 2.5;
ROD_HOLDER_RADIUS = ROD_RADIUS + 5;
ROD_LENGTH = PCB_CHASIS_X_TOTAL + PCB_THICKNESS + PHOTOMULTIPLIER_SHIELD_LENGTH;


// arbitrary values, to be verified later
DISTANCE_BETWEEN_PCB_CHASSIS = 5;

ROD_OFFSET_Y = PCB_CHASIS_Z_TOTAL + DISTANCE_BETWEEN_PCB_CHASSIS + ROD_HOLDER_RADIUS;
ROD_OFFSET_X = PCB_CHASIS_Y_TOTAL/2 + ROD_HOLDER_RADIUS;


// Increase steps in render to have quality circles
$fs=0.01;



// this will done on PCB, so to reduce manufacture cost it must fit to 10cm x 10xm space
module Photomultiplier_Connector () 
{
    // TODO choose thick enough to fit connector into it
    PHOTOMULTIPLIER_CENTER_CONNECTOR_THICKNESS = 30;

    linear_extrude(height = PCB_THICKNESS, convexity = 10, twist = 0)
        union()
        {
            // left connector (photomultiplier), it will exists, but will be cut down
            //translate([PHOTOMULTIPLIER_LEFT_CONNECTOR_DISTANCE_PCB_CENTER, 0, 0])
            //    circle(r=PHOTOMULTIPLIER_CONNECTOR_RADIUS);

            // middle connector (power supply)
            square([PHOTOMULTIPLIER_LEFT_CONNECTOR_DISTANCE_PCB_CENTER, PHOTOMULTIPLIER_CENTER_CONNECTOR_THICKNESS], center = true);

            // right connector (photomultiplier)
            translate([PHOTOMULTIPLIER_RIGHT_CONNECTOR_DISTANCE_PCB_CENTER, 0, 0])
                circle(r=PHOTOMULTIPLIER_CONNECTOR_RADIUS);
        }
}


module Photomultiplier_Shield () 
{
    linear_extrude(height = PHOTOMULTIPLIER_SHIELD_LENGTH, convexity = 10, twist = 0)
    {
        difference()
        {
            circle(PHOTOMULTIPLIER_SHIELD_OUTER_RADIUS);
            circle(PHOTOMULTIPLIER_SHIELD_INNER_RADIUS);
        }
    }
}


module Photomultiplier_Shield_Holder () 
{
    // params for bars bars that connect to rods
    SHIELD_HOLDER_HEIGHT = 8;
    BAR_THICKNESS = 8;

    // params for ring holding shield
    SHIELD_HOLDER_OUTER_THICKNESS = 8;
    SHIELD_HOLDER_INNER_RADIUS = PHOTOMULTIPLIER_SHIELD_OUTER_RADIUS;
    SHIELD_HOLDER_OUTER_RADIUS = SHIELD_HOLDER_INNER_RADIUS + SHIELD_HOLDER_OUTER_THICKNESS;
    

    linear_extrude(height = SHIELD_HOLDER_HEIGHT, convexity = 10, twist = 0)
    {
        difference()
        {
            union(){
                // outer bars
                difference()
                {
                    square([2*ROD_OFFSET_X+BAR_THICKNESS, 2*ROD_OFFSET_Y+BAR_THICKNESS], center = true);     
                    square([2*ROD_OFFSET_X-BAR_THICKNESS, 2*ROD_OFFSET_Y-BAR_THICKNESS], center = true);     
                }
                
                union()
                {
                    // ring to hold shield
                    circle(SHIELD_HOLDER_OUTER_RADIUS);

                    // inner bars
                    square([2*ROD_OFFSET_X, BAR_THICKNESS], center= true);
                    square([BAR_THICKNESS,2*ROD_OFFSET_Y], center= true);
                }
         
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

            
            // rod mounting points
            translate([ROD_OFFSET_X, ROD_OFFSET_Y, 0])
                circle(r = ROD_RADIUS);  

            translate([ROD_OFFSET_X, -ROD_OFFSET_Y, 0])
                circle(r = ROD_RADIUS);  

            translate([-ROD_OFFSET_X, ROD_OFFSET_Y, 0])
                circle(r = ROD_RADIUS);  
                
            translate([-ROD_OFFSET_X, -ROD_OFFSET_Y, 0])
                circle(r = ROD_RADIUS);

            circle(SHIELD_HOLDER_INNER_RADIUS);
        }
    }
}

//Photomultiplier_Shield_Holder();

module PCB_Chassis () 
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
    }
}



module PCB_Chassis_Holder () 
{
    PCB_HOLDER_HEIGHT = 20;
    BAR_THICKNESS=4;

    linear_extrude(height = PCB_HOLDER_HEIGHT, convexity = 10, twist = 0)
    {
        difference()
        {
            union(){
                // outer bars
                translate([ROD_OFFSET_X,0,0])
                    square([BAR_THICKNESS, 2*ROD_OFFSET_Y-BAR_THICKNESS], center= true);     
 
                translate([-ROD_OFFSET_X,0,0])
                    square([BAR_THICKNESS, 2*ROD_OFFSET_Y-BAR_THICKNESS], center= true);
               
        
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

            
            // rod mounting points
            translate([ROD_OFFSET_X, ROD_OFFSET_Y, 0])
                circle(r = ROD_RADIUS);  

            translate([ROD_OFFSET_X, -ROD_OFFSET_Y, 0])
                circle(r = ROD_RADIUS);  

            translate([-ROD_OFFSET_X, ROD_OFFSET_Y, 0])
                circle(r = ROD_RADIUS);  
                
            translate([-ROD_OFFSET_X, -ROD_OFFSET_Y, 0])
                circle(r = ROD_RADIUS);

            circle(SHIELD_HOLDER_INNER_RADIUS);
        }
    }
}

//PCB_Chassis_Holder();

module Rod () 
{
    linear_extrude(height = ROD_LENGTH, convexity = 10, twist = 0)
    circle(r = ROD_RADIUS); 
}

//Rod ();

module Complete_Model() 
{
    // arbitrary values, to be verified later
    DISTANCE_BETWEEN_PCB_CHASSIS = 5;
    DISTANSE_TO_FIRST_SHIELD_HOLDER = PHOTOMULTIPLIER_SHIELD_LENGTH *0.1;
    DISTANSE_TO_SECOOND_SHIELD_HOLDER = PHOTOMULTIPLIER_SHIELD_LENGTH *0.95;

    DISTANSE_TO_FIRST_PCB_HOLDER = -PCB_CHASIS_X_TOTAL *0.2;
    DISTANSE_TO_SECOOND_PCB_HOLDER = -PCB_CHASIS_X_TOTAL *0.95;

    rotate([90,0,0])
        translate([0, 0, PCB_THICKNESS])
            Photomultiplier_Shield();

    // first ph holder
    translate([0, -DISTANSE_TO_FIRST_SHIELD_HOLDER, 0])
        rotate([90,0,0])
            Photomultiplier_Shield_Holder();

    // second ph holder
    translate([0, -DISTANSE_TO_SECOOND_SHIELD_HOLDER, 0])
        rotate([90,0,0])
            Photomultiplier_Shield_Holder();

    // first pcb holder
    translate([0, -DISTANSE_TO_FIRST_PCB_HOLDER, 0])
        rotate([90,0,0])
            PCB_Chassis_Holder();

    // second pcb holder
    translate([0, -DISTANSE_TO_SECOOND_PCB_HOLDER, 0])
        rotate([90,0,0])
            PCB_Chassis_Holder();


    // rods
    rotate([90,0,0])
        translate([ROD_OFFSET_X, ROD_OFFSET_Y, -PCB_CHASIS_X_TOTAL])
            Rod ();
    
    rotate([90,0,0])
        translate([-ROD_OFFSET_X, ROD_OFFSET_Y, -PCB_CHASIS_X_TOTAL])
            Rod ();

    rotate([90,0,0])
        translate([ROD_OFFSET_X, -ROD_OFFSET_Y, -PCB_CHASIS_X_TOTAL])
            Rod ();

    rotate([90,0,0])
        translate([-ROD_OFFSET_X, -ROD_OFFSET_Y, -PCB_CHASIS_X_TOTAL])
            Rod ();



    rotate([90,90,0])
        translate([PHOTOMULTIPLIER_LEFT_CONNECTOR_DISTANCE_PCB_CENTER, 0, 0])
            Photomultiplier_Connector();


    // HV power supply
    rotate([0,0,90])
        translate([PCB_CHASIS_X_TOTAL/2,0,0]) // TODO
            PCB_Chassis();

    // data acquissition
    rotate([0,0,90])
        translate([PCB_CHASIS_X_TOTAL/2,0, -(PCB_CHASIS_Z_TOTAL+DISTANCE_BETWEEN_PCB_CHASSIS)])
            PCB_Chassis();
}

Complete_Model();
