--------------------------------------------------------------------------------
-- GammaSpectrometer - Top Level Testbench
--------------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

library vunit_lib;
  context vunit_lib.vunit_context;

entity TB_TOP is
  generic (
    RUNNER_CFG : string
  );
end entity TB_TOP;

architecture SIM of TB_TOP is

  constant clk_period             : time := 83.333 ns;  -- 12 MHz

  signal clk12mhz                 : std_logic := '0';
  signal resetn                   : std_logic := '0';
  signal spisclk                  : std_logic;
  signal spimosi                  : std_logic;
  signal spimiso                  : std_logic := '0';
  signal spicsn                   : std_logic;
  signal uarttx                   : std_logic;
  signal uartrx                   : std_logic := '1';
  signal led_operational          : std_logic;
  signal led_pulse_detected       : std_logic;
  signal led_sipm_overlighted     : std_logic;
  signal debugout                 : std_logic_vector(3 downto 0);

begin

  ---------------------------------------------------------------------------
  -- Device Under Test
  ---------------------------------------------------------------------------
  DUT : entity work.top
    port map (
      CLK12MHZ             => clk12mhz,
      RESETN               => resetn,
      SPISCLK              => spisclk,
      SPIMOSI              => spimosi,
      SPIMISO              => spimiso,
      SPICSN               => spicsn,
      UARTTX               => uarttx,
      UARTRX               => uartrx,
      LED_OPERATIONAL      => led_operational,
      LED_PULSE_DETECTED   => led_pulse_detected,
      LED_SIPM_OVERLIGHTED => led_sipm_overlighted,
      DEBUGOUT             => debugout
    );

  ---------------------------------------------------------------------------
  -- Clock Generation
  ---------------------------------------------------------------------------
  CLKPROC : process is
  begin

    clk12mhz <= '0';
    wait for clk_period / 2;
    clk12mhz <= '1';
    wait for clk_period / 2;

  end process CLKPROC;

  ---------------------------------------------------------------------------
  -- Main Test Process
  ---------------------------------------------------------------------------
  MAIN : process is
  begin

    test_runner_setup(runner, RUNNER_CFG);

    while test_suite loop

      if run("test_reset") then
        resetn <= '0';
        wait for 10 * clk_period;
        check_equal(led_sipm_overlighted, '0', "LED Error should be off during reset");
        resetn <= '1';
        wait for 10 * clk_period;
        info("Reset test passed");
      elsif run("test_heartbeat_starts") then
        resetn <= '0';
        wait for 10 * clk_period;
        resetn <= '1';
        wait for 100 * clk_period;
        info("Heartbeat startup test completed");
      elsif run("test_spi_idle") then
        resetn <= '0';
        wait for 10 * clk_period;
        resetn <= '1';
        wait for 10 * clk_period;
        check_equal(spicsn, '1', "SPI CS should be high (idle)");
        info("SPI idle test passed");
      elsif run("test_uart_idle") then
        resetn <= '0';
        wait for 10 * clk_period;
        resetn <= '1';
        wait for 10 * clk_period;
        check_equal(uarttx, '1', "UART TX should be high (idle)");
        info("UART idle test passed");
      end if;

    end loop;

    test_runner_cleanup(runner);

  end process MAIN;

  test_runner_watchdog(runner, 10 ms);

end architecture SIM;
