--------------------------------------------------------------------------------
-- GammaSpectrometer - Custom Types Package
-- Description: Common types and constants for the project
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package Types is

    -- System constants
    constant SYS_CLK_FREQ    : natural := 12_000_000;  -- 12 MHz
    constant ADC_BITS        : natural := 12;
    constant CHANNEL_COUNT   : natural := 256;

    -- ADC data type
    subtype AdcData is unsigned(ADC_BITS - 1 downto 0);

    -- Spectrum channel type
    subtype ChannelIndex is unsigned(7 downto 0);
    subtype ChannelCount is unsigned(15 downto 0);

    -- Pulse detection states
    type PulseState is (
        Idle,
        Rising,
        Peak,
        Falling,
        Cooldown
    );

    -- SPI modes
    type SpiMode is (
        Mode0,  -- CPOL=0, CPHA=0
        Mode1,  -- CPOL=0, CPHA=1
        Mode2,  -- CPOL=1, CPHA=0
        Mode3   -- CPOL=1, CPHA=1
    );

end package Types;

package body Types is
end package body Types;