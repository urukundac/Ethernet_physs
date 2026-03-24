	component i2c_master_inst_conduit_end_bfm_ip is
		port (
			sig_conduit_data_in : out std_logic_vector(0 downto 0);                    -- conduit_data_in
			sig_conduit_clk_in  : out std_logic_vector(0 downto 0);                    -- conduit_clk_in
			sig_conduit_data_oe : in  std_logic_vector(0 downto 0) := (others => 'X'); -- conduit_data_oe
			sig_conduit_clk_oe  : in  std_logic_vector(0 downto 0) := (others => 'X')  -- conduit_clk_oe
		);
	end component i2c_master_inst_conduit_end_bfm_ip;

	u0 : component i2c_master_inst_conduit_end_bfm_ip
		port map (
			sig_conduit_data_in => CONNECTED_TO_sig_conduit_data_in, -- conduit.conduit_data_in
			sig_conduit_clk_in  => CONNECTED_TO_sig_conduit_clk_in,  --        .conduit_clk_in
			sig_conduit_data_oe => CONNECTED_TO_sig_conduit_data_oe, --        .conduit_data_oe
			sig_conduit_clk_oe  => CONNECTED_TO_sig_conduit_clk_oe   --        .conduit_clk_oe
		);

