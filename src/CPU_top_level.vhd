----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:40:00 02/15/2011 
-- Design Name: 
-- Module Name:    CPU_8bits - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPU_8bits is
    Port ( reset 		 : in  STD_LOGIC;
           clk100M 	     : in  STD_LOGIC;
		   valid_saisie  : in  STD_LOGIC;
	 	   AN            : out STD_LOGIC_VECTOR(7 downto 0);
           Sevenseg 	 : out STD_LOGIC_VECTOR (7 downto 0);
           LED 		     : out STD_LOGIC_VECTOR (7 downto 0)
			 );
end CPU_8bits;

architecture Behavioral of CPU_8bits is

component clk_wiz_0
port
 (
   clk_in           : in     std_logic;
   clk_out          : out    std_logic
  );
end component;

component CPU
    Port ( Clk 					 : in  STD_LOGIC;
	       Ce					 : in  STD_LOGIC;
           Reset 				 : in  STD_LOGIC;  
		   Adr					 : out  STD_LOGIC_VECTOR (5 downto 0);
		   data_men_in			 : out  STD_LOGIC_VECTOR (7 downto 0);
		   data_men_out			 : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component acces_carte 
    port (clk 		    : in std_logic;
	 	  reset  		: in std_logic;
          AdrLSB 		: in std_logic_vector(3 downto 0);
          AdrMSB 		: in std_logic_vector(1 downto 0);
          DataLSB		: in std_logic_vector(3 downto 0);
          DataMSB		: in std_logic_vector(3 downto 0);
          DataInMem		: in std_logic_vector(7 downto 0);
	 	  ce1s  		: out std_logic;
	      ce25M  		: out std_logic;
	 	  AN            : out std_logic_vector(7 downto 0);
	 	  Sseg 			: out std_logic_vector(7 downto 0);
	 	  LED  			: out std_logic_vector(7 downto 0);
		  LEDg 			: out std_logic);
end component;

signal Data_Mem_Unit    : STD_LOGIC_VECTOR (7 downto 0);
signal Data_Unit_Mem    : STD_LOGIC_VECTOR (7 downto 0);
signal Adr           	: STD_LOGIC_VECTOR (5 downto 0);
signal clk25M			: STD_LOGIC;
signal ce1s 			: STD_LOGIC;
signal ce25M			: STD_LOGIC;
signal LEDg 			: STD_LOGIC;
signal sig_locked   	: STD_LOGIC;

--attribute mark_debug : string;
--attribute keep : string;
--attribute mark_debug of ce25M      : signal is "true";
--attribute mark_debug of sig_locked : signal is "true";
--attribute mark_debug of reset : signal is "true";

constant zero           : STD_LOGIC := '0';

begin

Clock_IP : clk_wiz_0
  port map
   (
    clk_in  => clk100M,
    clk_out => clk25M
    );

-- Attention pour la simulation mettre  ce de UT et UC � ce25M sinon ce1s
														  
proc  				 : CPU port map ( clk25M,
                                      ce1s,
									  reset, 
									  Adr,
									  Data_Unit_Mem,
									  Data_Mem_Unit);


Peripheriques 	 : acces_carte  port map (clk25M,
										  Reset, 
										  Adr(3 downto 0), 
										  Adr(5 downto 4),
										  Data_Unit_Mem(3 downto 0), 
										  Data_Unit_Mem(7 downto 4),
										  Data_Mem_Unit,
										  ce1s,  
										  ce25M, 
										  AN,
										  Sevenseg, 
										  LED, 
										  LEDg);		
end Behavioral;

