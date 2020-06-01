EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 5
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:D D1
U 1 1 5CE32761
P 1950 1400
F 0 "D1" H 1950 1616 50  0000 C CNN
F 1 "1n148" H 1950 1525 50  0000 C CNN
F 2 "Diode_SMD:D_MiniMELF" H 1950 1400 50  0001 C CNN
F 3 "~" H 1950 1400 50  0001 C CNN
	1    1950 1400
	0    -1   -1   0   
$EndComp
$Comp
L Analog_ADC:MCP3425A0T-ECH U3
U 1 1 5CE375F5
P 9450 3150
F 0 "U3" H 9150 3650 50  0000 C CNN
F 1 "MCP3425A0T-ECH" H 9100 3550 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6_Handsoldering" H 9450 3150 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/22072b.pdf" H 9450 3150 50  0001 C CNN
	1    9450 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C4
U 1 1 5CE37F43
P 9650 2000
F 0 "C4" V 9905 2000 50  0000 C CNN
F 1 "10u" V 9814 2000 50  0000 C CNN
F 2 "Capacitor_Tantalum_SMD:CP_EIA-3528-21_Kemet-B" H 9688 1850 50  0001 C CNN
F 3 "~" H 9650 2000 50  0001 C CNN
	1    9650 2000
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R1
U 1 1 5CE3AD8E
P 3700 2300
F 0 "R1" V 3907 2300 50  0000 C CNN
F 1 "1k" V 3816 2300 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 3630 2300 50  0001 C CNN
F 3 "~" H 3700 2300 50  0001 C CNN
	1    3700 2300
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR07
U 1 1 5CEC5BB5
P 9450 1850
F 0 "#PWR07" H 9450 1700 50  0001 C CNN
F 1 "+5V" H 9392 1887 50  0000 R CNN
F 2 "" H 9450 1850 50  0001 C CNN
F 3 "" H 9450 1850 50  0001 C CNN
	1    9450 1850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR011
U 1 1 5CEC60FD
P 9900 2100
F 0 "#PWR011" H 9900 1850 50  0001 C CNN
F 1 "GND" H 9905 1927 50  0000 C CNN
F 2 "" H 9900 2100 50  0001 C CNN
F 3 "" H 9900 2100 50  0001 C CNN
	1    9900 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	9450 2000 9500 2000
Wire Wire Line
	9800 2000 9900 2000
Wire Wire Line
	9900 2000 9900 2100
Wire Wire Line
	9450 2000 9450 1850
Connection ~ 9450 2000
$Comp
L power:GND #PWR08
U 1 1 5CFAD0BC
P 9450 3600
F 0 "#PWR08" H 9450 3350 50  0001 C CNN
F 1 "GND" V 9455 3472 50  0000 R CNN
F 2 "" H 9450 3600 50  0001 C CNN
F 3 "" H 9450 3600 50  0001 C CNN
	1    9450 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	9450 3600 9450 3550
Text GLabel 800  1850 1    50   Input ~ 0
analog_output
Wire Wire Line
	9950 3050 10100 3050
Wire Wire Line
	9950 3150 10100 3150
Text Label 10100 3050 2    50   ~ 0
SCL
Text Label 10100 3150 2    50   ~ 0
SDA
Text Label 4250 2300 0    50   ~ 0
RST_PEAK
Wire Wire Line
	9900 2450 9900 2500
Wire Wire Line
	9800 2450 9900 2450
Wire Wire Line
	9450 2450 9450 2000
Connection ~ 9450 2450
Wire Wire Line
	9500 2450 9450 2450
Wire Wire Line
	9450 2750 9450 2450
$Comp
L power:GND #PWR012
U 1 1 5CEC6490
P 9900 2500
F 0 "#PWR012" H 9900 2250 50  0001 C CNN
F 1 "GND" H 9905 2327 50  0000 C CNN
F 2 "" H 9900 2500 50  0001 C CNN
F 3 "" H 9900 2500 50  0001 C CNN
	1    9900 2500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C5
