library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



--
-- FSM for the 4 instruction processor
-- julielab98@gmail.com
-- baptiste.clu@gmail.com
-- Instruction :
-- NOR 00
-- ADD 01
-- STA 10
-- JCC 11
--
entity FSM is
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
  out_sel_memory_r_w : out std_logic
  );
end entity;

architecture rtl of FSM is
type fsm_state is (INIT,FETCH_INS,DECODE,FETCH_DATA,INS_NOR,INS_ADD,INS_STA,INS_JCC); --7 fsm states
signal next_state, current_state : fsm_state; --signals to store current and next states
begin

  counter : process(in_clk, in_reset)
  begin --PROCESS STATE REGISTER (SEQ)
    if in_reset = '1' then
      current_state <= INIT;
      --next_state <= INIT;
    elsif in_clk = '1' and in_clk'event then
        if in_ce = '1' then
              current_state <= next_state;
        end if;
    end if;
  end process;

  process (current_state) is
  begin -- PROCESS NEXT STATE LOGIC (COMB)
    case current_state is
      when INIT =>
        next_state <= FETCH_INS;
      when FETCH_INS =>
        next_state <= DECODE;
      when DECODE =>
        if in_instruction(1) = '0' then
          next_state <= FETCH_DATA;
        elsif in_instruction = "10" then
          next_state <= INS_STA;
        elsif in_instruction = "11" then
          next_state <= INS_JCC;
        end if;
      when FETCH_DATA =>
        if in_instruction(0) = '0' then
          next_state <= INS_NOR;
        else
          next_state <= INS_ADD;
        end if;
      when INS_NOR =>
        next_state <= FETCH_INS;
      when INS_ADD =>
        next_state <= FETCH_INS;
      when INS_STA =>
        next_state <= FETCH_INS;
      when INS_JCC =>
        next_state <= FETCH_INS;
    end case;
  end process;

  process (current_state) is
  begin -- PROCESS OUTPUT LOGIC
    case current_state is
      when INIT =>
        out_load_accu <= '0';
        out_load_data <='0';
        out_load_carry <='0';
        out_init_carry <='1';
        out_ual_set_val <='0';
        out_load_instruct <='0';
        out_sel_mux <='0';
        out_load_cnt <='0';
        out_init_cnt <='1';
        out_en_cnt <='0';
        out_en_memory <='0';
        out_sel_memory_r_w <='0';
        
      when FETCH_INS =>
        out_load_accu <= '0';
        out_load_data <='0';
        out_load_carry <='0';
        out_init_carry <='0';
        out_ual_set_val <='0';
        out_load_instruct <='1';
        out_sel_mux <='0';
        out_load_cnt <='0';
        out_init_cnt <='0';
        out_en_cnt <='1';
        out_en_memory <='1';
        out_sel_memory_r_w <='0';
      when DECODE =>
        out_load_accu <= '0';
        out_load_data <='0';
        out_load_carry <='0';
        out_init_carry <='0';
        out_ual_set_val <='0';
        out_load_instruct <='0';
        out_sel_mux <='1'; -- On pointe l'adresse de la mémoire qui est écrite de 5..0 apres l'instruction
        out_load_cnt <='0';
        out_init_cnt <='0';
        out_en_cnt <='0';
        out_en_memory <='0';
        out_sel_memory_r_w <='0';      
      when FETCH_DATA =>
        out_load_accu <= '0';
        out_load_data <='1';
        out_load_carry <='0';
        out_init_carry <='0';
        out_ual_set_val <='0';
        out_load_instruct <='0';
        out_sel_mux <='1';
        out_load_cnt <='0';
        out_init_cnt <='0';
        out_en_cnt <='0';
        out_en_memory <='1';
        out_sel_memory_r_w <='0'; 
      when INS_NOR =>
        out_load_accu <= '1';
        out_load_data <='0';
        out_load_carry <='0';
        out_init_carry <='0';
        out_ual_set_val <='0';
        out_load_instruct <='0';
        out_sel_mux <='1';
        out_load_cnt <='0';
        out_init_cnt <='0';
        out_en_cnt <='0';
        out_en_memory <='0';
        out_sel_memory_r_w <='0';
      when INS_ADD =>
        out_load_accu <= '1';
        out_load_data <='0';
        out_load_carry <='1';
        out_init_carry <='0';
        out_ual_set_val <='1';
        out_load_instruct <='0';
        out_sel_mux <='1';
        out_load_cnt <='0';
        out_init_cnt <='0';
        out_en_cnt <='0';
        out_en_memory <='0';
        out_sel_memory_r_w <='0';
      when INS_STA =>
        out_load_accu <= '0';
        out_load_data <='0';
        out_load_carry <='0';
        out_init_carry <='0';
        out_ual_set_val <='0';
        out_load_instruct <='0';
        out_sel_mux <='1';
        out_load_cnt <='0';
        out_init_cnt <='0';
        out_en_cnt <='0';
        out_en_memory <='1';
        out_sel_memory_r_w <='1';
      when INS_JCC =>
        out_load_accu <= '0';
        out_load_data <='0';
        out_load_carry <='0';
        out_init_carry <= in_carry;
        out_ual_set_val <='0';
        out_load_instruct <='0';
        out_sel_mux <='1';
        out_load_cnt <= not in_carry;
        out_init_cnt <='0';
        out_en_cnt <='0';
        out_en_memory <='0';
        out_sel_memory_r_w <='0';
    end case;
  end process;
end architecture;
