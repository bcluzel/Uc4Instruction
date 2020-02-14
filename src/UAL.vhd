----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2020 15:31:01
-- Design Name: 
-- Module Name: UAL - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL is
    Port ( in_select : in STD_LOGIC;
           in_dataA : in STD_LOGIC_VECTOR (7 downto 0);
           in_dataB : in STD_LOGIC_VECTOR (7 downto 0);
           out_carry : out STD_LOGIC;
           out_data : out STD_LOGIC_VECTOR (7 downto 0));
end UAL;

architecture Behavioral of UAL is

--signal s_data : STD_LOGIC_VECTOR  (8 downto 0) := (others => '0');

    signal s_data : std_logic_vector (8 downto 0);
begin    

    UAL : process (in_select, in_dataA, in_dataB) is
        
    begin
    
        if (in_select = '0') then
            s_data (7 DOWNTO 0) <= in_dataA NOR in_dataB;
            s_data(8) <= '0';
        else 
            s_data <= std_logic_vector( resize(unsigned(in_dataA), 9) + resize(unsigned(in_dataB), 9));      
        end if;

    end process;
    
    out_carry <= s_data(8);
    out_data <= s_data(7 downto 0); 
    
end Behavioral;
