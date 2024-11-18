library IEEE;
use ieee.std.logic
entity memoriaInstrucoes is
    generic (
        datFileName : string := "conteudo_memInstr_af11_p1e5_carga.dat"
    );
    port (
        addr : in bit_vector(7 downto 0);
        data : out bit_vector(31 downto 0)
    );
end entity memoriaInstrucoes;

entity memoriaDados is
    generic (
        datFileName : string := "conteudo_memDados_af11_p1e5_carga.dat"
    );
    port (
        clk     : in bit;
        wr      : in bit;
        addr    : in bit_vector(7 downto 0);
        data_i  : in bit_vector(63 downto 0);
        data_o  : out bit_vector(63 downto 0)
    );
end entity memoriaDados;