U 1 1 5CE37B6C
P 9650 2450
F 0 "C5" V 9398 2450 50  0000 C CNN
F 1 "100n" V 9489 2450 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 9688 2300 50  0001 C CNN
F 3 "~" H 9650 2450 50  0001 C CNN
	1    9650 2450
	0    1    1    0   
$EndComp
$Comp
L Device:D D6
U 1 1 5ED825FA
P 2300 1750
F 0 "D6" H 2300 1966 50  0000 C CNN
F 1 "1n148" H 2300 1875 50  0000 C CNN
F 2 "Diode_SMD:D_MiniMELF" H 2300 1750 50  0001 C CNN
F 3 "~" H 2300 1750 50  0001 C CNN
	1    2300 1750
	-1   0    0    1   
$EndComp
$Comp
L Device:R R3
U 1 1 5ED82C95
P 2300 1400
F 0 "R3" V 2507 1400 50  0000 C CNN
F 1 "10k" V 2416 1400 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 2230 1400 50  0001 C CNN
F 3 "~" H 2300 1400 50  0001 C CNN
	1    2300 1400
	0    -1   -1   0   
$EndComp
$Comp
L Device:C C1
U 1 1 5ED894BD
P 2600 2100
F 0 "C1" H 2485 2054 50  0000 R CNN
F 1 "10n" H 2485 2145 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 2638 1950 50  0001 C CNN
F 3 "~" H 2600 2100 50  0001 C CNN
	1    2600 2100
	-1   0    0    1   
$EndComp
$Comp
L Device:R R6
U 1 1 5ED89932
P 2600 2450
F 0 "R6" H 2670 2496 50  0000 L CNN
F 1 "100R" H 2670 2405 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 2530 2450 50  0001 C CNN
F 3 "~" H 2600 2450 50  0001 C CNN
	1    2600 2450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5EDA1DBA
P 2300 1050
F 0 "R2" V 2507 1050 50  0000 C CNN
F 1 "10k" V 2416 1050 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 2230 1050 50  0001 C CNN
F 3 "~" H 2300 1050 50  0001 C CNN
	1    2300 1050
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1800 1750 1950 1750
Wire Wire Line
	2450 1750 2800 1750
Wire Wire Line
	2600 1950 2600 1850
Wire Wire Line
	2600 1850 2800 1850
Wire Wire Line
	2800 1850 2800 1750
Connection ~ 2800 1850
Connection ~ 2800 1750
Wire Wire Line
	2600 2700 2600 2600
Wire Wire Line
	2600 2300 2600 2250
Wire Wire Line
	3300 2300 3400 2300
Wire Wire Line
	2800 1750 3200 1750
Wire Wire Line
	2800 1850 3000 1850
Wire Wire Line
	3000 2700 3000 2500
Wire Wire Line
	2600 2700 2800 2700
Wire Wire Line
	3000 1850 3000 2100
$Comp
L Transistor_FET:2N7002 Q1
U 1 1 5CF7F1B0
P 3100 2300
F 0 "Q1" H 3100 2550 50  0000 L CNN
F 1 "2N7002" H 2900 2450 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 3300 2225 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N7002.pdf" H 3100 2300 50  0001 L CNN
	1    3100 2300
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2150 1400 2100 1400
Wire Wire Line
	2100 1400 2100 1750
Connection ~ 2100 1750
Wire Wire Line
	2100 1750 2150 1750
Wire Wire Line
	3200 1550 3100 1550
Wire Wire Line
	3100 1550 3100 1400
Wire Wire Line
	3100 1400 3950 1400
Wire Wire Line
	3950 1400 3950 1650
Wire Wire Line
	3950 1650 3800 1650
Wire Wire Line
	3950 1650 4050 1650
Connection ~ 3950 1650
Wire Wire Line
	3850 2300 4250 2300
Wire Wire Line
	2450 1400 3100 1400
