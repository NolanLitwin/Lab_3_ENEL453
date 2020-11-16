library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX4TO1 is
port ( in1     : in  std_logic_vector(15 downto 0);
       in2     : in  std_logic_vector(15 downto 0);
		 in3		: in 	std_logic_vector(15 downto 0);
		 in4		: in 	std_logic_vector(15 downto 0);
       s       : in  std_logic_vector(1  downto 0);
       mux_out : out std_logic_vector(15 downto 0) -- notice no semi-colon 
      );
end MUX4TO1; -- can also be written as "end entity;" or just "end;"

architecture BEHAVIOR of MUX4TO1 is
	begin
		with s select
			mux_out <= in1 when "00", -- when s is '0' then mux_out becomes in1
			           in2 when "01",
						  in3 when "10",
						  in4 when others;

end BEHAVIOR; -- can also be written as "end;"
