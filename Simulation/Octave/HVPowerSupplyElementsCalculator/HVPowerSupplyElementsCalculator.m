############### Calculate minimum coil inductance ###############

# Input power supply
Vin = 12;

# Duty cycle of the switch
D = 0.5;

# Output current
Iout = 20e-3;

# Switching frequency
#Fs = 100e3;

function Lmin = calculate_Lmin(Vin, Iout, D, Fs)
    Lmin = (D .* (1-D) .* Vin) ./ (2 .* Iout .* Fs);
end


frequency = (1e5: 1e4 : 1e6);
Iout = (10e-3 : 5e-3 : 50e-3);


[X,Y] = meshgrid(Iout, frequency);
Z = calculate_Lmin(Vin, X, D, Y)
surf(X,Y,Z)

#printf ("Lmin = %d\n", calculate_Lmin(Vin, Iout, D, Fs));


############### Calculate feedback resistors ###################

# Relation between RF1, RF2 and Vout taken from datasheet
# Vout = 1.26(1+ Rf1/Rf2)
# Solving for Rf2 gives:
# Rf2 = Rf1/ ( (Vout/1.26) - 1 )

function Rf2 = calculate_Rf2(Vout, Rf1)
    Rf2 = Rf1/ ( (Vout/1.26) - 1 );
end

Vout = 1500/6;
Rf1 = 100e3;

printf ("Rf2 = %d\n", calculate_Rf2(Vout, Rf1));