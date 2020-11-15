%% Input parameters


v_in = 5; % input voltage
v_out = 1.1e3; % PMT cathode voltage
i_out = 10e-5; % PMT current
v_divider = 2.5; % output voltage of the fedback voltage divider
r_divider_top = 50e6; % upper resistor value in the fedback voltage divider
f_osc = 1e4; % frequency of oscilator


%% Bottom resistor value of the fedback voltage divider
r_divider_bottom = r_divider_top * (1 / ((v_out / v_divider) - 1));

%% Total power consumption
pmt_power = i_out * v_out;
efficiency = 0.7; %% assumed value for flyback topology 
total_power_consumption = pmt_power / efficiency;

%% np/ns is transformer turn ratio
n_p = v_in;
n_s = v_out;

%% Output voltage seen by the primary side
v_prim = v_out * (n_p / n_s);

%% Duty cycle
d_c = v_prim / (v_prim + v_in);

%% Peak current flowing in primary transformer winding
i_peak_secondary = (2 * i_out) / (1 - d_c);

%% Peak current flowing in primary transformer winding
i_peak_primary = i_peak_secondary * (n_s / n_p);

%% Time when the switching transistor is on
t_on = (1 / f_osc) * d_c;

%% Inductance of the primary transformer winding
l_primary = v_in * t_on / i_peak_primary;

%% Inductance of the secondary transformer winding
l_secondary= ((n_s/n_p)^2) * l_primary;

%% Minimum GS voltage of the switching transistor
mosfet_drain_source_min = v_prim + v_in;


%% Show results
printf("-------- %s --------\n", strftime("%Y-%m-%d %H:%M:%S", localtime(time())))

printf("\n-------- User constant parameters:\n");
printf("v_in: %.3f V\n", v_in);
printf("v_out: %.3e V\n", v_out);
printf("i_out: %.3e A\n", i_out);
printf("efficiency: %.3e\n", efficiency);
printf("v_divider: %.3e V\n", v_divider);
printf("r_divider_top: %.3e Ohm\n", r_divider_top);

printf("\n-------- Calculated parameters:\n");
printf("total_power_consumption: %.3e W\n", total_power_consumption);
printf("r_divider_bottom: %.3e Ohm\n", r_divider_bottom);
printf("n_p / n_s = %.3e / %.3e\n", n_p, n_s);
printf("d_c: %.3e\n", d_c);
printf("i_peak_secondary: %.3e A\n", i_peak_secondary);
printf("i_peak_primary: %.3e A\n", i_peak_primary);
printf("t_on: %.3e s\n", t_on);
printf("l_primary: %.3e H\n", l_primary);
printf("l_secondary: %.3e H\n", l_secondary);
printf("mosfet_drain_source_min: %.3e V\n", mosfet_drain_source_min);

printf("-------------------------------------\n\n");
