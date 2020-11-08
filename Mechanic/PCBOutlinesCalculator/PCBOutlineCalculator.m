# from datasheet: https://www.tme.eu/Document/b8d1c5b7150d723059cd3387bfd1b257/G0123.pdf
# trimmed and rotated version: ../../Documentation/Pictures/chassis.png
A = 119.0;
B =  93.5;
C =  34.5;
D =  30.0;
E =   4.0;
F = 114.2;
G =  88.7;
H = 109.5;
I =  84.2;

# PCB will be done in Chineese factory, those are maximal but still cheapest PCB dimmension
max_width = 100;
max_height = 100;

screw_width = 6.0;
screw_height = 5.0;

# There must be a bit of spacing between PCB and chassis
margin = 1;

r1 = ceil((F - H) / 2) + margin;
r2 = margin;

if F > max_width
    F = max_width;
end

if G > max_height 
    G = max_height;
end

l_total = floor(F);
h_total = floor(G);

l = l_total - (4 * r1) - (2 * r2) - (2 * margin);
h = h_total - (4 * r1) - (2 * r2) - (2 * margin);

# from ../MechanicOverview/MechanicOverview.scad, constants: SCREW_HOLE_1_X_OFFSET, SCREW_HOLE_2_X_OFFSET
screw_hole_offset = round(A * 0.20) - round(screw_width/2) - (2 * r1) - (2 * r2);

printf("r1: %d\n", r1);
printf("r2: %d\n", r2);
printf("l: %d\n", l);
printf("h: %d\n", h);
printf("screw_hole_offset: %d\n", screw_hole_offset);
printf("screw_width: %d\n", screw_width);
printf("screw_height: %d\n", screw_height);
