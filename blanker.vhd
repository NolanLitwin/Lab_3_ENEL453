-- --- blanking component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Blanker is
    Port ( hex_in                                                : in  STD_LOGIC_VECTOR (15 downto 0);
           dp_in																  : in  STD_LOGIC_VECTOR (5 downto 0);
			  mode																  : in  STD_LOGIC_VECTOR (1 downto 0);
			  clk																	  : in  STD_LOGIC;
           blank_out							                          : out STD_LOGIC_VECTOR (5 downto 0)
          ) ;
end Blanker;

architecture Behaviour of Blanker is
	begin
		process (clk)
			begin
				if rising_edge(clk) then
					blank_out (5 downto 4) <= "11"; -- first two always blanked
					if ((mode = "00")) then
						blank_out(3 downto 0) <= "0000"; -- no decimal point
					elsif (mode = "11") then
						blank_out (0) <= '0'; -- last two never blanked
						if(hex_in(15 downto 12) = "0000") then
							blank_out (3) <= '1';
							if(hex_in(11 downto 8) = "0000" ) then
								blank_out (2) <= '1';
								if(hex_in(7 downto 4) = "0000" ) then
									blank_out (1) <= '1';
								else
									blank_out (1) <= '0';
								end if;
							else
								blank_out (2) <= '0';
							end if;
						else
							blank_out (3) <= '0';
						end if;
							
							
					else
						if ((hex_in(15 downto 12) = "0000" ) and (dp_in(3) = '0')) then --if leading digit is 0, and there is no decimal point there
							blank_out (3 downto 0) <= "1000";
						else
							blank_out (3 downto 0) <= "0000";
						end if;
					end if;
				end if;
			end process;


	

end Behaviour;