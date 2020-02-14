----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2020 14:12:12
-- Design Name: 
-- Module Name: UC - Behavioral
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

entity UC is
    Port ( in_clk : in STD_LOGIC;
           in_reset : in STD_LOGIC;
           in_ce : in STD_LOGIC;
           
           in_loadCnt : in STD_LOGIC;
           in_initCnt : in STD_LOGIC;
           in_enableCnt : in STD_LOGIC;
           in_loadIns : in STD_LOGIC;
           in_selectMux : in STD_LOGIC;
           in_carry : in STD_LOGIC;
           in_data : in STD_LOGIC_VECTOR (5 downto 0);
           
           out_selVal : out STD_LOGIC;
           out_initCarry : out STD_LOGIC;
           out_loadCarry : out STD_LOGIC;
           out_loadData : out STD_LOGIC;
           out_rw : out STD_LOGIC;
           out_enMem : out STD_LOGIC;
           our_adress : out STD_LOGIC_VECTOR (5 downto 0));
end UC;

architecture Behavioral of UC is

COMPONENT Nregister IS
PORT(   in_data : in std_logic_vector(7 downto 0);
        in_load : in std_logic;
        in_ce : in std_logic;
        in_clk : in std_logic;
        in_reset : in std_logic;
        out_data : out std_logic_vector(7 downto 0));

END COMPONENT Nregister;


COMPONENT CntAdresse is
PORT(   in_init : in STD_LOGIC;
        in_enable : in STD_LOGIC;
        in_clk : in STD_LOGIC;
        in_reset : in STD_LOGIC;
        in_ce : in STD_LOGIC;
        in_load : in STD_LOGIC;
        in_data : in STD_LOGIC_VECTOR (5 downto 0);
        out_data : out STD_LOGIC_VECTOR (5 downto 0));

END COMPONENT CntAdresse;


COMPONENT Multiplexer is
    Port ( in_select : in STD_LOGIC;
           in_dataA : in STD_LOGIC_VECTOR (5 downto 0);
           in_dataB : in STD_LOGIC_VECTOR (5 downto 0);
           out_data : out STD_LOGIC_VECTOR (5 downto 0));
           
END COMPONENT Multiplexer;


COMPONENT FSM is
  port (
  in_clk : in std_logic;
  in_ce : in std_logic;
  in_reset : in std_logic; -- switch which enable the player to initialize the board
  in_instruction : in std_logic_vector(1 downto 0);
  in_carry : in std_logic;
  out_load_accu : out std_logic;
  out_load_data : out std_logic;
  out_load_carry : out std_logic;
  out_init_carry : out std_logic;
  out_ual_set_val : out std_logic;
  out_load_instruct : out std_logic;
  out_sel_mux : out std_logic;
  out_load_cnt : out std_logic;
  out_init_cnt : out std_logic;
  out_en_cnt : out std_logic;
  out_en_memory : out std_logic;
  out_sel_memory_r_w : out std_logic);
  
END COMPONENT FSM;

begin


end Behavioral;
