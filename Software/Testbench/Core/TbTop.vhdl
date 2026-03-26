--------------------------------------------------------------------------------
-- GammaSpectrometer - Top Level Testbench
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TbTop is
end entity TbTop;

architecture Sim of TbTop is

    -- Clock period
    constant CLK_PERIOD : time := 83.333 ns;  -- 12 MHz

    -- DUT signals
    signal Clk12MHz     : std_logic := '0';
    signal ResetN       : std_logic := '0';
    signal SpiSclk      : std_logic;
    signal SpiMosi      : std_logic;
    signal SpiMiso      : std_logic := '0';
    signal SpiCsN       : std_logic;
    signal UartTx       : std_logic;
    signal UartRx       : std_logic := '1';
    signal LedHeartbeat : std_logic;
    signal LedPulse     : std_logic;
    signal LedError     : std_logic;
    signal DebugOut     : std_logic_vector(3 downto 0);

    -- Simulation control
    signal SimDone : boolean := false;

begin

    ---------------------------------------------------------------------------
    -- Device Under Test
    ---------------------------------------------------------------------------
    Dut : entity work.Top
        port map (
            Clk12MHz     => Clk12MHz,
            ResetN       => ResetN,
            SpiSclk      => SpiSclk,
            SpiMosi      => SpiMosi,
            SpiMiso      => SpiMiso,
            SpiCsN       => SpiCsN,
            UartTx       => UartTx,
            UartRx       => UartRx,
            LedHeartbeat => LedHeartbeat,
            LedPulse     => LedPulse,
            LedError     => LedError,
            DebugOut     => DebugOut
        );

    ---------------------------------------------------------------------------
    -- Clock Generation
    ---------------------------------------------------------------------------
    ClkProc : process
    begin
        while not SimDone loop
            Clk12MHz <= '0';
            wait for CLK_PERIOD / 2;
            Clk12MHz <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    ---------------------------------------------------------------------------
    -- Stimulus
    ---------------------------------------------------------------------------
    StimProc : process
    begin
        -- Initial reset
        ResetN <= '0';
        wait for 10 * CLK_PERIOD;

        -- Release reset
        ResetN <= '1';
        wait for 100 * CLK_PERIOD;

        -- Let it run to see heartbeat
        report "Running simulation for heartbeat LED test...";
        wait for 10 ms;

        -- End simulation
        report "Simulation completed successfully!";
        SimDone <= true;
        wait;
    end process;

end architecture Sim;