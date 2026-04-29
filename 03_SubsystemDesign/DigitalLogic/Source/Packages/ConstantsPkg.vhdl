library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

package constantspkg is

  constant sys_clk_freq  : natural := 12_000_000; -- System clock frequency in Hz
  constant adc_bits      : natural := 12;         -- ADC resolution in bits
  constant channel_count : natural := 256;        -- Number of channels in the spectrometer

end package constantspkg;

package body constantspkg is

end package body constantspkg;
