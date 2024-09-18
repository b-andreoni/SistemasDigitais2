library ieee;

entity onescounter is
port (
clock : in bit ;
reset : in bit ;
start : in bit ;
inport : in bit_vector (14 downto 0 );
outport : out bit_vector (3 downto 0 );
done : out bit
) ;
end entity ;