library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FSM is
  port (
  clk : in std_logic;
  rst : in std_logic; -- switch which enable the player to initialize the board
  );
end entity;

architecture rtl of FSM is
type fsm_state is (INIT,); --7 fsm states
signal next_state, current_state : fsm_state; --signals to store current and next states
begin

  counter : process(clk,rst)
  begin --PROCESS STATE REGISTER (SEQ)
    if rst = '0' then
      current_state <= INIT;
      --next_state <= INIT;
    elsif clk = '1' and clk'event then
      current_state <= next_state;
    end if;
  end process;

  process (current_state) is
  begin -- PROCESS NEXT STATE LOGIC (COMB)
    case current_state is
      when INIT =>
       next_state <= INIT;
    end case;
  end process;

  process (current_state) is
  begin -- PROCESS OUTPUT LOGIC
    case current_state is
      when INIT =>
    end case;
  end process;
end architecture;
