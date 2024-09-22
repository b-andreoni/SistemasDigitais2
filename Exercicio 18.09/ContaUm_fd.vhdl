library ieee;
use ieee.numeric_bit.all;

entity ContaUm_fd is
    port (
        clock    : in bit;
        reset    : in bit;
        inport   : in bit_vector(14 downto 0); 
        zera     : in bit;
        conta    : in bit;
        carrega  : in bit;
        desloca  : in bit;
        registra : in bit;
        outport  : out bit_vector(3 downto 0);
        data0    : out bit;
        zero     : out bit
    );
end entity;


architecture estrutural of ContaUm_fd is
    component contador4
        port ( 
            clock: in bit; 
            zera: in bit; 
            conta: in bit; 
            Q: out bit_vector(3 downto 0); 
            fim: out bit 
        );
    end component;

    component deslocador_n
        port ( 
            clock: in bit; 
            reset: in bit; 
            carrega: in bit; 
            desloca: in bit; 
            entrada_serial: in bit;  
            dados: in bit_vector(14 downto 0);  
            saida: out bit_vector(14 downto 0)  
        );
    end component;

    signal s_data : bit_vector(14 downto 0); 
    signal entrada_serial_signal : bit := '0';  

begin
    DESL: deslocador_n port map(
        clock => clock,
        reset => reset,
        carrega => carrega,
        desloca => desloca,
        entrada_serial => entrada_serial_signal,
        dados => (others => '0'),  
        saida => s_data
    );

    CONT: contador4 port map(
        clock => clock,
        zera => zera,
        conta => conta,
        Q => outport,
        fim => zero
    );

    data0 <= s_data(0);
end architecture;
