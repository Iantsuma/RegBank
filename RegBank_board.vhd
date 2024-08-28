--GRUPO
--ANDRÉ PADUA		22010866
--IAN MAEDA			19276369
--JOSÉ PASCOAL		22002728
--MURILO CROCE		22002785
--JHONATHAN PERINI 	19663533
library ieee;
use ieee.std_logic_1164.all;


entity RegBank_board IS

	port (
			KEY: in std_logic_vector(3 downto 0);
			LEDR: out std_logic_vector(17 downto 0);
			SW: in std_logic_vector(17 downto 0)
			);
end RegBank_board;

architecture RegBank_board of RegBank_board IS

signal clk : STD_LOGIC;
signal reset : STD_LOGIC;
signal rdAddr1 : STD_LOGIC_VECTOR(4 downto 0);
signal rdAddr2 : STD_LOGIC_VECTOR(4 downto 0);
signal wrAddr : STD_LOGIC_VECTOR(4 downto 0);
signal wData :std_logic_vector(31 downto 0);
signal we:  std_logic;
signal rdData1:std_logic_vector(31 downto 0);
signal rdData2:std_logic_vector(31 downto 0);

component RegBank IS

	port(
		clk     : in  std_logic;
        reset   : in  std_logic;
        rdAddr1 : in  std_logic_vector(4 downto 0);
        rdAddr2 : in  std_logic_vector(4 downto 0);
        wrAddr  : in  std_logic_vector(4 downto 0);
        wData   : in  std_logic_vector(31 downto 0);
        we      : in  std_logic;
        rdData1 : out std_logic_vector(31 downto 0);
        rdData2 : out std_logic_vector(31 downto 0)
	);
	
end component RegBank;

begin


	rdAddr1 <= (SW(14 downto 10));
	rdAddr2 <= (SW(9 downto 5));
	wrAddr <= (SW(4 downto 0));
	wData <= "00000000000000000000000000000" & (SW(17 downto 15));
	rdData1 <= "0000000000000000000000000" & (SW(13 downto 7));             
	rdData2 <= "0000000000000000000000000" & (SW(6 downto 0));                
	
	clk <= KEY(3);
	reset <= KEY(2);
	we <= KEY(1);

	
	

	projeto: entity work.RegBank port map(
		clk => clk,
		reset => reset,
		rdAddr1 => rdAddr1,
		rdAddr2 => rdAddr2,
		wrAddr => wrAddr,
		wData => wData,
		we => we,
		rdData1 => rdData1,
		rdData2 => rdData2
		
	);


	

	LEDR(7 downto 5) <= rdData1(2 downto 0);
	LEDR(2 downto 0) <= rdData2(2 downto 0);

end architecture;