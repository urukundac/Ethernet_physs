	component mdio_ethernet_ip is
		generic (
			MDC_DIVISOR : integer := 32
		);
		port (
			clk             : in  std_logic                     := 'X';             -- clk
			reset           : in  std_logic                     := 'X';             -- reset
			csr_write       : in  std_logic                     := 'X';             -- write
			csr_read        : in  std_logic                     := 'X';             -- read
			csr_address     : in  std_logic_vector(5 downto 0)  := (others => 'X'); -- address
			csr_writedata   : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			csr_readdata    : out std_logic_vector(31 downto 0);                    -- readdata
			csr_waitrequest : out std_logic;                                        -- waitrequest
			mdc             : out std_logic;                                        -- mdc
			mdio_in         : in  std_logic                     := 'X';             -- mdio_in
			mdio_out        : out std_logic;                                        -- mdio_out
			mdio_oen        : out std_logic                                         -- mdio_oen
		);
	end component mdio_ethernet_ip;

	u0 : component mdio_ethernet_ip
		generic map (
			MDC_DIVISOR => INTEGER_VALUE_FOR_MDC_DIVISOR
		)
		port map (
			clk             => CONNECTED_TO_clk,             --       clock.clk
			reset           => CONNECTED_TO_reset,           -- clock_reset.reset
			csr_write       => CONNECTED_TO_csr_write,       --         csr.write
			csr_read        => CONNECTED_TO_csr_read,        --            .read
			csr_address     => CONNECTED_TO_csr_address,     --            .address
			csr_writedata   => CONNECTED_TO_csr_writedata,   --            .writedata
			csr_readdata    => CONNECTED_TO_csr_readdata,    --            .readdata
			csr_waitrequest => CONNECTED_TO_csr_waitrequest, --            .waitrequest
			mdc             => CONNECTED_TO_mdc,             --        mdio.mdc
			mdio_in         => CONNECTED_TO_mdio_in,         --            .mdio_in
			mdio_out        => CONNECTED_TO_mdio_out,        --            .mdio_out
			mdio_oen        => CONNECTED_TO_mdio_oen         --            .mdio_oen
		);

