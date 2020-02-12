library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity RegCarry_tb is
end;

architecture bench of RegCarry_tb is

  component RegCarry
      Port ( in_carry : in STD_LOGIC;
             in_load : in STD_LOGIC;
             in_clk : in STD_LOGIC;
             in_reset : in STD_LOGIC;
             in_ce : in STD_LOGIC;
             in_init : in STD_LOGIC;
             out_carry : out STD_LOGIC);
  end component;

  signal in_carry: STD_LOGIC;
  signal in_load: STD_LOGIC;
  signal in_clk: STD_LOGIC;
  signal in_reset: STD_LOGIC;
  signal in_ce: STD_LOGIC;
  signal in_init: STD_LOGIC;
  signal out_carry: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: RegCarry port map ( in_carry  => in_carry,
                           in_load   => in_load,
                           in_clk    => in_clk,
                           in_reset  => in_reset,
                           in_ce     => in_ce,
                           in_init   => in_init,
                           out_carry => out_carry );

  stimulus: process
  begin
  
    -- Put initialisation code here
    in_carry <= '1';
    in_reset <= '1';
    in_ce <= '1';
    wait for 20 ns;

    in_reset <= '0';
    in_load <= '1';
    in_carry <= '1';
    wait for 10 ns;
    
    in_load <= '0';
    wait for 10 ns;
    
    in_init <= '1';
    wait for 20 ns;
    
    in_ce <= '0';
    wait for 10 ns;
    
   
    in_carry <= '1';
    wait for 10 ns;
    
    in_load <= '1';

    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      in_clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;