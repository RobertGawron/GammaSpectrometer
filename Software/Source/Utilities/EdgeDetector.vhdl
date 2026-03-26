--------------------------------------------------------------------------------
-- GammaSpectrometer - Edge Detector
-- Description: Detects rising and falling edges on input signal
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity EdgeDetector is
    port (
        Clk         : in  std_logic;
        Reset       : in  std_logic;
        Input       : in  std_logic;
        RisingEdge  : out std_logic;
        FallingEdge : out std_logic
    );
end entity EdgeDetector;

architecture Rtl of EdgeDetector is
    signal InputD1 : std_logic := '0';
    signal InputD2 : std_logic := '0';
begin

    process(Clk)
    begin
        if rising_edge(Clk) then
            if Reset = '1' then
                InputD1 <= '0';
                InputD2 <= '0';
            else
                InputD1 <= Input;
                InputD2 <= InputD1;
            end if;
        end if;
    end process;

    RisingEdge  <= InputD1 and not InputD2;
    FallingEdge <= not InputD1 and InputD2;

end architecture Rtl;