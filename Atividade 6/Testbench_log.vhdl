library ieee;
use ieee.numeric_bit.all;

entity testbench is
end testbench;

-- Complete no espaço os sinais e componentes a serem utilizados

architecture beh of testbench is
    component log 
    port (
        clock, inicio : in bit;
        x : in bit_vector(7 downto 0);
        R : out bit_vector(7 downto 0);
        fim : out bit
    );
   end component;

   Signal clk, run, Keep := '0': bit
   signal clk_in, inicio_in : bit;
   signal x_in: bit_vector(7 downto 0);
   signal R_in: bit_vector(7 downto 0);
   signal fim_in : bit;
    -- Complete no espaço para gerar o clock
    -- Depois, complete no espaço para que o DUT seja instanciado

begin
    clk <= (not clk) and run after 10 ns;

    DUT: logx
    port map (
        Clock => clk_in,
        inicio => inicio_in,
        x => x_in,
        R => r_in,
        Fim => fim_in,
    );

    process
    begin
        run <= '1'; 
        x <= "11110000"; -- indicando a entrada do circuito log
        inicio <= '1';  
        wait for 10 ns ;  
        inicio <= '0';
        
        assert R = 01001010 report "Teste 1 - Incorreto" severity error;
        assert false report "Teste Concluido" severity note;

        wait until fim = '1';
        run <= '0';
        wait;
    end process;
end beh;
