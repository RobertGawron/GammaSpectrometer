--------------------------------------------------------------------------------
-- GammaSpectrometer - Top Level Entity
-- Description: Main FPGA top-level for gamma spectrometer
-- Target: iCE40HX4K-TQ144
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.Types.all;

entity Top is
    port (
        -- Clock and reset
        Clk12MHz    : in  std_logic;
        ResetN      : in  std_logic;

        -- SPI interface to ADC
        SpiSclk     : out std_logic;
        SpiMosi     : out std_logic;
        SpiMiso     : in  std_logic;
        SpiCsN      : out std_logic;

        -- UART interface
        UartTx      : out std_logic;
        UartRx      : in  std_logic;

        -- Status LEDs
        LedHeartbeat : out std_logic;
        LedPulse     : out std_logic;
        LedError     : out std_logic;

        -- Debug/test points
        DebugOut    : out std_logic_vector(3 downto 0)
    );
end entity Top;

architecture Rtl of Top is

    -- Internal signals
    signal Reset        : std_logic;
    signal Heartbeat    : std_logic;

    -- ADC signals
    signal AdcDataValid : std_logic;
    signal AdcValue     : AdcData;

    -- Pulse detection signals
    signal PulseDetected : std_logic;
    signal PulseAmplitude : AdcData;

    -- Heartbeat counter (for LED blink)
    signal HeartbeatCounter : unsigned(22 downto 0) := (others => '0');

begin

    -- Reset synchronization (active high internal reset)
    Reset <= not ResetN;

    ---------------------------------------------------------------------------
    -- Heartbeat LED (shows FPGA is running)
    ---------------------------------------------------------------------------
    HeartbeatProc : process(Clk12MHz)
    begin
        if rising_edge(Clk12MHz) then
            if Reset = '1' then
                HeartbeatCounter <= (others => '0');
            else
                HeartbeatCounter <= HeartbeatCounter + 1;
            end if;
        end if;
    end process;

    LedHeartbeat <= HeartbeatCounter(22);  -- ~1.4 Hz blink

    ---------------------------------------------------------------------------
    -- Placeholder outputs (implement modules later)
    ---------------------------------------------------------------------------
    SpiSclk  <= '0';
    SpiMosi  <= '0';
    SpiCsN   <= '1';
    UartTx   <= '1';

    LedPulse <= '0';
    LedError <= '0';

    DebugOut <= (others => '0');

end architecture Rtl;