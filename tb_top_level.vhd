-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 10.10.2020 01:41:22 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_top_level is
end tb_top_level;

architecture tb of tb_top_level is

    component top_level
        port (clk     : in std_logic;
              reset_n : in std_logic;
			  button2 : in std_logic;
              SW      : in std_logic_vector (9 downto 0);
              LEDR    : out std_logic_vector (9 downto 0);
              HEX0    : out std_logic_vector (7 downto 0);
              HEX1    : out std_logic_vector (7 downto 0);
              HEX2    : out std_logic_vector (7 downto 0);
              HEX3    : out std_logic_vector (7 downto 0);
              HEX4    : out std_logic_vector (7 downto 0);
              HEX5    : out std_logic_vector (7 downto 0));
    end component;

    signal clk     : std_logic := '0';
    signal reset_n : std_logic := '0';
    signal button2 : std_logic := '0';
    signal SW      : std_logic_vector (9 downto 0);
    signal LEDR    : std_logic_vector (9 downto 0);
    signal HEX0    : std_logic_vector (7 downto 0);
    signal HEX1    : std_logic_vector (7 downto 0);
    signal HEX2    : std_logic_vector (7 downto 0);
    signal HEX3    : std_logic_vector (7 downto 0);
    signal HEX4    : std_logic_vector (7 downto 0);
    signal HEX5    : std_logic_vector (7 downto 0);
    
    constant time_delay       : time := 40 ms;
    constant clock_delay      : time := 20 ns;
begin

    dut : top_level
    port map (clk     => clk,
              reset_n => reset_n,
	      button2 => button2, 
              SW      => SW,
              LEDR    => LEDR,
              HEX0    => HEX0,
              HEX1    => HEX1,
              HEX2    => HEX2,
              HEX3    => HEX3,
              HEX4    => HEX4,
              HEX5    => HEX5);

    clk_stim : process
    begin
      clk <= not clk; -- this process switches clock signal every 20ns
      wait for clock_delay;
    end process;

      
    main_stim : process -- this process cycles through a variety of possible values for the switches,
    begin               -- will display each in both display modes because mode_stim runs concurrently

		-- initializing all inputs to zero
		SW(9 downto 0) <= "0000000000";
		reset_n <= '1';
		button2 <= '1';
		wait for time_delay;
		--setting mux selector to display input in  dec
		SW(9 downto 8) <= "00";
		wait for time_delay;
		--setting input to 0x80 or 0d128
		SW(7 downto 0) <= "01000000";
		wait for time_delay;
		--resetting with decimal input displayed
		reset_n <= '0';
		wait for time_delay;
		reset_n <= '1';
		wait for time_delay;
		--setting mux selector to display input in hex
		SW(9 downto 8) <= "01";
		wait for time_delay;
		--Storing our current value in the savereg
		button2 <= '0';
		wait for time_delay;
		button2 <= '1';
		wait for time_delay;
		--Changing our input value (should be displayed in hex)
		SW(7 downto 0) <= "11111111";
		wait for time_delay;
		--setting mux selector to display stored value
		SW(9 downto 8) <= "10";
		wait for time_delay;
		--resetting stored value
		reset_n <= '0';
		wait for time_delay;
		reset_n <= '1';
		wait for time_delay;
		--displaying 5a5a in4
		SW(9 downto 8) <= "11";
		wait for time_delay;
		
      wait;
      
    end process;

end tb;
