----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2020 17:59:26
-- Design Name: 
-- Module Name: Memory - Behavioral
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

entity Memory is
    Generic(constant R_SIZE : natural := 8;
            constant MEM_SIZE : natural := 64);
    Port ( in_clk : in STD_LOGIC;
           in_ce : in STD_LOGIC;
           in_rw : in STD_LOGIC;
           in_en : in STD_LOGIC;
           in_data : in STD_LOGIC_VECTOR (7 downto 0);
           out_data : out STD_LOGIC_VECTOR (7 downto 0);
           in_adress : in STD_LOGIC_VECTOR (5 downto 0)
           );
end Memory;

architecture Behavioral of Memory is
type table_mem is array (0 to MEM_SIZE-1) of std_logic_vector(R_SIZE-1 downto 0);
signal table_mem : my_table;
begin

    Memory : process (in_clk)

    begin
    
        if(in_clk = '0' and in_clk'event) then
            if in_ce = '1' then
                if in_en = '1' then
                    if in_rw = '0' then
                        out_data <= my_table(in_adress);
                    else
                        my_table(in_adress) <= in_data;
                    end if;
                end if;
            end if;
            
        
        end if;
        
    end process;

end Behavioral;
