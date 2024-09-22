library ieee;
use ieee.numeric_bit.all;
entity onescounter_fd is
    port (
        clock : in bit;
        reset : in bit;
        inport : in bit;  -- Changed to a single bit
        zera : in bit;
        conta : in bit;
        carrega : in bit;
        desloca : in bit;
        registra : in bit;
        outport : out bit_vector(3 downto 0);
        data0 : out bit;  -- Output port
        zero : out bit
    );
end entity;

architecture estrutural of onescounter_fd is
    component contador4
        port ( 
            clock: in bit; 
            zera: in bit; 
            conta: in bit; 
            Q: out bit_vector(3 downto 0); 
            fim: out bit );
    end component;

    component deslocador_n
        port ( 
            clock: in bit; 
            reset: in bit; 
            carrega: in bit; 
            desloca: in bit; 
            entrada_serial: in bit;  -- Changed to a single bit
            dados: in bit;  -- Changed to a single bit
            saida: out bit  -- Changed to a single bit
        );
    end component;

    signal s_data : bit;  -- Changed to a single bit
    signal entrada_serial_signal : bit;  -- Internal signal for entrada_serial

begin
    -- Connect entrada_serial_signal to a logic source
    -- You can connect it to another internal signal or set it to a default value.
    entrada_serial_signal <= '0';  -- Default value for illustration; modify as needed.

    DESL: deslocador_n port map(
        clock => clock,
        reset => reset,
        carrega => carrega,
        desloca => desloca,
        entrada_serial => entrada_serial_signal,
        dados => inport,
        saida => s_data
    );

    CONT: contador4 port map(
        clock => clock,
        zera => zera,
        conta => conta,
        Q => outport,
        fim => zero
    );

    data0 <= s_data;  -- Output the value of s_data
end architecture;
