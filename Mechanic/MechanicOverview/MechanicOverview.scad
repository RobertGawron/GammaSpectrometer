include <PhotomultiplierShield.scad>
include <PhotomultiplierPCBConnector.scad>
include <PCBChassisHolder.scad>
include <HorizontalRods.scad>
include <PCBChassis.scad>
include <PhotomultiplierShieldHolder.scad>

PCB_THICKNESS = 1;


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

ASSEMBLED_PHOTOMULTIPLIER_CONNECTOR_HEIGH = 20;

// TODO those is totally arbitral values, TBD after buying tube and shield
PHOTOMULTIPLIER_SHIELD_LENGTH = 250;
PHOTOMULTIPLIER_SHIELD_THICKNESS = 4;

PHOTOMULTIPLIER_SHIELD_INNER_RADIUS = 20;
PHOTOMULTIPLIER_SHIELD_OUTER_RADIUS = PHOTOMULTIPLIER_SHIELD_INNER_RADIUS 
                                       + PHOTOMULTIPLIER_SHIELD_THICKNESS;


DISTANCE_BETWEEN_PCB_CHASSIS = 5;


// place of metal roods
ROD_OFFSET_X = PCB_CHASIS_Y_TOTAL/2 + ROD_HOLDER_RADIUS +5;
ROD_OFFSET_Y = PCB_CHASIS_Z_TOTAL + DISTANCE_BETWEEN_PCB_CHASSIS;
ROD_LENGTH = PCB_CHASIS_X_TOTAL 
            + PCB_THICKNESS
            + ASSEMBLED_PHOTOMULTIPLIER_CONNECTOR_HEIGH
            + PHOTOMULTIPLIER_SHIELD_LENGTH;


// bars to mount pcb chassis and tube chassis into metal rods
SHIELD_MOUNTING_BAR_THICKNESS = 5;
SHIELD_MOUNTING_BAR_HEIGHT = 20;


// screws on pcb chasssis holder
SCREW_HOLE_1_X_OFFSET = PCB_CHASIS_X_TOTAL * 0.20;
SCREW_HOLE_2_X_OFFSET = PCB_CHASIS_X_TOTAL * 0.80;

SCREW_HOLE_1_Y_OFFSET = PCB_CHASIS_Z_TOTAL/2;
SCREW_HOLE_2_Y_OFFSET = -PCB_CHASIS_Z_TOTAL/2 - DISTANCE_BETWEEN_PCB_CHASSIS;

SCREW_RADIUS = 2;


// Increase steps in render to have quality circles
$fs=0.01;
$fn=100;



// arbitrary values, to be verified later
DISTANSE_TO_FIRST_SHIELD_HOLDER = PHOTOMULTIPLIER_SHIELD_LENGTH *0.1;
DISTANSE_TO_SECOOND_SHIELD_HOLDER = PHOTOMULTIPLIER_SHIELD_LENGTH *0.9;

module Render_Photomultiplier_Shield()
{
    rotate([90,0,0])
        translate([0, 0, PCB_THICKNESS])
            Photomultiplier_Shield(PHOTOMULTIPLIER_SHIELD_INNER_RADIUS, 
                                PHOTOMULTIPLIER_SHIELD_OUTER_RADIUS, 
                                PHOTOMULTIPLIER_SHIELD_LENGTH);
}

module Render_Photomultiplier_First_Shield()
{
    // first ph holder
    translate([0, -DISTANSE_TO_FIRST_SHIELD_HOLDER, 0])
        rotate([90,0,0])
            Photomultiplier_Shield_Holder(ROD_OFFSET_X, 
                                        ROD_OFFSET_Y, 
                                        PHOTOMULTIPLIER_SHIELD_OUTER_RADIUS, 
                                        SHIELD_MOUNTING_BAR_THICKNESS) ;
}

module Render_Photomultiplier_Second_Shield()
{
    // second ph holder
    translate([0, -DISTANSE_TO_SECOOND_SHIELD_HOLDER, 0])
        rotate([90,0,0])
            Photomultiplier_Shield_Holder(ROD_OFFSET_X, 
                                        ROD_OFFSET_Y, 
                                        PHOTOMULTIPLIER_SHIELD_OUTER_RADIUS, 
                                        SHIELD_MOUNTING_BAR_THICKNESS) ;
}

