library IEEE;
use IEEE.std_logic_1164.all;

entity contador4 is
    port (
        clock : in bit;
        zera : in bit;
        conta : in bit;
        Q : out bit_vector (3 downto 0);
        fim : out bit
    );
end entity contador4;

architecture counter of contador4 is
    signal Q0, Q1, Q2, Q3 : bit := '0';
    signal clock_prev : bit := '0';
begin
    process(clock, zera)
    begin
        if (zera = '1') then
            Q0 <= '0';
            Q1 <= '0';
            Q2 <= '0';
            Q3 <= '0';  -- Reseta o contador
        elsif (clock = '1' and clock_prev = '0') then
            if (conta = '1') then
                -- Incrementa manualmente
                if (Q3 = '0' and Q2 = '0' and Q1 = '0' and Q0 = '0') then
                    Q0 <= '1';
                elsif (Q3 = '0' and Q2 = '0' and Q1 = '0' and Q0 = '1') then
                    Q0 <= '0'; Q1 <= '1';
                elsif (Q3 = '0' and Q2 = '0' and Q1 = '1' and Q0 = '0') then
                    Q1 <= '0'; Q2 <= '1';
                elsif (Q3 = '0' and Q2 = '1' and Q1 = '1' and Q0 = '0') then
                    Q2 <= '0'; Q3 <= '1';
                elsif (Q3 = '1' and Q2 = '1' and Q1 = '1' and Q0 = '1') then
                    Q0 <= '0'; Q1 <= '0'; Q2 <= '0'; Q3 <= '0';  -- Volta a zero após o máximo
                else
                    -- Lógica de incremento
                    if (Q0 = '1') then
                        Q0 <= '0';
                    elsif (Q1 = '1') then
                        Q1 <= '0'; Q0 <= '1';
                    elsif (Q2 = '1') then
                        Q2 <= '0'; Q1 <= '1';
                    elsif (Q3 = '1') then
                        Q3 <= '0'; Q2 <= '1';
                    end if;
                end if;
            end if;
        end if;
        clock_prev <= clock;  -- Atualiza o estado anterior do clock
    end process;

    Q <= Q3 & Q2 & Q1 & Q0;  -- Concatena os bits em Q
    fim <= '0';  -- Defina o sinal 'fim' conforme necessário
end architecture;
