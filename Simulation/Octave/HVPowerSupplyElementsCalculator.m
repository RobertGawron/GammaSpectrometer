## Constants
f_osc = 0.85;
v_cathode = 1.2e6
power_supply_voltage = 12;
r_divider_top = 500e6

### Calculate r_t
r_t = (91.9 / f_osc) - 1;


### Calculate r_fb
v_out = 3;
r_fb = abs(v_out - 1.215) / 83.3e-6;

### Calculate v_divider
v_divider = power_supply_voltage / 2;

### Calculate r_divider_bottom
r_divider_bottom = r_divider_top * (1 / ((v_cathode / v_divider) - 1))

## Show results
printf("f_osc: %.3f Mhz\n", f_osc);
printf("r_t: %.3f kOhm\n", r_t);
printf("r_fb: %.3f Ohm\n", r_fb);
printf("v_divider: %.3f V\n", v_divider);
printf("r_divider_bottom: %.3f Ohm\n", r_divider_bottom);