library ieee;
use ieee.numeric_bit.all;

entity onescounter is
    port (
        clock  : in bit;
        reset  : in bit;
        start  : in bit;
        inport : in bit_vector(14 downto 0);
        outport: out bit_vector(3 downto 0);
        done   : out bit
    );
end entity onescounter;

architecture integration of onescounter is
    -- Componentes
    component onescounter_fd
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
    end component;

    component onescounter_uc
        port (
            clock   : in bit;
            reset   : in bit;
            start   : in bit;
            data0   : in bit;
            zero    : in bit;
            zera    : out bit;
            conta   : out bit;
            carrega : out bit;
            desloca : out bit;
            done    : out bit;
            registra: out bit -- Adicionei 'registra' para controle de registro
        );
    end component;

    signal zera_sig, conta_sig, carrega_sig, desloca_sig, registra_sig: bit;
    signal data0_sig, zero_sig: bit;

begin
    fd_instance: onescounter_fd
        port map (
            clock    => clock,
            reset    => reset,
            inport   => inport,
            zera     => zera_sig,
            conta    => conta_sig,
            carrega  => carrega_sig,
            desloca  => desloca_sig,
            registra => registra_sig,
            outport  => outport,
            data0    => data0_sig,
            zero     => zero_sig
        );

    uc_instance: onescounter_uc
        port map (
            clock    => clock,
            reset    => reset,
            start    => start,
            data0    => data0_sig,
            zero     => zero_sig,
            zera     => zera_sig,
            conta    => conta_sig,
            carrega  => carrega_sig,
            desloca  => desloca_sig,
            done     => done,
            registra => registra_sig
        );
end architecture integration;
