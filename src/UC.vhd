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

signal s_inFSMinstruct : std_logic_vector(1 downto 0);
signal s_inCntAddress : std_logic_vector(5 downto 0);
signal s_inMultiplexer : std_logic_vector(5 downto 0);
signal s_loadCnt : std_logic;
signal s_load_instruction : std_logic;
signal s_initCnt : std_logic;
signal s_enableCnt : std_logic;
signal s_selectMux : std_logic;




begin

Reg_instruction : Nregister
        Port map( in_data  =>in_dataUC , in_load => s_load_instruction, in_ce => in_ce, in_clk => in_clk, in_reset => in_reset, out_data (7 downto 6) => s_inFSMinstruct, out_data(5 downto 0) => s_inCntAddress);

Cnt_adress : CntAdresse
        Port map (in_init => s_initCnt, in_enable => s_enableCnt, in_clk => in_clk, in_reset => in_reset, in_ce => in_ce, in_load => s_loadCnt, in_data => s_inCntAddress, out_data => s_inMultiplexer);

Mult : Multiplexer
        Port map (in_select =>  s_selectMux, in_dataA => s_inMultiplexer, in_dataB => s_inCntAddress, out_data => out_adress);
        
FSM_UC : FSM 
        Port map (in_clk => in_clk, in_ce => in_ce, in_reset => in_reset, in_instruction => s_inFSMinstruct, in_carry => in_carry, out_load_accu => out_loadAccu, out_load_data => out_loadData, out_load_carry => out_loadCarry, 
        out_init_carry => out_initCarry, out_ual_set_val => out_selUALcalc, out_load_instruct => s_load_instruction, out_sel_mux => s_selectMux, out_load_cnt => s_loadCnt, out_init_cnt => s_initCnt, out_en_cnt => s_enableCnt, out_en_memory => out_enMem, out_sel_memory_r_w => out_rw);

end Behavioral;