Connection ~ 3100 1400
Wire Wire Line
	2450 1050 3100 1050
Wire Wire Line
	3100 1050 3100 1400
Wire Wire Line
	2150 1050 1950 1050
Wire Wire Line
	1100 1050 1100 1650
Wire Wire Line
	1100 1650 1200 1650
Wire Wire Line
	1950 1550 1950 1750
Connection ~ 1950 1750
Wire Wire Line
	1950 1750 2100 1750
Wire Wire Line
	1950 1250 1950 1050
Connection ~ 1950 1050
Wire Wire Line
	1950 1050 1100 1050
Wire Wire Line
	1200 1850 800  1850
$Comp
L power:GND #PWR01
U 1 1 5EECA418
P 2800 2750
F 0 "#PWR01" H 2800 2500 50  0001 C CNN
F 1 "GND" V 2805 2622 50  0000 R CNN
F 2 "" H 2800 2750 50  0001 C CNN
F 3 "" H 2800 2750 50  0001 C CNN
	1    2800 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	2800 2750 2800 2700
Connection ~ 2800 2700
Wire Wire Line
	2800 2700 3000 2700
$Comp
L Device:R R7
U 1 1 5EF0449E
P 3400 2500
F 0 "R7" H 3470 2546 50  0000 L CNN
F 1 "10k" H 3470 2455 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 3330 2500 50  0001 C CNN
F 3 "~" H 3400 2500 50  0001 C CNN
	1    3400 2500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR02
U 1 1 5EF11DEB
P 3400 2750
F 0 "#PWR02" H 3400 2500 50  0001 C CNN
F 1 "GND" V 3405 2622 50  0000 R CNN
F 2 "" H 3400 2750 50  0001 C CNN
F 3 "" H 3400 2750 50  0001 C CNN
	1    3400 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 2750 3400 2650
Wire Wire Line
	3400 2350 3400 2300
Connection ~ 3400 2300
Wire Wire Line
	3400 2300 3550 2300
$Comp
L Device:Q_NPN_BEC Q2
U 1 1 5EF321C7
P 6900 3450
F 0 "Q2" H 7091 3496 50  0000 L CNN
F 1 "Q_NPN_BEC" H 7091 3405 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-323_SC-70" H 7100 3550 50  0001 C CNN
F 3 "~" H 6900 3450 50  0001 C CNN
	1    6900 3450
	1    0    0    -1  
$EndComp
$Comp
L PhotomultiplierRadioactivityDetector:RSM850B-6112-85-1005 Rel1
U 1 1 5ED51FDC
P 7300 2150
F 0 "Rel1" H 7050 1250 50  0000 L CNN
F 1 "RSM850B-6112-85-1005" H 7050 1150 50  0000 L CNN
F 2 "Relay_THT:Relay_DPDT_Omron_G6K-2P-Y" H 7300 2150 50  0001 C CNN
F 3 "" H 7300 2150 50  0001 C CNN
	1    7300 2150
	1    0    0    -1  
$EndComp
$Comp
L Device:D D2
U 1 1 5ED53675
P 6600 2750
F 0 "D2" V 6554 2830 50  0000 L CNN
F 1 "1n148" V 6645 2830 50  0000 L CNN
F 2 "Diode_SMD:D_MiniMELF" H 6600 2750 50  0001 C CNN
F 3 "~" H 6600 2750 50  0001 C CNN
	1    6600 2750
	0    1    1    0   
$EndComp
$Comp
L power:+9V #PWR09
U 1 1 5ED54429
P 7000 2300
F 0 "#PWR09" H 7000 2150 50  0001 C CNN
F 1 "+9V" H 7015 2473 50  0000 C CNN
F 2 "" H 7000 2300 50  0001 C CNN
F 3 "" H 7000 2300 50  0001 C CNN
	1    7000 2300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 5ED54B7C
