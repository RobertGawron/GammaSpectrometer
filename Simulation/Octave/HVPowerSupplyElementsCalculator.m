%% Input parameters


v_in = 5; % input voltage
v_out = 1.1e3; % output voltage
i_out = 10e-5; % output current
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
n_p = 1;
n_s = v_out / v_in;

%% Output voltage seen by the primary side
v_prim = v_out * (n_p / n_s);

%% Duty cycle
d_c = v_prim / (v_prim + v_in);

%% Peak current flowing in primary transformer winding
i_peak_secondary = (2 * i_out) / (1 - d_c);

%% Peak current flowing in primary transformer winding
i_peak_primary = i_peak_secondary * (n_s / n_p);

%% Time when the switching transistor is on
t_on = d_c / f_osc;

%% Inductance of the primary transformer winding
l_primary = v_in * t_on / i_peak_primary;

%% Inductance of the secondary transformer winding
l_secondary= ((n_s)^2) * l_primary;

%% Minimum Gdrain-sourceS voltage of the switching transistor
mosfet_drain_source_min = v_prim + v_in;

%% Minimum turns on primary side to avoid transformer saturation
max_flux_density = 0.15; % value in teslas, constant
cross_section_in_mm2 =  64.9; % Ae from https://www.tdk-electronics.tdk.com/inf/80/db/fer/rm_8.pdf
cross_section_in_m2 = cross_section_in_mm2 * 1e-6;
primary_turns_min = (v_in * t_on) / (cross_section_in_m2 * max_flux_density)

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
printf("primary_turns_min: %.3e\n", primary_turns_min);

printf("-------------------------------------\n\n");

