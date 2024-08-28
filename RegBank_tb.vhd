library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity regbank_tb is
end regbank_tb;

architecture Behavioral of regbank_tb is

    -- Sinais
    signal clk     : std_logic := '0';
    signal reset   : std_logic := '0';
    signal rdAddr1 : std_logic_vector(4 downto 0);
    signal rdAddr2 : std_logic_vector(4 downto 0);
    signal wrAddr  : std_logic_vector(4 downto 0);
    signal wData   : std_logic_vector(31 downto 0);
    signal we      : std_logic;
    signal rdData1 : std_logic_vector(31 downto 0);
    signal rdData2 : std_logic_vector(31 downto 0);

    constant clk_period : time := 10 ns;

begin

   
    uut: entity work.RegBank
        port map (
            clk     => clk,
            reset   => reset,
            rdAddr1 => rdAddr1,
            rdAddr2 => rdAddr2,
            wrAddr  => wrAddr,
            wData   => wData,
            we      => we,
            rdData1 => rdData1,
            rdData2 => rdData2
        );

    -- Geração do sinal de clock
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    stimulus: process
    begin
        -- reset
        reset <= '1';
        wait for clk_period*2;
        reset <= '0';
        
        -- escrita e leitura
        wrAddr <= "00001"; -- Registrador 1
        wData <= X"AAAAAAAA";
        we <= '1';
        wait for clk_period;
        we <= '0';
        
        rdAddr1 <= "00001"; -- Leitura do Registrador 1
        wait for clk_period;
        assert rdData1 = X"AAAAAAAA"
        report "Erro: A leitura do Registrador 1 falhou!" severity error;
        
        -- escrita em outro registrador
        wrAddr <= "00010"; -- Registrador 2
        wData <= X"55555555";
        we <= '1';
        wait for clk_period;
        we <= '0';
        
        rdAddr2 <= "00010"; -- Leitura do Registrador 2
        wait for clk_period;
        assert rdData2 = X"55555555"
        report "Erro: A leitura do Registrador 2 falhou!" severity error;

        -- Teste de reset após escrita
        reset <= '1';
        wait for clk_period*2;
        reset <= '0';

        rdAddr1 <= "00001";
        rdAddr2 <= "00010";
        wait for clk_period;
        assert rdData1 = X"00000000" and rdData2 = X"00000000"
        report "Erro: Reset não funcionou corretamente!" severity error;

        wait;
    end process;

end Behavioral;
