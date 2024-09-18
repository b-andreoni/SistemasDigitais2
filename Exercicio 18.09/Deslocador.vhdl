library ieee;

entity deslocador_nis
generic (
constant N : integer := 4 
) ;
port (
clock: in bit ;
reset : in bit ;
carrega : in bit ;
desloca : in bit ;
entrada_serial : in bit ;
dados : in bit_vector (N=1 downto 0 ) ;
saida : out bit_vector (N=1 downto 0 )
) ;
end entity deslocador_n ;