P 6550 3650
F 0 "R11" H 6620 3696 50  0000 L CNN
F 1 "10k" H 6620 3605 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 6480 3650 50  0001 C CNN
F 3 "~" H 6550 3650 50  0001 C CNN
	1    6550 3650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R10
U 1 1 5ED54FCF
P 5950 3450
F 0 "R10" V 6157 3450 50  0000 C CNN
F 1 "1k" V 6066 3450 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 5880 3450 50  0001 C CNN
F 3 "~" H 5950 3450 50  0001 C CNN
	1    5950 3450
	0    -1   -1   0   
$EndComp
$Comp
L Device:C C2
U 1 1 5ED553E2
P 6200 3650
F 0 "C2" H 6085 3604 50  0000 R CNN
F 1 "10n" H 6085 3695 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 6238 3500 50  0001 C CNN
F 3 "~" H 6200 3650 50  0001 C CNN
	1    6200 3650
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR010
U 1 1 5ED55B22
P 7000 3850
F 0 "#PWR010" H 7000 3600 50  0001 C CNN
F 1 "GND" H 7005 3677 50  0000 C CNN
F 2 "" H 7000 3850 50  0001 C CNN
F 3 "" H 7000 3850 50  0001 C CNN
	1    7000 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 3250 7000 3050
Wire Wire Line
	7000 3050 6600 3050
Wire Wire Line
	6600 3050 6600 2900
Connection ~ 7000 3050
Wire Wire Line
	7000 3050 7000 3000
Wire Wire Line
	7000 2450 7000 2350
Wire Wire Line
	7000 2350 6600 2350
Wire Wire Line
	6600 2350 6600 2600
Connection ~ 7000 2350
Wire Wire Line
	7000 2350 7000 2300
Wire Wire Line
	7000 3850 7000 3650
Wire Wire Line
	6100 3450 6200 3450
Wire Wire Line
	6550 3500 6550 3450
Connection ~ 6550 3450
Wire Wire Line
	6550 3450 6700 3450
Wire Wire Line
	6200 3500 6200 3450
Connection ~ 6200 3450
Wire Wire Line
	6200 3450 6550 3450
$Comp
L power:GND #PWR06
U 1 1 5ED6AA34
P 6550 3850
F 0 "#PWR06" H 6550 3600 50  0001 C CNN
F 1 "GND" H 6555 3677 50  0000 C CNN
F 2 "" H 6550 3850 50  0001 C CNN
F 3 "" H 6550 3850 50  0001 C CNN
	1    6550 3850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR05
U 1 1 5ED6ACA2
P 6200 3850
F 0 "#PWR05" H 6200 3600 50  0001 C CNN
F 1 "GND" H 6205 3677 50  0000 C CNN
F 2 "" H 6200 3850 50  0001 C CNN
F 3 "" H 6200 3850 50  0001 C CNN
	1    6200 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 3850 6200 3800
Wire Wire Line
	6550 3850 6550 3800
$Comp
L Device:R R12
U 1 1 5ED790F7
P 8750 3050
F 0 "R12" V 8543 3050 50  0000 C CNN
F 1 "0R" V 8634 3050 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 8680 3050 50  0001 C CNN
F 3 "~" H 8750 3050 50  0001 C CNN
	1    8750 3050
	0    1    1    0   
$EndComp
$Comp
L Device:R R13
U 1 1 5ED79958
P 8750 3250
F 0 "R13" V 8865 3250 50  0000 C CNN
F 1 "0R" V 8956 3250 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 8680 3250 50  0001 C CNN
F 3 "~" H 8750 3250 50  0001 C CNN
	1    8750 3250
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR013
U 1 1 5ED79DB5
P 8400 3550
F 0 "#PWR013" H 8400 3300 50  0001 C CNN
F 1 "GND" V 8405 3422 50  0000 R CNN
F 2 "" H 8400 3550 50  0001 C CNN
F 3 "" H 8400 3550 50  0001 C CNN
	1    8400 3550
	1    0    0    -1  
