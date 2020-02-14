----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2020 13:03:01
-- Design Name: 
-- Module Name: tb_FSM - Behavioral
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

entity FSM_tb is
end;

architecture bench of FSM_tb is

  component FSM
    port (
    in_clk : in std_logic;
    in_ce : in std_logic;
    in_reset : in std_logic;
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
    out_sel_memory_r_w : out std_logic
    );
  end component;

  signal in_clk: std_logic;
  signal in_ce: std_logic;
  signal in_reset: std_logic;
  signal in_instruction: std_logic_vector(1 downto 0);
  signal in_carry: std_logic;
  signal out_load_accu: std_logic;
  signal out_load_data: std_logic;
  signal out_load_carry: std_logic;
  signal out_init_carry: std_logic;
  signal out_ual_set_val: std_logic;
  signal out_load_instruct: std_logic;
  signal out_sel_mux: std_logic;
  signal out_load_cnt: std_logic;
  signal out_init_cnt: std_logic;
  signal out_en_cnt: std_logic;
  signal out_en_memory: std_logic;
  signal out_sel_memory_r_w: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: FSM port map ( in_clk             => in_clk,
                      in_ce              => in_ce,
                      in_reset           => in_reset,
                      in_instruction     => in_instruction,
                      in_carry           => in_carry,
                      out_load_accu      => out_load_accu,
                      out_load_data      => out_load_data,
                      out_load_carry     => out_load_carry,
                      out_init_carry     => out_init_carry,
                      out_ual_set_val    => out_ual_set_val,
                      out_load_instruct  => out_load_instruct,
                      out_sel_mux        => out_sel_mux,
                      out_load_cnt       => out_load_cnt,
                      out_init_cnt       => out_init_cnt,
                      out_en_cnt         => out_en_cnt,
                      out_en_memory      => out_en_memory,
                      out_sel_memory_r_w => out_sel_memory_r_w );

  stimulus: process
  begin
  
    -- Put initialisation code here
    in_instruction <= "00";
    in_ce <= '0';
    in_carry <= '0';
    in_reset <= '1';
    wait for 5 ns;
    in_reset <= '0';
    wait for 5 ns;
    in_ce <= '1';
    wait for 100 ns;
    in_instruction <= "01";
    wait for 100 ns;
    in_instruction <= "10";
    wait for 100 ns;
    in_instruction <= "11";
    wait for 100 ns;
    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      in_clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
