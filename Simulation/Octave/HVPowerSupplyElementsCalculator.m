## User constant parameters
f_osc = 800e3;
v_cathode = 1.2e3;
v_in = 12;
v_out=v_cathode/12;
i_out = 20e-3;
v_divider = 2.5;
r_divider_top = 500e6;

## Chip constant parameters
minimum_off_time = 60e-9;
v_cesat = 300e-3;
v_d = 600e-3;
n = 0.88;
i_min_riple = 98e-3;
i_lim = 2.4;
v_fb = 1.215;

### Calculate r_t
r_t = ((91.9 / (f_osc / 1e6))) * 1e3;

### Calculate r_fb
r_fb = abs(v_out - 1.215) / 83.3e-6;

### Calculate r_divider_bottom
r_divider_bottom = r_divider_top * (1 / ((v_cathode / v_divider) - 1));

### Calculate duty_cycle_max
t_p = 1 / f_osc;
duty_cycle_max = (t_p - minimum_off_time) / t_p;

### Calculate duty_cycle
duty_cycle = (v_out - v_in + v_d) / (v_out + v_d - v_cesat);

### Calculate l_min
l_min = duty_cycle * v_in / (2 * f_osc * (i_lim - (abs(v_out) * i_out)/(v_in * n)));

### Calculate l_min_to_avoid_subharmonic
l_min_to_avoid_subharmonic = v_in * ((2 * duty_cycle) - 1) / ((1 - duty_cycle) * f_osc);

## Calculate l_max
l_max = ((v_in - v_cesat)/(i_min_riple)) * (duty_cycle / f_osc);

### Calculate i_peak
l1=l_min_to_avoid_subharmonic;
i_peak = abs(v_out * i_out) / (v_in * n) + (v_in * duty_cycle)/(2 * l1 * f_osc);


## Show results
printf("-------- %s --------\n", strftime("%Y-%m-%d %H:%M:%S", localtime(time())))

printf("\n-------- User constant parameters:\n");
printf("f_osc: %.3f Hz\n", f_osc);
printf("v_in: %.3f V\n", v_in);

printf("v_cathode: %.3e V\n", v_cathode);
printf("v_cathode: %.3e V\n", i_out);
printf("v_divider: %.3e V\n", v_divider);
printf("r_divider_top: %.3e Ohm\n", r_divider_top);

printf("\n-------- Calculated parameters:\n");
printf("duty_cycle_max: %.3e s\n", duty_cycle_max);
printf("duty_cycle: %.3e s\n", duty_cycle);
printf("r_t: %.3e Ohm\n", r_t);
printf("r_fb: %.3e Ohm\n", r_fb);
printf("v_divider: %.3e V\n", v_divider);
printf("r_divider_bottom: %.3e Ohm\n", r_divider_bottom);
printf("l_min: %.3e H\n", l_min)
printf("l_min_to_avoid_subharmonic: %.3e H\n", l_min_to_avoid_subharmonic)
printf("l_max: %.3e H\n", l_max)
printf("i_peak: %.3e A\n", i_peak)

printf("-------------------------------------\n\n");