$EndComp
Wire Wire Line
	8950 3250 8900 3250
Wire Wire Line
	8600 3250 8400 3250
Wire Wire Line
	8400 3250 8400 3550
Wire Wire Line
	8950 3050 8900 3050
Wire Wire Line
	8600 3050 8400 3050
Wire Wire Line
	8400 3050 8400 2250
Wire Wire Line
	8400 2250 7300 2250
Wire Wire Line
	7300 2250 7300 2450
Wire Wire Line
	7150 2450 7150 1850
Wire Wire Line
	7150 1850 6500 1850
Wire Wire Line
	7450 2450 7450 1700
Wire Wire Line
	7450 1700 6500 1700
Text Label 6500 1700 2    50   ~ 0
PEAK_VOLTAGE
Text Label 6500 1850 2    50   ~ 0
DIRECT_VOLTAGE
$Comp
L Amplifier_Operational:TL074 U4
U 1 1 5ED99C75
P 1500 1750
F 0 "U4" H 1500 1383 50  0000 C CNN
F 1 "TL074" H 1500 1474 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 1450 1850 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/tl071.pdf" H 1550 1950 50  0001 C CNN
	1    1500 1750
	1    0    0    1   
$EndComp
$Comp
L Amplifier_Operational:TL074 U4
U 2 1 5ED9B4E9
P 3500 1650
F 0 "U4" H 3500 1283 50  0000 C CNN
F 1 "TL074" H 3500 1374 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 3450 1750 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/tl071.pdf" H 3550 1850 50  0001 C CNN
	2    3500 1650
	1    0    0    1   
$EndComp
$Comp
L Amplifier_Operational:TL074 U4
U 3 1 5ED9CA9F
P 2400 6250
F 0 "U4" H 2400 5883 50  0000 C CNN
F 1 "TL074" H 2400 5974 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 2350 6350 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/tl071.pdf" H 2450 6450 50  0001 C CNN
	3    2400 6250
	1    0    0    1   
$EndComp
$Comp
L Amplifier_Operational:TL074 U4
U 4 1 5ED9DE90
P 3650 6350
F 0 "U4" H 3650 5983 50  0000 C CNN
F 1 "TL074" H 3650 6074 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 3600 6450 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/tl071.pdf" H 3700 6550 50  0001 C CNN
	4    3650 6350
	1    0    0    1   
$EndComp
$Comp
L Amplifier_Operational:TL074 U4
U 5 1 5ED9F0D1
P 8350 5450
F 0 "U4" H 8308 5496 50  0000 L CNN
F 1 "TL074" H 8308 5405 50  0000 L CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 8300 5550 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/tl071.pdf" H 8400 5650 50  0001 C CNN
	5    8350 5450
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 5EDB6713
P 8050 5500
AR Path="/5EF1F288/5EDB6713" Ref="C?"  Part="1" 
AR Path="/5EDA53F3/5EDB6713" Ref="C3"  Part="1" 
F 0 "C3" H 8165 5454 50  0000 L CNN
F 1 "100n" H 8165 5545 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 8088 5350 50  0001 C CNN
F 3 "~" H 8050 5500 50  0001 C CNN
	1    8050 5500
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EDB6719
P 8250 5900
AR Path="/5EF1F288/5EDB6719" Ref="#PWR?"  Part="1" 
AR Path="/5EDA53F3/5EDB6719" Ref="#PWR015"  Part="1" 
F 0 "#PWR015" H 8250 5650 50  0001 C CNN
F 1 "GND" V 8255 5772 50  0000 R CNN
F 2 "" H 8250 5900 50  0001 C CNN
F 3 "" H 8250 5900 50  0001 C CNN
	1    8250 5900
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 5EDB671F
P 8250 5050
AR Path="/5EF1F288/5EDB671F" Ref="#PWR?"  Part="1" 
AR Path="/5EDA53F3/5EDB671F" Ref="#PWR014"  Part="1" 
F 0 "#PWR014" H 8250 4900 50  0001 C CNN
F 1 "+5V" H 8192 5087 50  0000 R CNN
F 2 "" H 8250 5050 50  0001 C CNN
F 3 "" H 8250 5050 50  0001 C CNN
	1    8250 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	8250 5900 8250 5800
