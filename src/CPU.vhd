----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/14/2020 08:38:24 AM
-- Design Name: 
-- Module Name: CPU - Behavioral
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

entity CPU is
    Port ( Clk : in STD_LOGIC;
           Ce : in STD_LOGIC;
           Reset : in STD_LOGIC;
           
           Adr : out STD_LOGIC_VECTOR (5 downto 0);
           data_men_in : out STD_LOGIC_VECTOR (7 downto 0);
           data_men_out : out STD_LOGIC_VECTOR (7 downto 0));
end CPU;

architecture Behavioral of CPU is

component UT is
    Port ( in_clk : in STD_LOGIC;
           in_reset : in STD_LOGIC;
           in_ce : in STD_LOGIC;
           in_data : in STD_LOGIC_VECTOR (7 downto 0);
           in_loadAccu : in STD_LOGIC;
           in_selUALcalc : in STD_LOGIC;
           in_initCarry : in STD_LOGIC;
           in_loadCarry : in STD_LOGIC;
           in_loadData : in STD_LOGIC;
           out_data : out STD_LOGIC_VECTOR (7 downto 0);
           out_carry : out STD_LOGIC);
end component UT;

component UC is
    Port ( in_clk : in STD_LOGIC;
           in_reset : in STD_LOGIC;
           in_ce : in STD_LOGIC;
           
           in_carry : in STD_LOGIC;
           in_dataUC : in STD_LOGIC_VECTOR (7 downto 0);
           out_selUALcalc : out STD_LOGIC;
           out_initCarry : out STD_LOGIC;
           out_loadCarry : out STD_LOGIC;
           out_loadData : out STD_LOGIC;
           out_loadAccu : out STD_LOGIC;
           out_rw : out STD_LOGIC;
           out_enMem : out STD_LOGIC;
           out_adress : out STD_LOGIC_VECTOR (5 downto 0));
end component UC;

component Memory is
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
end component Memory;

signal s_memory_rw : STD_LOGIC;
signal s_memory_en : STD_LOGIC;
signal s_memory_data_in : STD_LOGIC_VECTOR (7 downto 0);
signal s_memory_data_out : STD_LOGIC_VECTOR (7 downto 0);
signal s_memory_adress : STD_LOGIC_VECTOR (5 downto 0);


signal s_carry : STD_LOGIC;
signal s_initCarry : STD_LOGIC;
signal s_loadCarry : STD_LOGIC;
signal s_loadData : STD_LOGIC;

signal s_loadAccu : STD_LOGIC;
signal s_selUALcalc : STD_LOGIC;

begin

cpu_mem : Memory 
 Port map ( in_clk => Clk,
           in_ce => Ce,
           in_rw  => s_memory_rw,
           in_en  => s_memory_en,
           in_data  => s_memory_data_in,
           out_data  => s_memory_data_out,
           in_adress  => s_memory_adress
           );
           
cpu_uc : UC
    Port map ( in_clk => Clk,
           in_reset => Reset,
           in_ce => Ce,
           in_carry => s_carry,
           in_dataUC => s_memory_data_out,
           out_selUALcalc => s_selUALcalc,
           out_initCarry => s_initCarry,
           out_loadCarry => s_loadCarry,
           out_loadData => s_loadData,
           out_loadAccu => s_loadAccu,
           out_rw => s_memory_rw,
           out_enMem => s_memory_en,
           out_adress => s_memory_adress
           );

cpu_ut : UT
    Port map ( in_clk => Clk,
           in_reset => Reset,
           in_ce => Ce,
           in_data => s_memory_data_out,
           in_loadAccu => s_loadAccu,
           in_selUALcalc => s_selUALcalc,
           in_initCarry => s_initCarry,
           in_loadCarry => s_loadCarry,
           in_loadData => s_loadData,
           out_data => s_memory_data_in,
           out_carry => s_carry
           );
                  
Adr <= s_memory_adress;
data_men_out <= s_memory_data_out;
data_men_in <= s_memory_data_in;     

end Behavioral;
