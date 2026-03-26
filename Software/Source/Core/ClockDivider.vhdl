--------------------------------------------------------------------------------
-- GammaSpectrometer - Clock Divider
-- Description: Generates slower clocks from main system clock
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ClockDivider is
    generic (
        DivisionFactor : positive := 2
    );
    port (
        Clk       : in  std_logic;
        Reset     : in  std_logic;
        ClkOut    : out std_logic;
        ClkEnable : out std_logic  -- Single-cycle pulse at ClkOut rate
    );
end entity ClockDivider;

architecture Rtl of ClockDivider is
    signal Counter : unsigned(31 downto 0) := (others => '0');
    signal ClkReg  : std_logic := '0';
begin

    process(Clk)
    begin
        if rising_edge(Clk) then
            if Reset = '1' then
                Counter   <= (others => '0');
                ClkReg    <= '0';
                ClkEnable <= '0';
            else
                ClkEnable <= '0';

                if Counter = DivisionFactor / 2 - 1 then
                    Counter   <= (others => '0');
                    ClkReg    <= not ClkReg;
                    ClkEnable <= not ClkReg;  -- Pulse on rising edge
                else
                    Counter <= Counter + 1;
                end if;
            end if;
        end if;
    end process;

    ClkOut <= ClkReg;

end architecture Rtl;