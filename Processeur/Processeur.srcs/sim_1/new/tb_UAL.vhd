----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2020 15:48:35
-- Design Name: 
-- Module Name: tb_UAL - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity UAL_tb is
end;

architecture bench of UAL_tb is

  component UAL
      Port ( in_select : in STD_LOGIC;
             in_dataA : in STD_LOGIC_VECTOR (7 downto 0);
             in_dataB : in STD_LOGIC_VECTOR (7 downto 0);
             out_carry : out STD_LOGIC;
             out_data : out STD_LOGIC_VECTOR (7 downto 0));
  end component;

  signal in_select: STD_LOGIC;
  signal in_dataA: STD_LOGIC_VECTOR (7 downto 0);
  signal in_dataB: STD_LOGIC_VECTOR (7 downto 0);
  signal out_carry: STD_LOGIC;
  signal out_data: STD_LOGIC_VECTOR (7 downto 0);

begin

  uut: UAL port map ( in_select => in_select,
                      in_dataA  => in_dataA,
                      in_dataB  => in_dataB,
                      out_carry => out_carry,
                      out_data  => out_data );

  stimulus: process
  begin
  
    -- Put initialisation code here

    in_dataA <= "00000010";
    in_dataB <= "00000001";
    
    in_select <= '0';
    wait for 20 ns;
    
    in_select <= '1';
    wait for 20 ns;
    
    in_select <= '0';
    wait for 20 ns;
    
    in_dataA <= "11111110";
    in_dataB <= "00010001";
    wait for 20 ns;
    
    in_select <= '1';
    wait for 20 ns; 
    


    -- Put test bench stimulus code here

    wait;
  end process;

end;