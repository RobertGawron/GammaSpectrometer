--------------------------------------------------------------------------------
-- GammaSpectrometer - Top Level Entity
-- Description: Main FPGA top-level for gamma spectrometer
-- Target: iCE40HX4K-TQ144
--------------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use work.constantspkg.all;
  use work.typespkg.all;

entity TOP is
  port (
    -- Clock and reset
    CLK12MHZ                 : in    std_logic;
    RESETN                   : in    std_logic;

    -- SPI interface to ADC
    SPISCLK                  : out   std_logic;
    SPIMOSI                  : out   std_logic;
    SPIMISO                  : in    std_logic;
    SPICSN                   : out   std_logic;

    -- UART interface
    UARTTX                   : out   std_logic;
    UARTRX                   : in    std_logic;

    -- Status LEDs
    LED_OPERATIONAL          : out   std_logic;
    LED_PULSE_DETECTED       : out   std_logic;
    LED_SIPM_OVERLIGHTED     : out   std_logic;

    -- Debug/test points
    DEBUGOUT                 : out   std_logic_vector(3 downto 0)
  );
end entity TOP;

architecture RTL of TOP is

  -- Internal signals
  signal reset            : std_logic;
  signal heartbeat        : std_logic;

  -- ADC signals
  signal adcdatavalid     : std_logic;
  signal adcvalue         : adcdata;

  -- Pulse detection signals
  signal pulsedetected    : std_logic;
  signal pulseamplitude   : adcdata;

  -- Heartbeat counter (for LED blink)
  signal heartbeatcounter : unsigned(22 downto 0) := (others => '0');

begin

  -- Reset synchronization (active high internal reset)
  reset <= not RESETN;

  ---------------------------------------------------------------------------
  -- Heartbeat LED (shows FPGA is running)
  ---------------------------------------------------------------------------
  HEARTBEATPROC : process (CLK12MHZ) is
  begin

    if rising_edge(CLK12MHZ) then
      if (reset = '1') then
        heartbeatcounter <= (others => '0');
      else
        heartbeatcounter <= heartbeatcounter + 1;
      end if;
    end if;

  end process HEARTBEATPROC;

  LED_OPERATIONAL <= heartbeatcounter(22);  -- ~1.4 Hz blink

  ---------------------------------------------------------------------------
  -- Placeholder outputs (implement modules later)
  ---------------------------------------------------------------------------
  SPISCLK <= '0';
  SPIMOSI <= '0';
  SPICSN  <= '1';
  UARTTX  <= '1';

  LED_PULSE_DETECTED   <= '0';
  LED_SIPM_OVERLIGHTED <= '0';

  DEBUGOUT <= (others => '0');

end architecture RTL;
