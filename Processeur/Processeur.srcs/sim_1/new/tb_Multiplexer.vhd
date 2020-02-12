----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2020 15:21:36
-- Design Name: 
-- Module Name: tb_Multiplexer - Behavioral
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

entity Multiplexer_tb is
end;

architecture bench of Multiplexer_tb is

  component Multiplexer
      Port ( in_select : in STD_LOGIC;
             in_dataA : in STD_LOGIC_VECTOR (5 downto 0);
             in_dataB : in STD_LOGIC_VECTOR (5 downto 0);
             out_data : out STD_LOGIC_VECTOR (5 downto 0));
  end component;

  signal in_select: STD_LOGIC;
  signal in_dataA: STD_LOGIC_VECTOR (5 downto 0);
  signal in_dataB: STD_LOGIC_VECTOR (5 downto 0);
  signal out_data: STD_LOGIC_VECTOR (5 downto 0);

begin

  uut: Multiplexer port map ( in_select => in_select,
                              in_dataA  => in_dataA,
                              in_dataB  => in_dataB,
                              out_data  => out_data );

  stimulus: process
  begin
  
    -- Put initialisation code here
    in_dataA <= "000100";
    in_dataB <= "010000";
    in_select <= '1';
    wait for 10 ns;

    in_select <= '0';
    wait for 10 ns;

    in_dataA <= "001000";
    wait for 20 ns;
    
    in_select <= '1';

    -- Put test bench stimulus code here

    wait;
  end process;

end;