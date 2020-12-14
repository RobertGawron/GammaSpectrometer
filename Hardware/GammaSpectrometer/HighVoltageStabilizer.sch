EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 4
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	2450 2700 2200 2700
Wire Wire Line
	2350 2900 2200 2900
$Comp
L Device:R R?
U 1 1 5FDE17D5
P 2600 2700
F 0 "R?" V 2715 2700 50  0000 C CNN
F 1 "R" V 2806 2700 50  0000 C CNN
F 2 "" V 2530 2700 50  0001 C CNN
F 3 "~" H 2600 2700 50  0001 C CNN
	1    2600 2700
	0    1    1    0   
$EndComp
$Comp
L Transistor_BJT:BC550 Q?
U 1 1 5FDE1DF6
P 3100 3100
F 0 "Q?" H 3291 3146 50  0000 L CNN
F 1 "BC550" H 3291 3055 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 3300 3025 50  0001 L CIN
F 3 "http://www.fairchildsemi.com/ds/BC/BC547.pdf" H 3100 3100 50  0001 L CNN
	1    3100 3100
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FDE5047
P 3600 3100
F 0 "R?" V 3393 3100 50  0000 C CNN
F 1 "R" V 3484 3100 50  0000 C CNN
F 2 "" V 3530 3100 50  0001 C CNN
F 3 "~" H 3600 3100 50  0001 C CNN
	1    3600 3100
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5FDE52F8
P 3400 3400
F 0 "R?" H 3330 3354 50  0000 R CNN
F 1 "R" H 3330 3445 50  0000 R CNN
F 2 "" V 3330 3400 50  0001 C CNN
F 3 "~" H 3400 3400 50  0001 C CNN
	1    3400 3400
	-1   0    0    1   
$EndComp
$Comp
L Device:R R?
U 1 1 5FDE6533
P 5550 3150
F 0 "R?" H 5480 3104 50  0000 R CNN
F 1 "R" H 5480 3195 50  0000 R CNN
F 2 "" V 5480 3150 50  0001 C CNN
F 3 "~" H 5550 3150 50  0001 C CNN
	1    5550 3150
	-1   0    0    1   
$EndComp
$Comp
L Device:R R?
U 1 1 5FDE6724
P 5550 2550
F 0 "R?" H 5480 2504 50  0000 R CNN
F 1 "R" H 5480 2595 50  0000 R CNN
F 2 "" V 5480 2550 50  0001 C CNN
F 3 "~" H 5550 2550 50  0001 C CNN
	1    5550 2550
	-1   0    0    1   
$EndComp
Wire Wire Line
	2350 2900 2350 3750
Wire Wire Line
	2350 3750 3000 3750
Wire Wire Line
	5550 3750 5550 3300
Wire Wire Line
	3000 3300 3000 3750
Connection ~ 3000 3750
Wire Wire Line
	3000 3750 3400 3750
Wire Wire Line
	2750 2700 3000 2700
Wire Wire Line
	3000 2700 3000 2900
Wire Wire Line
	2350 1700 5550 1700
Wire Wire Line
	5550 1700 5550 2400
Wire Wire Line
	5550 2700 5550 3000
Text GLabel 2200 2300 0    50   Input ~ 0
HV+
Text GLabel 2200 2900 0    50   Input ~ 0
HV_REG-
Text GLabel 2200 2700 0    50   Input ~ 0
HV_REG+
Text GLabel 2200 2500 0    50   Input ~ 0
HV-
Wire Wire Line
	2200 2300 2350 2300
Wire Wire Line
	2350 2300 2350 1700
Wire Wire Line
	3000 2500 3000 2700
Connection ~ 3000 2700
Wire Wire Line
	2200 2500 3000 2500
Wire Wire Line
	3300 3100 3400 3100
Wire Wire Line
	3400 3250 3400 3100
Connection ~ 3400 3100
Wire Wire Line
	3400 3100 3450 3100
Wire Wire Line
	3400 3550 3400 3750
Connection ~ 3400 3750
Wire Wire Line
	3400 3750 5550 3750
$EndSCHEMATC
