library ieee;
use ieee.numeric_bit.all;
use std.textio.all;

entity multiplicador_tb_arquivo is
end multiplicador_tb_arquivo;

architecture Multiplicador_Read of multiplicador_tb_arquivo is

   -- Declara o componente do DUT
   component multiplicador 
    port (
       Clock:    in  bit;
       Reset:    in  bit;
       Start:    in  bit;
       Va,Vb:    in  bit_vector(3 downto 0);
       Vresult:  out bit_vector(7 downto 0);
       Ready:    out bit
    );
 end component;

 signal clk_in: bit := '0';
 signal rst_in, start_in, ready_out: bit := '0';
 signal va_in, vb_in: bit_vector(3 downto 0);
 signal result_out: bit_vector(7 downto 0);

begin

    gerador_estimulos: process
        file tb_file : text open read_mode is "multiplicador_tb.dat";
        variable tb_line: line;
        variable space: character;
        variable VaRead, VbRead: bit_vector(3 downto 0);
        variable result_out_read: bit_vector(7 downto 0);
        variable carry_esperado: bit;
    begin
        rst_in <= '1';
        start_in <= '0';
        wait for 10 ns;
        rst_in <= '0';

        while not endfile(tb_file) loop
            readline(tb_file, tb_line);
            read(tb_line, VaRead);
            read(tb_line, space);
            read(tb_line, VbRead);
            read(tb_line, space);
            read(tb_line, result_out_read);
        
            va_in <= VaRead;
            vb_in <= VbRead; 
            wait for 10 ns;

            assert result_out /= result_out_read
                report "Multiplicacaoo " & integer'image(to_integer(unsigned(VaRead))) & " * " & integer'image(to_integer(unsigned(VbRead))) severity error;
        end loop;

        assert false report "Teste concluido." severity note;	  
        wait;  -- pára a execução do simulador
    end process;

end Multiplicador_Read;
