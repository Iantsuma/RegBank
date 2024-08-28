--GRUPO
--ANDRÉ PADUA		22010866
--IAN MAEDA			19276369
--JOSÉ PASCOAL		22002728
--MURILO CROCE		22002785
--JHONATHAN PERINI 	19663533

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
entity RegBank is
    Port (
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
end RegBank;

architecture Behavioral of RegBank is
    type reg_array is array (31 downto 0) of std_logic_vector(31 downto 0);
    signal registers : reg_array := (others => (others => '0'));
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                registers <= (others => (others => '0'));
            elsif we = '1' then
                registers(to_integer(unsigned(wrAddr))) <= wData;
            end if;
        end if;
    end process;

    rdData1 <= registers(to_integer(unsigned(rdAddr1)));
    rdData2 <= registers(to_integer(unsigned(rdAddr2)));

end Behavioral;
