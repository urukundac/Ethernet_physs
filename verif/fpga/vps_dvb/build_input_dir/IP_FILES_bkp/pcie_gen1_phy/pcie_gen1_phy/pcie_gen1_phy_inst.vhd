	component pcie_gen1_phy is
		port (
			pipe_sw_done              : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- pipe_sw_done
			pipe_sw                   : out std_logic_vector(1 downto 0);                     -- pipe_sw
			tx_analogreset            : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- tx_analogreset
			rx_analogreset            : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- rx_analogreset
			tx_digitalreset           : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- tx_digitalreset
			rx_digitalreset           : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- rx_digitalreset
			tx_analogreset_stat       : out std_logic_vector(0 downto 0);                     -- tx_analogreset_stat
			rx_analogreset_stat       : out std_logic_vector(0 downto 0);                     -- rx_analogreset_stat
			tx_digitalreset_stat      : out std_logic_vector(0 downto 0);                     -- tx_digitalreset_stat
			rx_digitalreset_stat      : out std_logic_vector(0 downto 0);                     -- rx_digitalreset_stat
			tx_cal_busy               : out std_logic_vector(0 downto 0);                     -- tx_cal_busy
			rx_cal_busy               : out std_logic_vector(0 downto 0);                     -- rx_cal_busy
			tx_serial_clk0            : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- clk
			rx_cdr_refclk0            : in  std_logic                     := 'X';             -- clk
			tx_serial_data            : out std_logic_vector(0 downto 0);                     -- tx_serial_data
			rx_serial_data            : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- rx_serial_data
			rx_is_lockedtoref         : out std_logic_vector(0 downto 0);                     -- rx_is_lockedtoref
			rx_is_lockedtodata        : out std_logic_vector(0 downto 0);                     -- rx_is_lockedtodata
			tx_coreclkin              : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- clk
			rx_coreclkin              : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- clk
			tx_clkout                 : out std_logic_vector(0 downto 0);                     -- clk
			rx_clkout                 : out std_logic_vector(0 downto 0);                     -- clk
			tx_parallel_data          : in  std_logic_vector(15 downto 0) := (others => 'X'); -- tx_parallel_data
			tx_datak                  : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- tx_datak
			pipe_tx_compliance        : in  std_logic                     := 'X';             -- pipe_tx_compliance
			pipe_tx_elecidle          : in  std_logic                     := 'X';             -- pipe_tx_elecidle
			pipe_tx_detectrx_loopback : in  std_logic                     := 'X';             -- pipe_tx_detectrx_loopback
			pipe_powerdown            : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- pipe_powerdown
			pipe_tx_margin            : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- pipe_tx_margin
			pipe_tx_swing             : in  std_logic                     := 'X';             -- pipe_tx_swing
			pipe_rx_polarity          : in  std_logic                     := 'X';             -- pipe_rx_polarity
			unused_tx_parallel_data   : in  std_logic_vector(51 downto 0) := (others => 'X'); -- unused_tx_parallel_data
			rx_parallel_data          : out std_logic_vector(15 downto 0);                    -- rx_parallel_data
			rx_datak                  : out std_logic_vector(1 downto 0);                     -- rx_datak
			rx_syncstatus             : out std_logic_vector(1 downto 0);                     -- rx_syncstatus
			pipe_phy_status           : out std_logic;                                        -- pipe_phy_status
			pipe_rx_valid             : out std_logic;                                        -- pipe_rx_valid
			pipe_rx_status            : out std_logic_vector(2 downto 0);                     -- pipe_rx_status
			unused_rx_parallel_data   : out std_logic_vector(54 downto 0);                    -- unused_rx_parallel_data
			pipe_hclk_in              : in  std_logic                     := 'X';             -- clk
			pipe_hclk_out             : out std_logic;                                        -- clk
			pipe_rx_eidleinfersel     : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- pipe_rx_eidleinfersel
			pipe_rx_elecidle          : out std_logic_vector(0 downto 0);                     -- pipe_rx_elecidle
			reconfig_clk              : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- clk
			reconfig_reset            : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- reset
			reconfig_write            : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- write
			reconfig_read             : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- read
			reconfig_address          : in  std_logic_vector(10 downto 0) := (others => 'X'); -- address
			reconfig_writedata        : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			reconfig_readdata         : out std_logic_vector(31 downto 0);                    -- readdata
			reconfig_waitrequest      : out std_logic_vector(0 downto 0)                      -- waitrequest
		);
	end component pcie_gen1_phy;

	u0 : component pcie_gen1_phy
		port map (
			pipe_sw_done              => CONNECTED_TO_pipe_sw_done,              --              pipe_sw_done.pipe_sw_done
			pipe_sw                   => CONNECTED_TO_pipe_sw,                   --                   pipe_sw.pipe_sw
			tx_analogreset            => CONNECTED_TO_tx_analogreset,            --            tx_analogreset.tx_analogreset
			rx_analogreset            => CONNECTED_TO_rx_analogreset,            --            rx_analogreset.rx_analogreset
			tx_digitalreset           => CONNECTED_TO_tx_digitalreset,           --           tx_digitalreset.tx_digitalreset
			rx_digitalreset           => CONNECTED_TO_rx_digitalreset,           --           rx_digitalreset.rx_digitalreset
			tx_analogreset_stat       => CONNECTED_TO_tx_analogreset_stat,       --       tx_analogreset_stat.tx_analogreset_stat
			rx_analogreset_stat       => CONNECTED_TO_rx_analogreset_stat,       --       rx_analogreset_stat.rx_analogreset_stat
			tx_digitalreset_stat      => CONNECTED_TO_tx_digitalreset_stat,      --      tx_digitalreset_stat.tx_digitalreset_stat
			rx_digitalreset_stat      => CONNECTED_TO_rx_digitalreset_stat,      --      rx_digitalreset_stat.rx_digitalreset_stat
			tx_cal_busy               => CONNECTED_TO_tx_cal_busy,               --               tx_cal_busy.tx_cal_busy
			rx_cal_busy               => CONNECTED_TO_rx_cal_busy,               --               rx_cal_busy.rx_cal_busy
			tx_serial_clk0            => CONNECTED_TO_tx_serial_clk0,            --            tx_serial_clk0.clk
			rx_cdr_refclk0            => CONNECTED_TO_rx_cdr_refclk0,            --            rx_cdr_refclk0.clk
			tx_serial_data            => CONNECTED_TO_tx_serial_data,            --            tx_serial_data.tx_serial_data
			rx_serial_data            => CONNECTED_TO_rx_serial_data,            --            rx_serial_data.rx_serial_data
			rx_is_lockedtoref         => CONNECTED_TO_rx_is_lockedtoref,         --         rx_is_lockedtoref.rx_is_lockedtoref
			rx_is_lockedtodata        => CONNECTED_TO_rx_is_lockedtodata,        --        rx_is_lockedtodata.rx_is_lockedtodata
			tx_coreclkin              => CONNECTED_TO_tx_coreclkin,              --              tx_coreclkin.clk
			rx_coreclkin              => CONNECTED_TO_rx_coreclkin,              --              rx_coreclkin.clk
			tx_clkout                 => CONNECTED_TO_tx_clkout,                 --                 tx_clkout.clk
			rx_clkout                 => CONNECTED_TO_rx_clkout,                 --                 rx_clkout.clk
			tx_parallel_data          => CONNECTED_TO_tx_parallel_data,          --          tx_parallel_data.tx_parallel_data
			tx_datak                  => CONNECTED_TO_tx_datak,                  --                  tx_datak.tx_datak
			pipe_tx_compliance        => CONNECTED_TO_pipe_tx_compliance,        --        pipe_tx_compliance.pipe_tx_compliance
			pipe_tx_elecidle          => CONNECTED_TO_pipe_tx_elecidle,          --          pipe_tx_elecidle.pipe_tx_elecidle
			pipe_tx_detectrx_loopback => CONNECTED_TO_pipe_tx_detectrx_loopback, -- pipe_tx_detectrx_loopback.pipe_tx_detectrx_loopback
			pipe_powerdown            => CONNECTED_TO_pipe_powerdown,            --            pipe_powerdown.pipe_powerdown
			pipe_tx_margin            => CONNECTED_TO_pipe_tx_margin,            --            pipe_tx_margin.pipe_tx_margin
			pipe_tx_swing             => CONNECTED_TO_pipe_tx_swing,             --             pipe_tx_swing.pipe_tx_swing
			pipe_rx_polarity          => CONNECTED_TO_pipe_rx_polarity,          --          pipe_rx_polarity.pipe_rx_polarity
			unused_tx_parallel_data   => CONNECTED_TO_unused_tx_parallel_data,   --   unused_tx_parallel_data.unused_tx_parallel_data
			rx_parallel_data          => CONNECTED_TO_rx_parallel_data,          --          rx_parallel_data.rx_parallel_data
			rx_datak                  => CONNECTED_TO_rx_datak,                  --                  rx_datak.rx_datak
			rx_syncstatus             => CONNECTED_TO_rx_syncstatus,             --             rx_syncstatus.rx_syncstatus
			pipe_phy_status           => CONNECTED_TO_pipe_phy_status,           --           pipe_phy_status.pipe_phy_status
			pipe_rx_valid             => CONNECTED_TO_pipe_rx_valid,             --             pipe_rx_valid.pipe_rx_valid
			pipe_rx_status            => CONNECTED_TO_pipe_rx_status,            --            pipe_rx_status.pipe_rx_status
			unused_rx_parallel_data   => CONNECTED_TO_unused_rx_parallel_data,   --   unused_rx_parallel_data.unused_rx_parallel_data
			pipe_hclk_in              => CONNECTED_TO_pipe_hclk_in,              --              pipe_hclk_in.clk
			pipe_hclk_out             => CONNECTED_TO_pipe_hclk_out,             --             pipe_hclk_out.clk
			pipe_rx_eidleinfersel     => CONNECTED_TO_pipe_rx_eidleinfersel,     --     pipe_rx_eidleinfersel.pipe_rx_eidleinfersel
			pipe_rx_elecidle          => CONNECTED_TO_pipe_rx_elecidle,          --          pipe_rx_elecidle.pipe_rx_elecidle
			reconfig_clk              => CONNECTED_TO_reconfig_clk,              --              reconfig_clk.clk
			reconfig_reset            => CONNECTED_TO_reconfig_reset,            --            reconfig_reset.reset
			reconfig_write            => CONNECTED_TO_reconfig_write,            --             reconfig_avmm.write
			reconfig_read             => CONNECTED_TO_reconfig_read,             --                          .read
			reconfig_address          => CONNECTED_TO_reconfig_address,          --                          .address
			reconfig_writedata        => CONNECTED_TO_reconfig_writedata,        --                          .writedata
			reconfig_readdata         => CONNECTED_TO_reconfig_readdata,         --                          .readdata
			reconfig_waitrequest      => CONNECTED_TO_reconfig_waitrequest       --                          .waitrequest
		);

