library ieee;
use ieee.numeric_bit.all;

entity testbench is
end testbench;

-- Complete no espaço os sinais e componentes a serem utilizados

architecture beh of testbench is
    constant clockPeriod : time := 10 ns;
    
    component log 
    port (
        clock, inicio : in bit;
        x : in bit_vector(7 downto 0);
        R : out bit_vector(7 downto 0);
        fim : out bit
    );
   end component;

   signal clk_in, inicio_in : bit;
   signal x_in: bit_vector(7 downto 0);
   signal R_in: bit_vector(7 downto 0);
   signal fim_in : bit;
    -- Complete no espaço para gerar o clock
    -- Depois, complete no espaço para que o DUT seja instanciado

begin
    clk <= '1' after 10 ns;
    clock <= not clock and keep after clockPeriod/2; -- não sei calcular clock

    DUT: multiplicador
    port map (
        Clock => clk_in,
        inicio => inicio_in,
        x => x_in,
        R => r_in,
        Fim => fim_in,
    );

    process
    begin
        x <= "11110000";
        inicio <= '1';  
        wait for clk_period;  
        inicio <= '0';
        wait until fim = '1';
        Assert R = 01001010
            Report "Teste 1 - incorreto" severity error;
        
        Assert false report "Teste concluido" severity note;
        run <= '1'; -- não sei onde aplicar esses módulos de run
        run <= '0';
        wait;
    end process;
end beh;
