EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 5 6
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text GLabel 5300 2850 0    50   Input ~ 0
OUT_SIGNAL
Wire Wire Line
	5550 2850 5300 2850
$Comp
L power:GND #PWR?
U 1 1 5FDA3292
P 5450 3100
AR Path="/5EF1F288/5FDA3292" Ref="#PWR?"  Part="1" 
AR Path="/5EDA53F3/5FDA3292" Ref="#PWR?"  Part="1" 
AR Path="/5EFA52FA/5FDA3292" Ref="#PWR?"  Part="1" 
AR Path="/5EDA585D/5FDA3292" Ref="#PWR?"  Part="1" 
AR Path="/5FDA3292" Ref="#PWR?"  Part="1" 
AR Path="/5FAA6EFE/5FDA3292" Ref="#PWR?"  Part="1" 
AR Path="/5FB06C9F/5FDA3292" Ref="#PWR?"  Part="1" 
AR Path="/5FD9E6AA/5FDA3292" Ref="#PWR01"  Part="1" 
F 0 "#PWR01" H 5450 2850 50  0001 C CNN
F 1 "GND" H 5455 2927 50  0000 C CNN
F 2 "" H 5450 3100 50  0001 C CNN
F 3 "" H 5450 3100 50  0001 C CNN
	1    5450 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	5450 3100 5450 2950
$Comp
L Connector:Conn_01x02_Female J3
U 1 1 5FDA3462
P 5750 2850
F 0 "J3" H 5778 2826 50  0000 L CNN
F 1 "Conn_01x02_Female" H 5778 2735 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x02_P2.54mm_Vertical" H 5750 2850 50  0001 C CNN
F 3 "~" H 5750 2850 50  0001 C CNN
	1    5750 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5550 2950 5450 2950
$EndSCHEMATC
