library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
 
entity top_level is
    Port ( clk                           : in  STD_LOGIC;
           reset_n                       : in  STD_LOGIC;
			  button2							  : in  STD_LOGIC;
			  SW                            : in  STD_LOGIC_VECTOR (9 downto 0);
           LEDR                          : out STD_LOGIC_VECTOR (9 downto 0);
           HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 : out STD_LOGIC_VECTOR (7 downto 0)
          );
           
end top_level;


architecture Behavioral of top_level is

Signal Num_Hex0, Num_Hex1, Num_Hex2, Num_Hex3, Num_Hex4, Num_Hex5 : STD_LOGIC_VECTOR (3 downto 0):= (others=>'0');
Signal DP_in, Blank:  STD_LOGIC_VECTOR (5 downto 0);
Signal voltage, distance: STD_LOGIC_VECTOR (12 downto 0);
Signal ADC_out:		STD_LOGIC_VECTOR(11 downto 0);
Signal enable:			 STD_LOGIC;

--Added ports for multiplexer
signal in1, in2, in3, in4, mux_out, output, switch_inputs, ADC_out_ext:		 STD_LOGIC_VECTOR (15 downto 0);

Component SevenSegment is
    Port( Num_Hex0,Num_Hex1,Num_Hex2,Num_Hex3,Num_Hex4,Num_Hex5 : in  STD_LOGIC_VECTOR (3 downto 0);
          Hex0,Hex1,Hex2,Hex3,Hex4,Hex5                         : out STD_LOGIC_VECTOR (7 downto 0);
          DP_in,Blank                                           : in  STD_LOGIC_VECTOR (5 downto 0)
			);
End Component ;

--Added Multiplexer
Component MUX4TO1 is
	Port(
		in1	  : IN  STD_LOGIC_VECTOR(15 downto 0);							 --input1 to Multiplexer
		in2	  : IN  STD_LOGIC_VECTOR(15 downto 0);							 --input2 to Multiplexer
		in3	  : IN  STD_LOGIC_VECTOR(15 downto 0);	
		in4	  : IN  STD_LOGIC_VECTOR(15 downto 0);	
		s		  : IN  STD_LOGIC_VECTOR( 1 downto 0);							 
		mux_out : OUT STD_LOGIC_VECTOR(15 downto 0)						 --output from Multiplexer
		);
End Component;
--End of Multiplexer

--Added ADC
Component ADC_Data is
	Port(
		clk		: IN STD_LOGIC;
		reset_n	: IN STD_LOGIC;
		ADC_raw	: OUT STD_LOGIC_VECTOR(11 downto 0);
		ADC_out	: OUT STD_LOGIC_VECTOR(11 downto 0);
		voltage	: OUT STD_LOGIC_VECTOR(12 downto 0);
		distance	: OUT STD_LOGIC_VECTOR(12 downto 0)
		);
End Component;
--End of ADC

Component binary_bcd IS
   PORT(
      clk     : IN  STD_LOGIC;                      --system clock
      reset_n : IN  STD_LOGIC;                      --active low asynchronus reset_n
      binary  : IN  STD_LOGIC_VECTOR(12 DOWNTO 0);  --binary number to convert
      bcd     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)   --resulting BCD number
		);           
END Component;

Component SYNC is
	PORT(
		clk	  : in  std_logic;
		in1     : in  std_logic_vector(9 downto 0);
		out1	  : out std_logic_vector(9 downto 0)
		);
End Component;

Component SaveReg is
	PORT(
		clk	  : in  std_logic;
		enable  : in  std_logic;
		reset_n : in  std_logic;
		toSave  : in  std_logic_vector(15 downto 0);
		output  : out std_logic_vector(15 downto 0)
		);
End Component;

Component debounce is
	PORT(
	 clk     : IN  STD_LOGIC;  --input clock
    reset_n : IN  STD_LOGIC;  --asynchronous active low reset
    button  : IN  STD_LOGIC;  --input signal to be debounced
    result  : OUT STD_LOGIC   --debounced signal
	);
End Component;

begin
   Num_Hex0 <= output(3  downto  0); 
   Num_Hex1 <= output(7  downto  4);
   Num_Hex2 <= output(11 downto  8);
   Num_Hex3 <= output(15 downto 12);
   Num_Hex4 <= "0000";
   Num_Hex5 <= "0000";
   --DP_in    <= "000000"; -- position of the decimal point in the display (1=LED on,0=LED off)
   Blank    <= "110000"; -- blank the 2 MSB 7-segment displays (1=7-seg display off, 0=7-seg display on)

                
SevenSegment_ins: SevenSegment  

                  PORT MAP( Num_Hex0 => Num_Hex0,
                            Num_Hex1 => Num_Hex1,
                            Num_Hex2 => Num_Hex2,
                            Num_Hex3 => Num_Hex3,
                            Num_Hex4 => Num_Hex4,
                            Num_Hex5 => Num_Hex5,
                            Hex0     => Hex0,
                            Hex1     => Hex1,
                            Hex2     => Hex2,
                            Hex3     => Hex3,
                            Hex4     => Hex4,
                            Hex5     => Hex5,
                            DP_in    => DP_in,
									 Blank    => Blank
                          );
                                     
 
switch_inputs <= "00000000" & SW(7 downto 0);
ADC_out_ext   <= "0000" & ADC_out(11 downto 0);

binary_bcd_ins: binary_bcd                               
   PORT MAP(
      clk      => clk,                          
      reset_n  => reset_n,                                 
      binary   => voltage,    
      bcd      => in3        
      );
		
binary_bcd_ins2: binary_bcd
	PORT MAP(
		clk      => clk,                          
      reset_n  => reset_n,                                 
      binary   => distance,    
      bcd      => in2
		);
		
ADC_Data_ins: ADC_Data
	PORT MAP(
		clk		=> clk,
		reset_n	=> reset_n,
		ADC_out 	=>	ADC_out,
		voltage	=> voltage,
		distance	=> distance
		);
		
SYNC_ins	  : SYNC
	PORT MAP(
		clk => clk,
		in1 => sw,
		out1 => LEDR
	
	);

MUX4TO1_ins: MUX4TO1
	PORT MAP(
		in1 => switch_inputs,
		in2 => in2,
		in3 => in3,
		in4 => ADC_out_ext,
		s	 => sw(9 downto 8),
		mux_out => mux_out
		);

MUX4TO1_ins_DP: MUX4TO1
	PORT MAP(
		in1(5 downto 0)		=> "000000",
		in2(5 downto 0) 		=> "000100",
		in3(5 downto 0) 		=> "001000",
		in4(5 downto 0) 		=> "000000",
		s 					 		=> sw(9 downto 8),
		mux_out(5 downto 0)	=> DP_in
		);
		
SaveReg_ins: SaveReg	
	PORT MAP(
		clk => clk,
		enable => enable,
		reset_n => reset_n,
		toSave => mux_out,
		output => output
		);
		
debounce_ins: debounce
	PORT MAP(
		clk => clk,
		reset_n => reset_n,
		button => button2,
		result => enable
	);
	

end Behavioral;