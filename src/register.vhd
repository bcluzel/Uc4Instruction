library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity register is
constant R_SIZE: natural := 8;

  port (
  in_load : in std_logic_vector(R_SIZE-1 downto 0);
  in_w : in std_logic;
  out_read : out std_logic_vector(R_SIZE-1 downto 0);
  clk : in std_logic;
  rst : in std_logic
  );
end entity;

architecture rtl of register is

begin

  counter : process(clk,rst)
  begin
  if rst = '0' then
    out_read <= (others => '0');
  elsif clk = '1' and clk'event then
      if in_w = '1' then 
        out_read <= in_load;
      end if;
  end if;
  end process;


end architecture;
