library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity nregister is
    generic(
    constant R_SIZE: natural := 8
    );
    
    port (
    in_data : in std_logic_vector(R_SIZE-1 downto 0);
    in_load : in std_logic;
    in_ce : in std_logic;
    in_clk : in std_logic;
    in_reset : in std_logic;
    out_data : out std_logic_vector(R_SIZE-1 downto 0)
    );
end entity;

architecture rtl of nregister is

begin

    counter : process(in_clk,in_reset)
    begin
        if in_reset = '1' then
        out_data <= (others => '0');
        elsif in_clk = '1' and in_clk'event then
            if in_ce = '1' then
                if in_load = '1' then
                    out_data <= in_data;
                end if;
            end if;
        end if;
    end process;
    

end architecture;
