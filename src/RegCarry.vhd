----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2020 14:24:10
-- Design Name: 
-- Module Name: RegCarry - Behavioral
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

entity RegCarry is
    Port ( in_carry : in STD_LOGIC;
           in_load : in STD_LOGIC;
           in_clk : in STD_LOGIC;
           in_reset : in STD_LOGIC;
           in_ce : in STD_LOGIC;
           in_init : in STD_LOGIC;
           out_carry : out STD_LOGIC);
end RegCarry;

architecture Behavioral of RegCarry is

begin

    Carry : process (in_clk, in_reset) is

    begin
    
        if(in_reset = '1') then
            out_carry <= '0';
        elsif (in_clk = '1' and in_clk'event) then
            if(in_ce = '1') then
                if(in_init = '1') then
                    out_carry <= '0';                           
                elsif(in_load = '1') then
                    out_carry <= in_carry;
                end if;
            end if;
        end if;
        
    end process;
end Behavioral;