Wire Wire Line
	8250 5800 8050 5800
Wire Wire Line
	8050 5800 8050 5650
Connection ~ 8250 5800
Wire Wire Line
	8250 5800 8250 5750
Wire Wire Line
	8250 5150 8250 5100
Wire Wire Line
	8250 5100 8050 5100
Wire Wire Line
	8050 5100 8050 5350
Connection ~ 8250 5100
Wire Wire Line
	8250 5100 8250 5050
Text Notes 2050 700  0    79   ~ 16
Peak detector
Text Notes 1700 5300 0    79   ~ 16
Dynode signal amilifier and conditionning
$Comp
L Device:R R9
U 1 1 5EDCDFD2
P 2400 5700
F 0 "R9" V 2607 5700 50  0000 C CNN
F 1 "10k" V 2516 5700 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 2330 5700 50  0001 C CNN
F 3 "~" H 2400 5700 50  0001 C CNN
	1    2400 5700
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R8
U 1 1 5EDCE364
P 1750 6150
F 0 "R8" V 1957 6150 50  0000 C CNN
F 1 "10k" V 1866 6150 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 1680 6150 50  0001 C CNN
F 3 "~" H 1750 6150 50  0001 C CNN
	1    1750 6150
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R35
U 1 1 5EDD8B1E
P 3000 6250
F 0 "R35" V 3207 6250 50  0000 C CNN
F 1 "10k" V 3116 6250 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 2930 6250 50  0001 C CNN
F 3 "~" H 3000 6250 50  0001 C CNN
	1    3000 6250
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R36
U 1 1 5EDD8DEE
P 3650 5800
F 0 "R36" V 3857 5800 50  0000 C CNN
F 1 "10k" V 3766 5800 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 3580 5800 50  0001 C CNN
F 3 "~" H 3650 5800 50  0001 C CNN
	1    3650 5800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2100 6150 2000 6150
$Comp
L power:GND #PWR040
U 1 1 5EDDB611
P 1550 7300
F 0 "#PWR040" H 1550 7050 50  0001 C CNN
F 1 "GND" V 1555 7172 50  0000 R CNN
F 2 "" H 1550 7300 50  0001 C CNN
F 3 "" H 1550 7300 50  0001 C CNN
	1    1550 7300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 6250 2800 6250
Wire Wire Line
	2800 6250 2800 5700
Wire Wire Line
	2800 5700 2550 5700
Connection ~ 2800 6250
Wire Wire Line
	2800 6250 2700 6250
Wire Wire Line
	2250 5700 2000 5700
Wire Wire Line
	2000 5700 2000 6150
Connection ~ 2000 6150
Wire Wire Line
	2000 6150 1900 6150
Wire Wire Line
	3150 6250 3250 6250
Wire Wire Line
	3250 6250 3250 5800
Wire Wire Line
	3250 5800 3500 5800
Connection ~ 3250 6250
Wire Wire Line
	3250 6250 3350 6250
Wire Wire Line
	3800 5800 4100 5800
Wire Wire Line
	4100 5800 4100 6350
Wire Wire Line
	4100 6350 3950 6350
Wire Wire Line
	3300 6450 3350 6450
$Comp
L Device:R R4
U 1 1 5EDF323F
P 1550 6650
F 0 "R4" V 1757 6650 50  0000 C CNN
F 1 "10k" V 1666 6650 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 1480 6650 50  0001 C CNN
F 3 "~" H 1550 6650 50  0001 C CNN
	1    1550 6650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 5EDF37F1