module Render_Horizontal_Rods_Rods()
{
    // Rods
    rotate([90,0,0])
        translate([0, 0, -PCB_CHASIS_X_TOTAL - ASSEMBLED_PHOTOMULTIPLIER_CONNECTOR_HEIGH])
            Horizontal_Rods_Rods(ROD_LENGTH);
}

module Render_Photomultiplier_PCB_Connector()
{
    rotate([90,90,0])
    translate([PHOTOMULTIPLIER_LEFT_CONNECTOR_DISTANCE_PCB_CENTER, 0, 0])
        Photomultiplier_PCB_Connector(PCB_THICKNESS);
}

module Render_HV_Power_Supply()
{
    // HV power supply
    rotate([0,0,90])
        translate([PCB_CHASIS_X_TOTAL/2.0 + ASSEMBLED_PHOTOMULTIPLIER_CONNECTOR_HEIGH, 0, 0]) // TODO
            PCB_Chassis (PCB_CHASIS_X_TOTAL, 
                        PCB_CHASIS_Y_TOTAL, 
                        PCB_CHASIS_Z_TOTAL, 
                        PCB_CHASIS_X_INSIDE, 
                        PCB_CHASIS_Y_INSIDE,
                        PCB_CHASIS_Z_INSIDE,
                        PCB_CHASIS_LID_HEIGH,
                        SCREW_HOLE_1_X_OFFSET,
                        SCREW_HOLE_2_X_OFFSET,
                        SCREW_RADIUS ); 
}

module Render_Data_Acquissition()
{
    // data acquissition
    rotate([0,0,90])
        translate([PCB_CHASIS_X_TOTAL/2 + ASSEMBLED_PHOTOMULTIPLIER_CONNECTOR_HEIGH,0, -(PCB_CHASIS_Z_TOTAL+DISTANCE_BETWEEN_PCB_CHASSIS)])
            PCB_Chassis (PCB_CHASIS_X_TOTAL, 
                        PCB_CHASIS_Y_TOTAL, 
                        PCB_CHASIS_Z_TOTAL, 
                        PCB_CHASIS_X_INSIDE, 
                        PCB_CHASIS_Y_INSIDE,
                        PCB_CHASIS_Z_INSIDE,
                        PCB_CHASIS_LID_HEIGH,
                        SCREW_HOLE_1_X_OFFSET,
                        SCREW_HOLE_2_X_OFFSET,
                        SCREW_RADIUS ); 
}

module Render_PCB_First_Chassis_Holder()
{
    // first pcb chassis holder
    translate([0, ASSEMBLED_PHOTOMULTIPLIER_CONNECTOR_HEIGH + SHIELD_MOUNTING_BAR_HEIGHT/2 + SCREW_HOLE_1_X_OFFSET, 0])
        rotate([90,0,0])
            PCB_Chassis_Holder(ROD_OFFSET_X,ROD_OFFSET_Y, 
                        PCB_CHASIS_X_TOTAL, 
                        PCB_CHASIS_Y_TOTAL,
                        SHIELD_MOUNTING_BAR_HEIGHT, 
                        SHIELD_MOUNTING_BAR_THICKNESS,
                        SCREW_HOLE_1_Y_OFFSET,
                        SCREW_HOLE_2_Y_OFFSET,
                        SCREW_RADIUS);
}

module Render_PCB_Second_Chassis_Holder()
{
    // second pcb chassis holder
    translate([0, ASSEMBLED_PHOTOMULTIPLIER_CONNECTOR_HEIGH + SHIELD_MOUNTING_BAR_HEIGHT/2 + SCREW_HOLE_2_X_OFFSET, 0])
        rotate([90,0,0])
            PCB_Chassis_Holder(ROD_OFFSET_X,ROD_OFFSET_Y, 
                        PCB_CHASIS_X_TOTAL, 
                        PCB_CHASIS_Y_TOTAL,
                        SHIELD_MOUNTING_BAR_HEIGHT, 
                        SHIELD_MOUNTING_BAR_THICKNESS,
                        SCREW_HOLE_1_Y_OFFSET,
                        SCREW_HOLE_2_Y_OFFSET,
                        SCREW_RADIUS);
}

/*
Render_Photomultiplier_Shield();
Render_Photomultiplier_First_Shield();
Render_Photomultiplier_Second_Shield();
Render_Horizontal_Rods_Rods();
Render_Photomultiplier_PCB_Connector();
Render_HV_Power_Supply();
Render_Data_Acquissition();
Render_PCB_First_Chassis_Holder();
Render_PCB_Second_Chassis_Holder();
*/