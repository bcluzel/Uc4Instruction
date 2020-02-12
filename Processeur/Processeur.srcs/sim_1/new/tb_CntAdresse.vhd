library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity CntAdresse_tb is
end;

architecture bench of CntAdresse_tb is

  component CntAdresse
      Port ( in_init : in STD_LOGIC;
             in_enable : in STD_LOGIC;
             in_clk : in STD_LOGIC;
             in_reset : in STD_LOGIC;
             in_ce : in STD_LOGIC;
             in_load : in STD_LOGIC;
             in_data : in STD_LOGIC_VECTOR (5 downto 0);
             out_data : out STD_LOGIC_VECTOR (5 downto 0));
  end component;

  signal in_init: STD_LOGIC;
  signal in_enable: STD_LOGIC;
  signal in_clk: STD_LOGIC;
  signal in_reset: STD_LOGIC;
  signal in_ce: STD_LOGIC;
  signal in_load: STD_LOGIC;
  signal in_data: STD_LOGIC_VECTOR (5 downto 0);
  signal out_data: STD_LOGIC_VECTOR (5 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: CntAdresse port map ( in_init   => in_init,
                             in_enable => in_enable,
                             in_clk    => in_clk,
                             in_reset  => in_reset,
                             in_ce     => in_ce,
                             in_load   => in_load,
                             in_data   => in_data,
                             out_data  => out_data );

  stimulus: process
  begin
  
    -- Put initialisation code here
    in_reset <= '1';
    in_init <= '0';
    in_enable <= '0';
    in_load <= '0';
    in_ce <= '1';
    in_data <= "000010";
    wait for 10 ns;
    
    in_reset <= '0';

    in_init <= '1';
    wait for 20 ns;
    
    in_load <='1';
    in_init <= '0';
    wait for 20 ns;
    
    in_load <='0';   
    in_enable <= '1';
    wait for 20 ns;
    
    in_data <= "111001";
    in_load <='1';  
    wait for 10 ns;
    
    in_load <='0';  
    in_enable <= '1';
    wait for 100 ns; 
    
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