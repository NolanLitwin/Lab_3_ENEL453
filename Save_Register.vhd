library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SaveReg is
port ( clk		: in  std_logic;
		 enable	: in  std_logic;
		 reset_n : in  std_logic;
		 toSave  : in  std_logic_vector(15 downto 0);
       output  : out std_logic_vector(15 downto 0)
      );
end SaveReg; -- can also be written as "end entity;" or just "end;"

architecture BEHAVIOR of SaveReg is
signal saved : std_logic_vector(15 downto 0);
	
	begin
		output <= saved;
		process (clk, reset_n)
			begin
				if (reset_n = '0') then
					saved <= (others => '0');
				elsif rising_edge(clk) and (enable = '1') then		--enable has been inverted for lab 3
					saved <= toSave;
				end if;
				
		end process;
		



end BEHAVIOR; -- can also be written as "end;"
