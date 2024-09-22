library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Contador_tb  is
end entity Contador_tb ;

architecture sim of Contador_tb is
    component ContaUm
        port (
            clock   : in bit;
            reset   : in bit;
            start   : in bit;
            inport  : in bit_vector(14 downto 0);
            outport : out bit_vector(3 downto 0);
            done    : out bit
        );
    end component;

    signal clock   : bit := '0';
    signal reset   : bit := '0';
    signal start   : bit := '0';
    signal inport  : bit_vector(14 downto 0) := (others => '0');
    signal outport : bit_vector(3 downto 0);
    signal done    : bit;

    constant clk_period : time := 10 ns;

begin
    uut: ContaUm
        port map (
            clock   => clock,
            reset   => reset,
            start   => start,
            inport  => inport,
            outport => outport,
            done    => done
        );

    clk_process : process
    begin
        clock <= '0';
        wait for clk_period / 2;
        clock <= '1';
        wait for clk_period / 2;
    end process clk_process;

    stim_process : process
    begin
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 20 ns;

        start <= '1';
        inport <= (0 => '0', 1 => '0', 2 => '0', 3 => '0', 4 => '0', 5 => '0', 6 => '0', 7 => '0',
                   8 => '0', 9 => '0', 10 => '0', 11 => '0', 12 => '0', 13 => '0', 14 => '0');
        wait for 20 ns;
        start <= '0';
        wait for 20 ns;

        assert outport = "0000" report "Erro: Saída deve ser 0 após entrada de zeros." severity error;

        start <= '1';
        inport <= (0 => '1', 1 => '1', 2 => '1', 3 => '1', 4 => '1', 5 => '1', 6 => '1', 7 => '1',
                   8 => '1', 9 => '1', 10 => '1', 11 => '1', 12 => '1', 13 => '1', 14 => '1');
        wait for 20 ns;
        start <= '0';
        wait for 20 ns;

        assert outport = "1111" report "Erro: Saída deve ser 15 após entrada de uns." severity error;

        start <= '1';
        inport <= (0 => '1', 1 => '0', 2 => '1', 3 => '0', 4 => '1', 5 => '0', 6 => '1', 7 => '0',
                   8 => '1', 9 => '0', 10 => '1', 11 => '0', 12 => '1', 13 => '0', 14 => '1');
        wait for 20 ns;
        start <= '0';
        wait for 20 ns;

        assert outport /= "0000" report "Erro: Saída não deve ser zero para entrada mista." severity warning;

        start <= '1';
        inport <= (0 => '0', 1 => '0', 2 => '0', 3 => '0', 4 => '0', 5 => '0', 6 => '0', 7 => '0',
                   8 => '0', 9 => '0', 10 => '0', 11 => '0', 12 => '0', 13 => '0', 14 => '1');
        wait for clk_period;
        start <= '0';
        wait for clk_period;

        start <= '1';
        inport <= (0 => '0', 1 => '0', 2 => '0', 3 => '0', 4 => '0', 5 => '0', 6 => '0', 7 => '0',
                   8 => '0', 9 => '0', 10 => '0', 11 => '0', 12 => '0', 13 => '0', 14 => '1');
        wait for 50 ns;
        start <= '0';

        wait until done = '1';
        assert done = '1' report "Erro: O sinal done não foi ativado corretamente." severity error;

        wait;
    end process stim_process;

end architecture sim;
