-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 17.11.2020 01:50:57 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_Blanker is
end tb_Blanker;

architecture tb of tb_Blanker is

    component Blanker
        port (hex_in    : in std_logic_vector (15 downto 0);
              dp_in     : in std_logic_vector (5 downto 0);
              mode      : in std_logic_vector (1 downto 0);
              clk       : in std_logic;
              blank_out : out std_logic_vector (5 downto 0));
    end component;

    signal hex_in    : std_logic_vector (15 downto 0);
    signal dp_in     : std_logic_vector (5 downto 0);
    signal mode      : std_logic_vector (1 downto 0);
    signal clk       : std_logic := '0';
    signal blank_out : std_logic_vector (5 downto 0);
    constant delay: time := 40 ns;
    constant clk_delay: time :=20 ns;

begin

    dut : Blanker
    port map (hex_in    => hex_in,
              dp_in     => dp_in,
              mode      => mode,
              clk       => clk,
              blank_out => blank_out);

    clk_stim : process
    begin 
	clk <= not clk;
        wait for clk_delay;
    end process;

 
    main_stim : process
    begin
        
        -- EDIT Add stimuli here
	mode <= "00";
	hex_in <= "0000000000000000";
	dp_in <= "000000";
	wait for delay;
	mode <= "01";
	hex_in <= "0000001100110101";
	dp_in <= "000100";
	wait for delay;
	mode <= "10";
	hex_in <= "0010011100111001";
	dp_in <= "001000";
	wait for delay;
	mode <= "11";
	hex_in <= "0000100011000100";
	dp_in <= "000000";
	wait for delay;

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_Blanker of tb_Blanker is
    for tb
    end for;
end cfg_tb_Blanker;
