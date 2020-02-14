----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2020 16:36:01
-- Design Name: 
-- Module Name: CntAdresse - Behavioral
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

entity CntAdresse is
    Port ( in_init : in STD_LOGIC;
           in_enable : in STD_LOGIC;
           in_clk : in STD_LOGIC;
           in_reset : in STD_LOGIC;
           in_ce : in STD_LOGIC;
           in_load : in STD_LOGIC;
           in_data : in STD_LOGIC_VECTOR (5 downto 0);
           out_data : out STD_LOGIC_VECTOR (5 downto 0));
end CntAdresse;

architecture Behavioral of CntAdresse is

signal s_data : std_logic_vector (5 downto 0) := (others => '0');

begin

    CntAdresse : process (in_clk, in_reset)
    begin
       if(in_reset = '1') then
           s_data <= (others => '0');
       elsif (in_clk = '1' and in_clk'event) then
           if(in_ce = '1') then
               if(in_init = '1') then
                   s_data <= (others => '0'); 
                                      
               elsif(in_load = '1') then
                   s_data <= in_data; 
               elsif(in_enable = '1') then
                    s_data <= std_logic_vector (unsigned(s_data) + to_unsigned(1,6));   
               end if;
               
            end if;
       end if;
    end process;

out_data <= s_data;

end Behavioral;
