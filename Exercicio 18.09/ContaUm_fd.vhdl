
entity onescounter_fd is
port (
clock : in bit;
reset : in bit ;
inport : in bit_vector (14 downto 0) ;
zera : in bit;
conta : in bit;
carrega : in bit;
desloca : in bit;
registra : in bit;
outport : out bit_vector ( 3 downto 0 ) ;
data0 : out bit;
zero : out bit;
) ;
end entity ;

architecture estrutural of onescounter_fd is

component contador4 port ( . . . ) ; end component ;
component deslocador_n generic ( . . . ) ; 
port ( . . . ) ; end component ;

signal s_data : bit_vector ( 14 downto 0 ) ;
begin
DESL : deslocador_n generic map ( . . . ) port map( c l o c k=>c l o c k , . . . ) ;
CONT : contador4 port map ( . . . ) ;
zero <= 
data0 <= s_data ( 0 ) ;
end architecture ;
