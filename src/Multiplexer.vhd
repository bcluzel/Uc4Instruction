----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2020 15:13:50
-- Design Name: 
-- Module Name: Multiplexer - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Multiplexer is
    Port ( in_select : in STD_LOGIC;
           in_dataA : in STD_LOGIC_VECTOR (5 downto 0);
           in_dataB : in STD_LOGIC_VECTOR (5 downto 0);
           out_data : out STD_LOGIC_VECTOR (5 downto 0));
end Multiplexer;

architecture Behavioral of Multiplexer is

begin

    out_data <= in_dataA when (in_select = '0') else in_dataB; 
 
end Behavioral;
