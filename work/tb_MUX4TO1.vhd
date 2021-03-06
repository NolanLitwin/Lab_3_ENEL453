-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net

library ieee;
use ieee.std_logic_1164.all;

entity tb_MUX4TO1 is
end tb_MUX4TO1;

architecture tb of tb_MUX4TO1 is

    component MUX4TO1
        port (in1     : in std_logic_vector (15 downto 0);
              in2     : in std_logic_vector (15 downto 0);
              in3     : in std_logic_vector (15 downto 0);
              in4     : in std_logic_vector (15 downto 0);
              s       : in std_logic_vector (1  downto 0);
              mux_out : out std_logic_vector (15 downto 0));
    end component;

    signal in1     : std_logic_vector (15 downto 0);
    signal in2     : std_logic_vector (15 downto 0);
    signal in3     : std_logic_vector (15 downto 0);
    signal in4     : std_logic_vector (15 downto 0);
    signal s       : std_logic_vector (1  downto 0);
    signal mux_out : std_logic_vector (15 downto 0);

    constant time_delay : time := 20 ns; -- EDIT Put right period here

begin

    dut : MUX4TO1
    port map (in1     => in1,
              in2     => in2,
              in3     => in3,
              in4     => in4,
              s       => s,
              mux_out => mux_out);

    s_stim : process
    begin
      s (1 downto 0) <= "00";
      wait for time_delay;
      s (1 downto 0) <= "01";
      wait for time_delay;
      s (1 downto 0) <= "10";
      wait for time_delay;
      s (1 downto 0) <= "11";
      wait for time_delay;
    end process;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        in1 <= (others => '0');
        in2 <= (others => '0');
        in3 <= (others => '0');
        in4 <= (others => '0');
	
	in1(15 downto 0) <= "0000000000000000";
        wait for time_delay*4;
        in2(15 downto 0) <= "1111111111111111";
        wait for time_delay*4;
	in3(15 downto 0) <= "0000000011111111";
        wait for time_delay*4;
	in4(15 downto 0) <= "1111111100000000";
        wait for time_delay*4;

	in1(15 downto 0) <= "1111111111111111";
        wait for time_delay*4;
        in2(15 downto 0) <= "0000000000000000";
        wait for time_delay*4;
	in3(15 downto 0) <= "1111111100000000";
        wait for time_delay*4;
	in4(15 downto 0) <= "0000000011111111";
        wait for time_delay*4;
	

	in1(15 downto 0) <= "0000000011111111";
        wait for time_delay*4;
        in2(15 downto 0) <= "1111111100000000";
        wait for time_delay*4;
	in3(15 downto 0) <= "0000000000000000";
        wait for time_delay*4;
	in4(15 downto 0) <= "1111111111111111";
        wait for time_delay*4;


	in1(15 downto 0) <= "1111111100000000";
        wait for time_delay*4;
        in2(15 downto 0) <= "0000000011111111";
        wait for time_delay*4;
	in3(15 downto 0) <= "1111111111111111";
        wait for time_delay*4;
	in4(15 downto 0) <= "0000000000000000";
        wait for time_delay*4;

        wait;
    end process;

end tb;
