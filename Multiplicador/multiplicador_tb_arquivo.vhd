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

    gerador_estimulos: process is
        
        file tb_file : text open read_mode is "multiplicador_tb.dat";
        variable tb_line: line;
        variable space: character;
        variable VaRead, VbRead: bit_vector(3 downto 0);
        variable result_out_read: bit_vector(7 downto 0);
        variable carry_esperado: bit;
        
    begin
        rst_in <= '1'; start_in <= '0';
        wait for 
        rst_in <= '0';

        while not endfile(tb_file) loop  -- Enquanto não chegar no final do arquivo ...
        readline(tb_file, tb_line);  -- Lê a próxima linha
        read(tb_line, VaRead);   -- Da linha que foi lida, lê o primeiro parâmetro (op1)
        read(tb_line, space); -- Lê o espaço após o primeiro parâmetro (separador)
        read(tb_line, VbRead);   -- Da linha que foi lida, lê o segundo parâmetro (op2)
        read(tb_line, space); -- Lê o próximo espaço usado como separador
        read(tb_line, result_out_read);  -- Da linha que foi lida, lê o terceiro parâmetro (soma_esperada)
        
        Va_in <= VaRead;
        Vb_in <= VbRead; 
        wait for 10 ns;

        assert result_out = result_out_read report "Multiplicação " & integer'image(to_integer(unsigned(op1))) & " + " & integer'image(to_integer(unsigned(op2))) severity error;
       
     end loop;

     -- Informa fim do teste
     assert false report "Teste concluido." severity note;	  
     wait;  -- pára a execução do simulador, caso contrário este process é reexecutado indefinidamente.
  end process;   


    end Multiplicador_Read;