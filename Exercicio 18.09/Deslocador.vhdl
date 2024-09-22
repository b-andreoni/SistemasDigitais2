library ieee;

entity deslocador_n is
port (
clock: in bit ;
reset : in bit ;
carrega : in bit ;
desloca : in bit ;
entrada_serial : in bit ;
dados : in bit_vector (14 downto 0 ) ;
saida : out bit_vector (14 downto 0 )
) ;
end entity deslocador_n ;

architecture behavior of deslocador_n is
    signal reg : bit_vector(14 downto 0);
begin
    process(clock, reset)
    begin
        if reset = '1' then
           reg <= (others => '0');
        elsif rising_edge(clock) then
            if carrega = '1' then
                reg <= dados;
            elsif desloca = '1' then
                reg(14 downto 1) <= reg(13 downto 0); -- Desloca para a direita
                reg(0) <= '0'; 
            end if;
        end if;
    end process;
      saida <= reg;
end architecture behavior;
