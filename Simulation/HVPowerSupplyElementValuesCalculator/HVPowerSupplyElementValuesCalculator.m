############### Assumend constants ###############

# Input power supply
Vin = 12;

# Transformer ratio primary to secondary
#Tratio = 6;

# Transformer looses (I don't know how to calculate it)
#Tlooses  = 0.1;

############### Calculate minimum coil inductance ###############

# Duty cycle of the switch
D = 0.5;

# Output current
Iout = 20e-3;

# Switching frequency
Fs = 100e3;

function Lmin = calculate_Lmin(Vin, Iout, D, Fs)
    Lmin = D.*(1-D).*Vin ./ (2.*Iout .*Fs);
end


printf ("Lmin = %d\n", calculate_Lmin(Vin, Iout, D, Fs));

# TODO this a try do a 2D graph in Octave
frequency = (1e4: 1e4 : 1e6);

response = arrayfun(@(f) calculate_Lmin(Vin, Iout, D, f), frequency);

plot(frequency, response);


# TODO this a try to create a 3d graph in Octave
[X,Y] = meshgrid(frequency,  0.1 : 0.05 : 0.9);
Z = calculate_Lmin(Vin, Iout, Y, X)
surf(X,Y,Z)

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