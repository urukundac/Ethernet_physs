	component i2c_master_inst_reset_bfm_ip is
		generic (
			ASSERT_HIGH_RESET    : integer := 0;
			INITIAL_RESET_CYCLES : integer := 50
		);
		port (
			reset : out std_logic;        -- reset_n
			clk   : in  std_logic := 'X'  -- clk
		);
	end component i2c_master_inst_reset_bfm_ip;

	u0 : component i2c_master_inst_reset_bfm_ip
		generic map (
			ASSERT_HIGH_RESET    => INTEGER_VALUE_FOR_ASSERT_HIGH_RESET,
			INITIAL_RESET_CYCLES => INTEGER_VALUE_FOR_INITIAL_RESET_CYCLES
		)
		port map (
			reset => CONNECTED_TO_reset, -- reset.reset_n
			clk   => CONNECTED_TO_clk    --   clk.clk
		);

