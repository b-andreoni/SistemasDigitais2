entity onescounter_uc is
port (
clock : in bit ;
reset : in bit ;
start : in bit ;
data0 : in bit ;
zero : in bit ;
zera : out bit ;
conta : out bit;
carrega : out bit;
desloca : out bit;
done : out bit;
) ;
end entity;

architecture fsm of onescounter_uc is
    type estado_t is (S0, S1, S2, S3, S4, S5);
    signal PE, EA: estado_t;
begin
    sincronoprocess: process(clock, reset, PE)
    begin
        if (reset = '1') then
            EA <= S0;
        elsif (rising_edge(clock)) then
            EA <= PE;
        end if;
    end process sincronoprocess;

    combinatorioprocess: process(EA, start, data0, zero)
    begin
        case EA is
            when S0 =>
                if start = '1' then
                    PE <= S1;
                else
                    PE <= S0;
                end if;
                done <= '0';
                zera <= '0';
                conta <= '0';
                carrega <= '0';
                desloca <= '0';
                registra <= '0';
            when S1 =>
                PE <= S2;
                done <= '0';
                zera <= '1';
                carrega <= '1';
                conta <= '0';
                desloca <= '0';
                registra <= '0';
            when S2 =>
                if data0 = '1' then
                    PE <= S3;
                else
                    PE <= S4;
                end if;
            When S3 => 
                PE <= S4;
                done <= '0';
                zera <= '0';
                carrega <= '0';
                conta <= '1';
                desloca <= '0';
                registra <= '0';
            When S4 => 
            if Zero = '1' then
                PE <= S5;
            else
                PE <= S2;
            end if;
                done <= '0';
                zera <= '0';
                carrega <= '0';
                conta <= '0';
                desloca <= '1';
                registra <= '0';  
            when S5 =>
                PE <= S0; 
        end case;
    end process combinatorioprocess;
end architecture;
