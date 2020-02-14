----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2020 12:50:15
-- Design Name: 
-- Module Name: UT - Behavioral
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

entity UT is
    Port ( in_clk : in STD_LOGIC;
           in_reset : in STD_LOGIC;
           in_ce : in STD_LOGIC;
           in_data : in STD_LOGIC_VECTOR (7 downto 0);
           in_loadAccu : in STD_LOGIC;
           in_selData : in STD_LOGIC;
           in_initCarry : in STD_LOGIC;
           in_loadCarry : in STD_LOGIC;
           in_loadData : in STD_LOGIC;
           out_data : out STD_LOGIC_VECTOR (7 downto 0);
           out_carry : out STD_LOGIC);
end UT;

architecture Behavioral of UT is

COMPONENT RegCarry IS
PORT(   in_carry : in STD_LOGIC;
        in_load : in STD_LOGIC;
        in_clk : in STD_LOGIC;
        in_reset : in STD_LOGIC;
        in_ce : in STD_LOGIC;
        in_init : in STD_LOGIC;
        out_carry : out STD_LOGIC);

END COMPONENT RegCarry;


COMPONENT Nregister IS
PORT(   in_data : in std_logic_vector(7 downto 0);
        in_load : in std_logic;
        in_ce : in std_logic;
        in_clk : in std_logic;
        in_reset : in std_logic;
        out_data : out std_logic_vector(7 downto 0));

END COMPONENT Nregister;

COMPONENT UAL IS
PORT(   in_select : in STD_LOGIC;
        in_dataA : in STD_LOGIC_VECTOR (7 downto 0);
        in_dataB : in STD_LOGIC_VECTOR (7 downto 0);
        out_carry : out STD_LOGIC;
        out_data : out STD_LOGIC_VECTOR (7 downto 0));

END COMPONENT UAL;

signal s_inCarry : STD_LOGIC;
signal s_dataUALa : STD_LOGIC_VECTOR (7 downto 0);
signal s_dataUALb : STD_LOGIC_VECTOR (7 downto 0);
signal s_dataAcc : STD_LOGIC_VECTOR (7 downto 0);


begin

Reg_Carry : RegCarry
    Port map (in_carry => s_inCarry, in_load => in_loadCarry, in_clk => in_clk, in_reset => in_reset, in_ce => in_ce, in_init => in_initCarry, out_carry => out_carry);

Reg_Data : Nregister
        Port map (in_data => in_data, in_load => in_loadData, in_ce => in_ce, in_clk => in_clk, in_reset => in_reset, out_data => s_dataUALa);

UAL_Component : UAL
        Port map (in_select => in_selData, in_dataA => s_dataUALa, in_dataB => s_dataUALb, out_carry => s_inCarry, out_data => s_dataAcc);

Reg_Accu : Nregister
        Port map (in_data => s_dataAcc, in_load => in_loadAccu, in_ce => in_ce, in_clk => in_clk, in_reset => in_reset, out_data => s_dataUALb);



end Behavioral;
