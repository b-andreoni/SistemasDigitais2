library ieee;

entity onescounter is
port (
  clock : in bit ;
  reset : in bit ;
  start : in bit ;
  inport : in bit_vector (14 downto 0 );
  outport : out bit_vector (3 downto 0 );
  done : out bit
);
end entity;

architecture uc_fd of onescounter is
	component onescounter_fd is 
    	port (
        clock : in bit;
        reset : in bit;
    	inport : in bit_vector(14 downto 0);
        zera : in bit;
        conta : in bit;
        carrega : in bit;
        desloca : in bit;
        registra : in bit;
    	outport : out bit_vector(3 downto 0);
        data0 : out bit;
        zero : out bit;
    	); end component;
    
    component onescounter_uc is
    	port (
        clock : in bit;
        reset : in bit;
        start : in bit;
        data0 : out bit;
        zero : out bit;
        zera : out bit;
        conta : out bit;
        carrega : out bit;
        desloca : out bit;
        done : out bit;
        registra : out bit;
    	); end component;
	
    signal s_zera, s_conta, s_carrega, s_desloca, s_registra, s_data0, s_zero : bit;

begin
	uc: onescounter_uc port map (
    	clock => clock,
        reset => reset,
        start => start,
        data0 => s_data0,
        zero => s_zero,
        zera => s_zera,
        conta => s_conta,
        carrega => s_carrega,
        desloca => s_desloca,
        done => done.
        registra => s_registra
    );
    
    fd: onescounter_fd 
    	generic map (N=>N)
    
      port map (
    	clock => clock,
        reset => reset,
        inport => inport,
        zera => s_zera,
        conta => s_conta,
        carrega => s_carrega,
        desloca => s_desloca,
        registra => s_registra, 
        outport => outport,
        data0 => s_data0,
        zero => s_zero
    );
end architecture; 
