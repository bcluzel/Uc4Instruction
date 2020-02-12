
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity nregister_tb is
end;

architecture bench of nregister_tb is

      
  component nregister
      generic(
      constant R_SIZE: natural := 8
      );
      port (
      in_data : in std_logic_vector(R_SIZE-1 downto 0);
      in_load : in std_logic;
      in_ce : in std_logic;
      in_clk : in std_logic;
      in_reset : in std_logic;
      out_data : out std_logic_vector(R_SIZE-1 downto 0)
      );
  end component;
  constant R_SIZE: natural := 8;
  signal in_data: std_logic_vector(R_SIZE-1 downto 0);
  signal in_load: std_logic;
  signal in_ce: std_logic;
  signal in_clk: std_logic;
  signal in_reset: std_logic;
  signal out_data: std_logic_vector(R_SIZE-1 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: nregister generic map ( 
                               R_SIZE   =>  R_SIZE)
                    port map ( in_data  => in_data,
                               in_load  => in_load,
                               in_ce    => in_ce,
                               in_clk   => in_clk,
                               in_reset => in_reset,
                               out_data => out_data );

  stimulus: process
  begin
  
    -- Put initialisation code here
    in_ce <= '0';
    in_load <= '0';
    in_reset <= '1';
    wait for 5 ns;
    in_reset <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here
    in_data <= "01010101";
    wait for 20 ns;
    in_ce <= '1';
    wait for 20 ns;
    in_load <= '1';
    wait for 20 ns;
    in_load <= '0';
    wait for 20 ns;
    in_data <= "11110000";
    wait for 60 ns;
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