library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SYNC is
port ( clk		: in  std_logic;
		 in1	   : in  std_logic_vector(9  downto 0);
		 
       out1		: out std_logic_vector(9 downto 0)
      );
end SYNC; -- can also be written as "end entity;" or just "end;"

architecture BEHAVIOR of SYNC is
signal E	: std_logic_vector(9 downto 0);
	begin
		process (clk)
			begin
			
				if rising_edge(clk) then
					out1 <= E;
					E <= in1;
					
				end if;
		end process;

end BEHAVIOR; -- can also be written as "end;"