P 1550 7050
F 0 "R5" V 1757 7050 50  0000 C CNN
F 1 "10k" V 1666 7050 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 1480 7050 50  0001 C CNN
F 3 "~" H 1550 7050 50  0001 C CNN
	1    1550 7050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1550 6350 1550 6500
Wire Wire Line
	1550 6800 1550 6850
Wire Wire Line
	1550 7300 1550 7200
$Comp
L Device:C C9
U 1 1 5EE089AF
P 1150 7050
F 0 "C9" H 1035 7004 50  0000 R CNN
F 1 "10n" H 1035 7095 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 1188 6900 50  0001 C CNN
F 3 "~" H 1150 7050 50  0001 C CNN
	1    1150 7050
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR04
U 1 1 5EE09080
P 1550 6350
F 0 "#PWR04" H 1550 6200 50  0001 C CNN
F 1 "+5V" H 1492 6387 50  0000 R CNN
F 2 "" H 1550 6350 50  0001 C CNN
F 3 "" H 1550 6350 50  0001 C CNN
	1    1550 6350
	1    0    0    -1  
$EndComp
Wire Wire Line
	1550 6850 1150 6850
Wire Wire Line
	1150 6850 1150 6900
Connection ~ 1550 6850
Wire Wire Line
	1550 6850 1550 6900
$Comp
L power:GND #PWR03
U 1 1 5EE0D6AC
P 1150 7300
F 0 "#PWR03" H 1150 7050 50  0001 C CNN
F 1 "GND" V 1155 7172 50  0000 R CNN
F 2 "" H 1150 7300 50  0001 C CNN
F 3 "" H 1150 7300 50  0001 C CNN
	1    1150 7300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1150 7300 1150 7200
Wire Wire Line
	1550 6850 1900 6850
Wire Wire Line
	1900 6850 1900 6350
Wire Wire Line
	1900 6350 2100 6350
Wire Wire Line
	1900 6850 3300 6850
Wire Wire Line
	3300 6450 3300 6850
Connection ~ 1900 6850
Wire Wire Line
	1600 6150 1250 6150
$Comp
L Amplifier_Operational:TL074 U1
U 1 1 5EE2D91A
P 5750 5200
F 0 "U1" H 5750 5567 50  0000 C CNN
F 1 "TL074" H 5750 5476 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 5700 5300 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/tl071.pdf" H 5800 5400 50  0001 C CNN
	1    5750 5200
	1    0    0    -1  
$EndComp
$Comp
L Amplifier_Operational:TL074 U1
U 2 1 5EE2E7D0
P 5850 5800
F 0 "U1" H 5850 6167 50  0000 C CNN
F 1 "TL074" H 5850 6076 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 5800 5900 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/tl071.pdf" H 5900 6000 50  0001 C CNN
	2    5850 5800
	1    0    0    -1  
$EndComp
$Comp
L Amplifier_Operational:TL074 U1
U 3 1 5EE2FE27
P 5800 6400
F 0 "U1" H 5800 6767 50  0000 C CNN
F 1 "TL074" H 5800 6676 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 5750 6500 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/tl071.pdf" H 5850 6600 50  0001 C CNN
	3    5800 6400
	1    0    0    -1  
$EndComp
$Comp
L Amplifier_Operational:TL074 U1
U 4 1 5EE31836
P 5700 6900
F 0 "U1" H 5700 7267 50  0000 C CNN
F 1 "TL074" H 5700 7176 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 5650 7000 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/tl071.pdf" H 5750 7100 50  0001 C CNN
	4    5700 6900
	1    0    0    -1  
$EndComp
$Comp
L Amplifier_Operational:TL074 U1
U 5 1 5EE32B41
P 6600 6250
F 0 "U1" H 6558 6296 50  0000 L CNN
F 1 "TL074" H 6558 6205 50  0000 L CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 6550 6350 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/tl071.pdf" H 6650 6450 50  0001 C CNN
	5    6600 6250
	1    0    0    -1  
$EndComp
$EndSCHEMATC
