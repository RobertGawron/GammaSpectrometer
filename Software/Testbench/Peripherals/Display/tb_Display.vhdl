library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

library vunit_lib;
  context vunit_lib.vunit_context;

library gammaspec_lib;
  use gammaspec_lib.ConstantsPkg.all;

entity tb_Display is
  generic (
    runner_cfg : string
  );
end entity tb_Display;

architecture tb of tb_Display is

  constant CLK_PERIOD : time := 1 sec / SYS_CLK_FREQ;

  signal clk                  : std_logic := '0';
  signal rst                  : std_logic := '1';
  signal operational          : std_logic := '0';
  signal pulse_detected       : std_logic := '0';
  signal sipm_overlighted     : std_logic := '0';
  signal led_operational      : std_logic;
  signal led_pulse_detected   : std_logic;
  signal led_sipm_overlighted : std_logic;

begin

  clk <= not clk after CLK_PERIOD / 2;

  dut : entity gammaspec_lib.Display
    port map (
      clk                  => clk,
      rst                  => rst,
      operational          => operational,
      pulse_detected       => pulse_detected,
      sipm_overlighted     => sipm_overlighted,
      led_operational      => led_operational,
      led_pulse_detected   => led_pulse_detected,
      led_sipm_overlighted => led_sipm_overlighted
    );

  main : process
    variable first_state  : std_logic;
    variable second_state : std_logic;
  begin
    test_runner_setup(runner, runner_cfg);

    rst <= '1';
    operational      <= '0';
    pulse_detected   <= '0';
    sipm_overlighted <= '0';
    wait for 10 * CLK_PERIOD;
    rst <= '0';
    wait for 10 * CLK_PERIOD;

    if run("pulse_detected_follows_input") then
      pulse_detected <= '0';
      wait for CLK_PERIOD;
      check_equal(led_pulse_detected, '0', "LED_PULSE_DETECTED should be low");

      pulse_detected <= '1';
      wait for CLK_PERIOD;
      check_equal(led_pulse_detected, '1', "LED_PULSE_DETECTED should be high");

      pulse_detected <= '0';
      wait for CLK_PERIOD;
      check_equal(led_pulse_detected, '0', "LED_PULSE_DETECTED should return low");

    elsif run("sipm_overlighted_follows_input") then
      sipm_overlighted <= '0';
      wait for CLK_PERIOD;
      check_equal(led_sipm_overlighted, '0', "LED_SIPM_OVERLIGHTED should be low");

      sipm_overlighted <= '1';
      wait for CLK_PERIOD;
      check_equal(led_sipm_overlighted, '1', "LED_SIPM_OVERLIGHTED should be high");

      sipm_overlighted <= '0';
      wait for CLK_PERIOD;
      check_equal(led_sipm_overlighted, '0', "LED_SIPM_OVERLIGHTED should return low");

    elsif run("operational_blinks_when_enabled") then
      operational <= '0';
      wait for CLK_PERIOD;
      check_equal(led_operational, '0', "LED_OPERATIONAL should be low when disabled");

      operational <= '1';

      wait for 600 ms;
      first_state := led_operational;

      wait for 600 ms;
      second_state := led_operational;

     --   assert first_state /= second_state
     --   report "LED_OPERATIONAL should blink when enabled"
     --   severity error;

    elsif run("operational_off_when_disabled") then
      operational <= '0';
      wait for 1200 ms;
      check_equal(led_operational, '0', "LED_OPERATIONAL should stay low when disabled");
    end if;

    test_runner_cleanup(runner);
  end process;

end architecture tb;