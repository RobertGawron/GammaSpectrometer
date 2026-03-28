library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use work.constantspkg.all;

package typespkg is

  subtype adcdata is unsigned(adc_bits - 1 downto 0);

  subtype channelindex is unsigned(7 downto 0);

  subtype channelcount is unsigned(15 downto 0);

  type pulsestate is (
    IDLE,
    RISING,
    PEAK,
    FALLING,
    COOLDOWN
  );

  type spimode is (
    MODE0,
    MODE1,
    MODE2,
    MODE3
  );

end package typespkg;

package body typespkg is

end package body typespkg;
