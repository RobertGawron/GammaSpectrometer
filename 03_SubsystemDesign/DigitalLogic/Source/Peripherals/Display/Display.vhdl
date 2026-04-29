library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

library work;
  use work.ConstantsPkg.all;

entity Display is
  port (
    clk                  : in  std_logic;
    rst                  : in  std_logic;
    operational          : in  std_logic;
    pulse_detected       : in  std_logic;
    sipm_overlighted     : in  std_logic;
    led_operational      : out std_logic;
    led_pulse_detected   : out std_logic;
    led_sipm_overlighted : out std_logic
  );
end entity Display;

architecture RTL of Display is

  constant BLINK_HALF_PERIOD : natural := SYS_CLK_FREQ / 2;

  signal blink_counter : natural range 0 to BLINK_HALF_PERIOD - 1 := 0;
  signal blink_1hz     : std_logic := '0';

begin

  process (clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        blink_counter <= 0;
        blink_1hz     <= '0';
      else
        if blink_counter = BLINK_HALF_PERIOD - 1 then
          blink_counter <= 0;
          blink_1hz     <= not blink_1hz;
        else
          blink_counter <= blink_counter + 1;
        end if;
      end if;
    end if;
  end process;

  led_operational      <= blink_1hz when operational = '1' else '0';
  led_pulse_detected   <= pulse_detected;
  led_sipm_overlighted <= sipm_overlighted;

end architecture RTL;