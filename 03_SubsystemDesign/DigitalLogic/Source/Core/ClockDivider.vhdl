--------------------------------------------------------------------------------
-- GammaSpectrometer - Clock Divider
-- Description: Generates slower clocks from main system clock
--------------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity CLOCKDIVIDER is
  generic (
    DIVISIONFACTOR : positive := 2
  );
  port (
    CLK       : in    std_logic;
    RESET     : in    std_logic;
    CLKOUT    : out   std_logic;
    CLKENABLE : out   std_logic  -- Single-cycle pulse at ClkOut rate
  );
end entity CLOCKDIVIDER;

architecture RTL of CLOCKDIVIDER is

  signal counter : unsigned(31 downto 0) := (others => '0');
  signal clkreg  : std_logic             := '0';

begin

  process (CLK) is
  begin

    if rising_edge(CLK) then
      if (RESET = '1') then
        counter   <= (others => '0');
        clkreg    <= '0';
        CLKENABLE <= '0';
      else
        CLKENABLE <= '0';

        if (counter = DIVISIONFACTOR / 2 - 1) then
          counter   <= (others => '0');
          clkreg    <= not clkreg;
          CLKENABLE <= not clkreg;  -- Pulse on rising edge
        else
          counter <= counter + 1;
        end if;
      end if;
    end if;

  end process;

  CLKOUT <= clkreg;

end architecture RTL;
