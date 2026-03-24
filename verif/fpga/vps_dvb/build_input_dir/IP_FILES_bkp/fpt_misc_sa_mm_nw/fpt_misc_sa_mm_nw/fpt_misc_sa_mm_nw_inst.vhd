	component fpt_misc_sa_mm_nw is
		port (
			apb_clock_in_clk_clk                      : in  std_logic                      := 'X';             -- clk
			apb_reset_in_reset_reset_n                : in  std_logic                      := 'X';             -- reset_n
			avmm2st_address                           : out std_logic_vector(31 downto 0);                     -- address
			avmm2st_burstcount                        : out std_logic_vector(0 downto 0);                      -- burstcount
			avmm2st_byteenable                        : out std_logic_vector(3 downto 0);                      -- byteenable
			avmm2st_debugaccess                       : out std_logic;                                         -- debugaccess
			avmm2st_read                              : out std_logic;                                         -- read
			avmm2st_readdata                          : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- readdata
			avmm2st_readdatavalid                     : in  std_logic                      := 'X';             -- readdatavalid
			avmm2st_waitrequest                       : in  std_logic                      := 'X';             -- waitrequest
			avmm2st_write                             : out std_logic;                                         -- write
			avmm2st_writedata                         : out std_logic_vector(31 downto 0);                     -- writedata
			avmm_default_slave_m0_address             : out std_logic_vector(2 downto 0);                      -- address
			avmm_default_slave_m0_burstcount          : out std_logic_vector(0 downto 0);                      -- burstcount
			avmm_default_slave_m0_byteenable          : out std_logic_vector(3 downto 0);                      -- byteenable
			avmm_default_slave_m0_debugaccess         : out std_logic;                                         -- debugaccess
			avmm_default_slave_m0_read                : out std_logic;                                         -- read
			avmm_default_slave_m0_readdata            : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- readdata
			avmm_default_slave_m0_readdatavalid       : in  std_logic                      := 'X';             -- readdatavalid
			avmm_default_slave_m0_waitrequest         : in  std_logic                      := 'X';             -- waitrequest
			avmm_default_slave_m0_write               : out std_logic;                                         -- write
			avmm_default_slave_m0_writedata           : out std_logic_vector(31 downto 0);                     -- writedata
			core_clk_rst_sync_bridge_m0_address       : out std_logic_vector(7 downto 0);                      -- address
			core_clk_rst_sync_bridge_m0_burstcount    : out std_logic_vector(0 downto 0);                      -- burstcount
			core_clk_rst_sync_bridge_m0_byteenable    : out std_logic_vector(3 downto 0);                      -- byteenable
			core_clk_rst_sync_bridge_m0_debugaccess   : out std_logic;                                         -- debugaccess
			core_clk_rst_sync_bridge_m0_read          : out std_logic;                                         -- read
			core_clk_rst_sync_bridge_m0_readdata      : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- readdata
			core_clk_rst_sync_bridge_m0_readdatavalid : in  std_logic                      := 'X';             -- readdatavalid
			core_clk_rst_sync_bridge_m0_waitrequest   : in  std_logic                      := 'X';             -- waitrequest
			core_clk_rst_sync_bridge_m0_write         : out std_logic;                                         -- write
			core_clk_rst_sync_bridge_m0_writedata     : out std_logic_vector(31 downto 0);                     -- writedata
			core_clk_rst_sync_clock_in_clk_clk        : in  std_logic                      := 'X';             -- clk
			core_clk_rst_sync_reset_in_reset_reset_n  : in  std_logic                      := 'X';             -- reset_n
			ddr4_avmm_address                         : out std_logic_vector(33 downto 0);                     -- address
			ddr4_avmm_burstcount                      : out std_logic_vector(3 downto 0);                      -- burstcount
			ddr4_avmm_byteenable                      : out std_logic_vector(31 downto 0);                     -- byteenable
			ddr4_avmm_debugaccess                     : out std_logic;                                         -- debugaccess
			ddr4_avmm_read                            : out std_logic;                                         -- read
			ddr4_avmm_readdata                        : in  std_logic_vector(255 downto 0) := (others => 'X'); -- readdata
			ddr4_avmm_readdatavalid                   : in  std_logic                      := 'X';             -- readdatavalid
			ddr4_avmm_waitrequest                     : in  std_logic                      := 'X';             -- waitrequest
			ddr4_avmm_write                           : out std_logic;                                         -- write
			ddr4_avmm_writedata                       : out std_logic_vector(255 downto 0);                    -- writedata
			fpga_glbl_bridge_m0_address               : out std_logic_vector(7 downto 0);                      -- address
			fpga_glbl_bridge_m0_burstcount            : out std_logic_vector(0 downto 0);                      -- burstcount
			fpga_glbl_bridge_m0_byteenable            : out std_logic_vector(3 downto 0);                      -- byteenable
			fpga_glbl_bridge_m0_debugaccess           : out std_logic;                                         -- debugaccess
			fpga_glbl_bridge_m0_read                  : out std_logic;                                         -- read
			fpga_glbl_bridge_m0_readdata              : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- readdata
			fpga_glbl_bridge_m0_readdatavalid         : in  std_logic                      := 'X';             -- readdatavalid
			fpga_glbl_bridge_m0_waitrequest           : in  std_logic                      := 'X';             -- waitrequest
			fpga_glbl_bridge_m0_write                 : out std_logic;                                         -- write
			fpga_glbl_bridge_m0_writedata             : out std_logic_vector(31 downto 0);                     -- writedata
			i2c_clock_in_clk_clk                      : in  std_logic                      := 'X';             -- clk
			i2c_avmm_address                          : in  std_logic_vector(19 downto 0)  := (others => 'X'); -- address
			i2c_avmm_burstcount                       : in  std_logic_vector(0 downto 0)   := (others => 'X'); -- burstcount
			i2c_avmm_byteenable                       : in  std_logic_vector(3 downto 0)   := (others => 'X'); -- byteenable
			i2c_avmm_debugaccess                      : in  std_logic                      := 'X';             -- debugaccess
			i2c_avmm_read                             : in  std_logic                      := 'X';             -- read
			i2c_avmm_readdata                         : out std_logic_vector(31 downto 0);                     -- readdata
			i2c_avmm_readdatavalid                    : out std_logic;                                         -- readdatavalid
			i2c_avmm_waitrequest                      : out std_logic;                                         -- waitrequest
			i2c_avmm_write                            : in  std_logic                      := 'X';             -- write
			i2c_avmm_writedata                        : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- writedata
			i2c_reset_in_reset_reset_n                : in  std_logic                      := 'X';             -- reset_n
			infra_avst_clock_in_clk_clk               : in  std_logic                      := 'X';             -- clk
			infra_avst_reset_in_reset_reset_n         : in  std_logic                      := 'X';             -- reset_n
			jem_nw_bridge_m0_address                  : out std_logic_vector(33 downto 0);                     -- address
			jem_nw_bridge_m0_burstcount               : out std_logic_vector(10 downto 0);                     -- burstcount
			jem_nw_bridge_m0_byteenable               : out std_logic_vector(3 downto 0);                      -- byteenable
			jem_nw_bridge_m0_debugaccess              : out std_logic;                                         -- debugaccess
			jem_nw_bridge_m0_read                     : out std_logic;                                         -- read
			jem_nw_bridge_m0_readdata                 : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- readdata
			jem_nw_bridge_m0_readdatavalid            : in  std_logic                      := 'X';             -- readdatavalid
			jem_nw_bridge_m0_waitrequest              : in  std_logic                      := 'X';             -- waitrequest
			jem_nw_bridge_m0_write                    : out std_logic;                                         -- write
			jem_nw_bridge_m0_writedata                : out std_logic_vector(31 downto 0);                     -- writedata
			mon_clock_in_clk_clk                      : in  std_logic                      := 'X';             -- clk
			mon_reset_in_reset_reset_n                : in  std_logic                      := 'X';             -- reset_n
			pcie_hst_bridge_s0_address                : in  std_logic_vector(19 downto 0)  := (others => 'X'); -- address
			pcie_hst_bridge_s0_burstcount             : in  std_logic_vector(0 downto 0)   := (others => 'X'); -- burstcount
			pcie_hst_bridge_s0_byteenable             : in  std_logic_vector(3 downto 0)   := (others => 'X'); -- byteenable
			pcie_hst_bridge_s0_debugaccess            : in  std_logic                      := 'X';             -- debugaccess
			pcie_hst_bridge_s0_read                   : in  std_logic                      := 'X';             -- read
			pcie_hst_bridge_s0_readdata               : out std_logic_vector(31 downto 0);                     -- readdata
			pcie_hst_bridge_s0_readdatavalid          : out std_logic;                                         -- readdatavalid
			pcie_hst_bridge_s0_waitrequest            : out std_logic;                                         -- waitrequest
			pcie_hst_bridge_s0_write                  : in  std_logic                      := 'X';             -- write
			pcie_hst_bridge_s0_writedata              : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- writedata
			spi_merlin_apb_translator_m0_paddr        : out std_logic_vector(12 downto 0);                     -- paddr
			spi_merlin_apb_translator_m0_penable      : out std_logic;                                         -- penable
			spi_merlin_apb_translator_m0_prdata       : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- prdata
			spi_merlin_apb_translator_m0_pready       : in  std_logic                      := 'X';             -- pready
			spi_merlin_apb_translator_m0_psel         : out std_logic;                                         -- psel
			spi_merlin_apb_translator_m0_pwdata       : out std_logic_vector(31 downto 0);                     -- pwdata
			spi_merlin_apb_translator_m0_pwrite       : out std_logic;                                         -- pwrite
			sys_clk_rst_sync_bridge_m0_address        : out std_logic_vector(7 downto 0);                      -- address
			sys_clk_rst_sync_bridge_m0_burstcount     : out std_logic_vector(0 downto 0);                      -- burstcount
			sys_clk_rst_sync_bridge_m0_byteenable     : out std_logic_vector(3 downto 0);                      -- byteenable
			sys_clk_rst_sync_bridge_m0_debugaccess    : out std_logic;                                         -- debugaccess
			sys_clk_rst_sync_bridge_m0_read           : out std_logic;                                         -- read
			sys_clk_rst_sync_bridge_m0_readdata       : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- readdata
			sys_clk_rst_sync_bridge_m0_readdatavalid  : in  std_logic                      := 'X';             -- readdatavalid
			sys_clk_rst_sync_bridge_m0_waitrequest    : in  std_logic                      := 'X';             -- waitrequest
			sys_clk_rst_sync_bridge_m0_write          : out std_logic;                                         -- write
			sys_clk_rst_sync_bridge_m0_writedata      : out std_logic_vector(31 downto 0);                     -- writedata
			sys_clk_rst_sync_clock_in_clk_clk         : in  std_logic                      := 'X';             -- clk
			sys_clk_rst_sync_reset_in_reset_reset_n   : in  std_logic                      := 'X';             -- reset_n
			sysfpga_avst_bridge_s0_address            : in  std_logic_vector(23 downto 0)  := (others => 'X'); -- address
			sysfpga_avst_bridge_s0_burstcount         : in  std_logic_vector(0 downto 0)   := (others => 'X'); -- burstcount
			sysfpga_avst_bridge_s0_byteenable         : in  std_logic_vector(3 downto 0)   := (others => 'X'); -- byteenable
			sysfpga_avst_bridge_s0_debugaccess        : in  std_logic                      := 'X';             -- debugaccess
			sysfpga_avst_bridge_s0_read               : in  std_logic                      := 'X';             -- read
			sysfpga_avst_bridge_s0_readdata           : out std_logic_vector(31 downto 0);                     -- readdata
			sysfpga_avst_bridge_s0_readdatavalid      : out std_logic;                                         -- readdatavalid
			sysfpga_avst_bridge_s0_waitrequest        : out std_logic;                                         -- waitrequest
			sysfpga_avst_bridge_s0_write              : in  std_logic                      := 'X';             -- write
			sysfpga_avst_bridge_s0_writedata          : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- writedata
			sysfpga_avst_clock_in_clk_clk             : in  std_logic                      := 'X';             -- clk
			sysfpga_avst_reset_in_reset_reset_n       : in  std_logic                      := 'X';             -- reset_n
			usr_cntrl_pio_external_connection_export  : out std_logic_vector(31 downto 0);                     -- export
			usr_status_bridge_m0_address              : out std_logic_vector(7 downto 0);                      -- address
			usr_status_bridge_m0_burstcount           : out std_logic_vector(0 downto 0);                      -- burstcount
			usr_status_bridge_m0_byteenable           : out std_logic_vector(3 downto 0);                      -- byteenable
			usr_status_bridge_m0_debugaccess          : out std_logic;                                         -- debugaccess
			usr_status_bridge_m0_read                 : out std_logic;                                         -- read
			usr_status_bridge_m0_readdata             : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- readdata
			usr_status_bridge_m0_readdatavalid        : in  std_logic                      := 'X';             -- readdatavalid
			usr_status_bridge_m0_waitrequest          : in  std_logic                      := 'X';             -- waitrequest
			usr_status_bridge_m0_write                : out std_logic;                                         -- write
			usr_status_bridge_m0_writedata            : out std_logic_vector(31 downto 0)                      -- writedata
		);
	end component fpt_misc_sa_mm_nw;

	u0 : component fpt_misc_sa_mm_nw
		port map (
			apb_clock_in_clk_clk                      => CONNECTED_TO_apb_clock_in_clk_clk,                      --                  apb_clock_in_clk.clk
			apb_reset_in_reset_reset_n                => CONNECTED_TO_apb_reset_in_reset_reset_n,                --                apb_reset_in_reset.reset_n
			avmm2st_address                           => CONNECTED_TO_avmm2st_address,                           --                           avmm2st.address
			avmm2st_burstcount                        => CONNECTED_TO_avmm2st_burstcount,                        --                                  .burstcount
			avmm2st_byteenable                        => CONNECTED_TO_avmm2st_byteenable,                        --                                  .byteenable
			avmm2st_debugaccess                       => CONNECTED_TO_avmm2st_debugaccess,                       --                                  .debugaccess
			avmm2st_read                              => CONNECTED_TO_avmm2st_read,                              --                                  .read
			avmm2st_readdata                          => CONNECTED_TO_avmm2st_readdata,                          --                                  .readdata
			avmm2st_readdatavalid                     => CONNECTED_TO_avmm2st_readdatavalid,                     --                                  .readdatavalid
			avmm2st_waitrequest                       => CONNECTED_TO_avmm2st_waitrequest,                       --                                  .waitrequest
			avmm2st_write                             => CONNECTED_TO_avmm2st_write,                             --                                  .write
			avmm2st_writedata                         => CONNECTED_TO_avmm2st_writedata,                         --                                  .writedata
			avmm_default_slave_m0_address             => CONNECTED_TO_avmm_default_slave_m0_address,             --             avmm_default_slave_m0.address
			avmm_default_slave_m0_burstcount          => CONNECTED_TO_avmm_default_slave_m0_burstcount,          --                                  .burstcount
			avmm_default_slave_m0_byteenable          => CONNECTED_TO_avmm_default_slave_m0_byteenable,          --                                  .byteenable
			avmm_default_slave_m0_debugaccess         => CONNECTED_TO_avmm_default_slave_m0_debugaccess,         --                                  .debugaccess
			avmm_default_slave_m0_read                => CONNECTED_TO_avmm_default_slave_m0_read,                --                                  .read
			avmm_default_slave_m0_readdata            => CONNECTED_TO_avmm_default_slave_m0_readdata,            --                                  .readdata
			avmm_default_slave_m0_readdatavalid       => CONNECTED_TO_avmm_default_slave_m0_readdatavalid,       --                                  .readdatavalid
			avmm_default_slave_m0_waitrequest         => CONNECTED_TO_avmm_default_slave_m0_waitrequest,         --                                  .waitrequest
			avmm_default_slave_m0_write               => CONNECTED_TO_avmm_default_slave_m0_write,               --                                  .write
			avmm_default_slave_m0_writedata           => CONNECTED_TO_avmm_default_slave_m0_writedata,           --                                  .writedata
			core_clk_rst_sync_bridge_m0_address       => CONNECTED_TO_core_clk_rst_sync_bridge_m0_address,       --       core_clk_rst_sync_bridge_m0.address
			core_clk_rst_sync_bridge_m0_burstcount    => CONNECTED_TO_core_clk_rst_sync_bridge_m0_burstcount,    --                                  .burstcount
			core_clk_rst_sync_bridge_m0_byteenable    => CONNECTED_TO_core_clk_rst_sync_bridge_m0_byteenable,    --                                  .byteenable
			core_clk_rst_sync_bridge_m0_debugaccess   => CONNECTED_TO_core_clk_rst_sync_bridge_m0_debugaccess,   --                                  .debugaccess
			core_clk_rst_sync_bridge_m0_read          => CONNECTED_TO_core_clk_rst_sync_bridge_m0_read,          --                                  .read
			core_clk_rst_sync_bridge_m0_readdata      => CONNECTED_TO_core_clk_rst_sync_bridge_m0_readdata,      --                                  .readdata
			core_clk_rst_sync_bridge_m0_readdatavalid => CONNECTED_TO_core_clk_rst_sync_bridge_m0_readdatavalid, --                                  .readdatavalid
			core_clk_rst_sync_bridge_m0_waitrequest   => CONNECTED_TO_core_clk_rst_sync_bridge_m0_waitrequest,   --                                  .waitrequest
			core_clk_rst_sync_bridge_m0_write         => CONNECTED_TO_core_clk_rst_sync_bridge_m0_write,         --                                  .write
			core_clk_rst_sync_bridge_m0_writedata     => CONNECTED_TO_core_clk_rst_sync_bridge_m0_writedata,     --                                  .writedata
			core_clk_rst_sync_clock_in_clk_clk        => CONNECTED_TO_core_clk_rst_sync_clock_in_clk_clk,        --    core_clk_rst_sync_clock_in_clk.clk
			core_clk_rst_sync_reset_in_reset_reset_n  => CONNECTED_TO_core_clk_rst_sync_reset_in_reset_reset_n,  --  core_clk_rst_sync_reset_in_reset.reset_n
			ddr4_avmm_address                         => CONNECTED_TO_ddr4_avmm_address,                         --                         ddr4_avmm.address
			ddr4_avmm_burstcount                      => CONNECTED_TO_ddr4_avmm_burstcount,                      --                                  .burstcount
			ddr4_avmm_byteenable                      => CONNECTED_TO_ddr4_avmm_byteenable,                      --                                  .byteenable
			ddr4_avmm_debugaccess                     => CONNECTED_TO_ddr4_avmm_debugaccess,                     --                                  .debugaccess
			ddr4_avmm_read                            => CONNECTED_TO_ddr4_avmm_read,                            --                                  .read
			ddr4_avmm_readdata                        => CONNECTED_TO_ddr4_avmm_readdata,                        --                                  .readdata
			ddr4_avmm_readdatavalid                   => CONNECTED_TO_ddr4_avmm_readdatavalid,                   --                                  .readdatavalid
			ddr4_avmm_waitrequest                     => CONNECTED_TO_ddr4_avmm_waitrequest,                     --                                  .waitrequest
			ddr4_avmm_write                           => CONNECTED_TO_ddr4_avmm_write,                           --                                  .write
			ddr4_avmm_writedata                       => CONNECTED_TO_ddr4_avmm_writedata,                       --                                  .writedata
			fpga_glbl_bridge_m0_address               => CONNECTED_TO_fpga_glbl_bridge_m0_address,               --               fpga_glbl_bridge_m0.address
			fpga_glbl_bridge_m0_burstcount            => CONNECTED_TO_fpga_glbl_bridge_m0_burstcount,            --                                  .burstcount
			fpga_glbl_bridge_m0_byteenable            => CONNECTED_TO_fpga_glbl_bridge_m0_byteenable,            --                                  .byteenable
			fpga_glbl_bridge_m0_debugaccess           => CONNECTED_TO_fpga_glbl_bridge_m0_debugaccess,           --                                  .debugaccess
			fpga_glbl_bridge_m0_read                  => CONNECTED_TO_fpga_glbl_bridge_m0_read,                  --                                  .read
			fpga_glbl_bridge_m0_readdata              => CONNECTED_TO_fpga_glbl_bridge_m0_readdata,              --                                  .readdata
			fpga_glbl_bridge_m0_readdatavalid         => CONNECTED_TO_fpga_glbl_bridge_m0_readdatavalid,         --                                  .readdatavalid
			fpga_glbl_bridge_m0_waitrequest           => CONNECTED_TO_fpga_glbl_bridge_m0_waitrequest,           --                                  .waitrequest
			fpga_glbl_bridge_m0_write                 => CONNECTED_TO_fpga_glbl_bridge_m0_write,                 --                                  .write
			fpga_glbl_bridge_m0_writedata             => CONNECTED_TO_fpga_glbl_bridge_m0_writedata,             --                                  .writedata
			i2c_clock_in_clk_clk                      => CONNECTED_TO_i2c_clock_in_clk_clk,                      --                  i2c_clock_in_clk.clk
			i2c_avmm_address                          => CONNECTED_TO_i2c_avmm_address,                          --                          i2c_avmm.address
			i2c_avmm_burstcount                       => CONNECTED_TO_i2c_avmm_burstcount,                       --                                  .burstcount
			i2c_avmm_byteenable                       => CONNECTED_TO_i2c_avmm_byteenable,                       --                                  .byteenable
			i2c_avmm_debugaccess                      => CONNECTED_TO_i2c_avmm_debugaccess,                      --                                  .debugaccess
			i2c_avmm_read                             => CONNECTED_TO_i2c_avmm_read,                             --                                  .read
			i2c_avmm_readdata                         => CONNECTED_TO_i2c_avmm_readdata,                         --                                  .readdata
			i2c_avmm_readdatavalid                    => CONNECTED_TO_i2c_avmm_readdatavalid,                    --                                  .readdatavalid
			i2c_avmm_waitrequest                      => CONNECTED_TO_i2c_avmm_waitrequest,                      --                                  .waitrequest
			i2c_avmm_write                            => CONNECTED_TO_i2c_avmm_write,                            --                                  .write
			i2c_avmm_writedata                        => CONNECTED_TO_i2c_avmm_writedata,                        --                                  .writedata
			i2c_reset_in_reset_reset_n                => CONNECTED_TO_i2c_reset_in_reset_reset_n,                --                i2c_reset_in_reset.reset_n
			infra_avst_clock_in_clk_clk               => CONNECTED_TO_infra_avst_clock_in_clk_clk,               --           infra_avst_clock_in_clk.clk
			infra_avst_reset_in_reset_reset_n         => CONNECTED_TO_infra_avst_reset_in_reset_reset_n,         --         infra_avst_reset_in_reset.reset_n
			jem_nw_bridge_m0_address                  => CONNECTED_TO_jem_nw_bridge_m0_address,                  --                  jem_nw_bridge_m0.address
			jem_nw_bridge_m0_burstcount               => CONNECTED_TO_jem_nw_bridge_m0_burstcount,               --                                  .burstcount
			jem_nw_bridge_m0_byteenable               => CONNECTED_TO_jem_nw_bridge_m0_byteenable,               --                                  .byteenable
			jem_nw_bridge_m0_debugaccess              => CONNECTED_TO_jem_nw_bridge_m0_debugaccess,              --                                  .debugaccess
			jem_nw_bridge_m0_read                     => CONNECTED_TO_jem_nw_bridge_m0_read,                     --                                  .read
			jem_nw_bridge_m0_readdata                 => CONNECTED_TO_jem_nw_bridge_m0_readdata,                 --                                  .readdata
			jem_nw_bridge_m0_readdatavalid            => CONNECTED_TO_jem_nw_bridge_m0_readdatavalid,            --                                  .readdatavalid
			jem_nw_bridge_m0_waitrequest              => CONNECTED_TO_jem_nw_bridge_m0_waitrequest,              --                                  .waitrequest
			jem_nw_bridge_m0_write                    => CONNECTED_TO_jem_nw_bridge_m0_write,                    --                                  .write
			jem_nw_bridge_m0_writedata                => CONNECTED_TO_jem_nw_bridge_m0_writedata,                --                                  .writedata
			mon_clock_in_clk_clk                      => CONNECTED_TO_mon_clock_in_clk_clk,                      --                  mon_clock_in_clk.clk
			mon_reset_in_reset_reset_n                => CONNECTED_TO_mon_reset_in_reset_reset_n,                --                mon_reset_in_reset.reset_n
			pcie_hst_bridge_s0_address                => CONNECTED_TO_pcie_hst_bridge_s0_address,                --                pcie_hst_bridge_s0.address
			pcie_hst_bridge_s0_burstcount             => CONNECTED_TO_pcie_hst_bridge_s0_burstcount,             --                                  .burstcount
			pcie_hst_bridge_s0_byteenable             => CONNECTED_TO_pcie_hst_bridge_s0_byteenable,             --                                  .byteenable
			pcie_hst_bridge_s0_debugaccess            => CONNECTED_TO_pcie_hst_bridge_s0_debugaccess,            --                                  .debugaccess
			pcie_hst_bridge_s0_read                   => CONNECTED_TO_pcie_hst_bridge_s0_read,                   --                                  .read
			pcie_hst_bridge_s0_readdata               => CONNECTED_TO_pcie_hst_bridge_s0_readdata,               --                                  .readdata
			pcie_hst_bridge_s0_readdatavalid          => CONNECTED_TO_pcie_hst_bridge_s0_readdatavalid,          --                                  .readdatavalid
			pcie_hst_bridge_s0_waitrequest            => CONNECTED_TO_pcie_hst_bridge_s0_waitrequest,            --                                  .waitrequest
			pcie_hst_bridge_s0_write                  => CONNECTED_TO_pcie_hst_bridge_s0_write,                  --                                  .write
			pcie_hst_bridge_s0_writedata              => CONNECTED_TO_pcie_hst_bridge_s0_writedata,              --                                  .writedata
			spi_merlin_apb_translator_m0_paddr        => CONNECTED_TO_spi_merlin_apb_translator_m0_paddr,        --      spi_merlin_apb_translator_m0.paddr
			spi_merlin_apb_translator_m0_penable      => CONNECTED_TO_spi_merlin_apb_translator_m0_penable,      --                                  .penable
			spi_merlin_apb_translator_m0_prdata       => CONNECTED_TO_spi_merlin_apb_translator_m0_prdata,       --                                  .prdata
			spi_merlin_apb_translator_m0_pready       => CONNECTED_TO_spi_merlin_apb_translator_m0_pready,       --                                  .pready
			spi_merlin_apb_translator_m0_psel         => CONNECTED_TO_spi_merlin_apb_translator_m0_psel,         --                                  .psel
			spi_merlin_apb_translator_m0_pwdata       => CONNECTED_TO_spi_merlin_apb_translator_m0_pwdata,       --                                  .pwdata
			spi_merlin_apb_translator_m0_pwrite       => CONNECTED_TO_spi_merlin_apb_translator_m0_pwrite,       --                                  .pwrite
			sys_clk_rst_sync_bridge_m0_address        => CONNECTED_TO_sys_clk_rst_sync_bridge_m0_address,        --        sys_clk_rst_sync_bridge_m0.address
			sys_clk_rst_sync_bridge_m0_burstcount     => CONNECTED_TO_sys_clk_rst_sync_bridge_m0_burstcount,     --                                  .burstcount
			sys_clk_rst_sync_bridge_m0_byteenable     => CONNECTED_TO_sys_clk_rst_sync_bridge_m0_byteenable,     --                                  .byteenable
			sys_clk_rst_sync_bridge_m0_debugaccess    => CONNECTED_TO_sys_clk_rst_sync_bridge_m0_debugaccess,    --                                  .debugaccess
			sys_clk_rst_sync_bridge_m0_read           => CONNECTED_TO_sys_clk_rst_sync_bridge_m0_read,           --                                  .read
			sys_clk_rst_sync_bridge_m0_readdata       => CONNECTED_TO_sys_clk_rst_sync_bridge_m0_readdata,       --                                  .readdata
			sys_clk_rst_sync_bridge_m0_readdatavalid  => CONNECTED_TO_sys_clk_rst_sync_bridge_m0_readdatavalid,  --                                  .readdatavalid
			sys_clk_rst_sync_bridge_m0_waitrequest    => CONNECTED_TO_sys_clk_rst_sync_bridge_m0_waitrequest,    --                                  .waitrequest
			sys_clk_rst_sync_bridge_m0_write          => CONNECTED_TO_sys_clk_rst_sync_bridge_m0_write,          --                                  .write
			sys_clk_rst_sync_bridge_m0_writedata      => CONNECTED_TO_sys_clk_rst_sync_bridge_m0_writedata,      --                                  .writedata
			sys_clk_rst_sync_clock_in_clk_clk         => CONNECTED_TO_sys_clk_rst_sync_clock_in_clk_clk,         --     sys_clk_rst_sync_clock_in_clk.clk
			sys_clk_rst_sync_reset_in_reset_reset_n   => CONNECTED_TO_sys_clk_rst_sync_reset_in_reset_reset_n,   --   sys_clk_rst_sync_reset_in_reset.reset_n
			sysfpga_avst_bridge_s0_address            => CONNECTED_TO_sysfpga_avst_bridge_s0_address,            --            sysfpga_avst_bridge_s0.address
			sysfpga_avst_bridge_s0_burstcount         => CONNECTED_TO_sysfpga_avst_bridge_s0_burstcount,         --                                  .burstcount
			sysfpga_avst_bridge_s0_byteenable         => CONNECTED_TO_sysfpga_avst_bridge_s0_byteenable,         --                                  .byteenable
			sysfpga_avst_bridge_s0_debugaccess        => CONNECTED_TO_sysfpga_avst_bridge_s0_debugaccess,        --                                  .debugaccess
			sysfpga_avst_bridge_s0_read               => CONNECTED_TO_sysfpga_avst_bridge_s0_read,               --                                  .read
			sysfpga_avst_bridge_s0_readdata           => CONNECTED_TO_sysfpga_avst_bridge_s0_readdata,           --                                  .readdata
			sysfpga_avst_bridge_s0_readdatavalid      => CONNECTED_TO_sysfpga_avst_bridge_s0_readdatavalid,      --                                  .readdatavalid
			sysfpga_avst_bridge_s0_waitrequest        => CONNECTED_TO_sysfpga_avst_bridge_s0_waitrequest,        --                                  .waitrequest
			sysfpga_avst_bridge_s0_write              => CONNECTED_TO_sysfpga_avst_bridge_s0_write,              --                                  .write
			sysfpga_avst_bridge_s0_writedata          => CONNECTED_TO_sysfpga_avst_bridge_s0_writedata,          --                                  .writedata
			sysfpga_avst_clock_in_clk_clk             => CONNECTED_TO_sysfpga_avst_clock_in_clk_clk,             --         sysfpga_avst_clock_in_clk.clk
			sysfpga_avst_reset_in_reset_reset_n       => CONNECTED_TO_sysfpga_avst_reset_in_reset_reset_n,       --       sysfpga_avst_reset_in_reset.reset_n
			usr_cntrl_pio_external_connection_export  => CONNECTED_TO_usr_cntrl_pio_external_connection_export,  -- usr_cntrl_pio_external_connection.export
			usr_status_bridge_m0_address              => CONNECTED_TO_usr_status_bridge_m0_address,              --              usr_status_bridge_m0.address
			usr_status_bridge_m0_burstcount           => CONNECTED_TO_usr_status_bridge_m0_burstcount,           --                                  .burstcount
			usr_status_bridge_m0_byteenable           => CONNECTED_TO_usr_status_bridge_m0_byteenable,           --                                  .byteenable
			usr_status_bridge_m0_debugaccess          => CONNECTED_TO_usr_status_bridge_m0_debugaccess,          --                                  .debugaccess
			usr_status_bridge_m0_read                 => CONNECTED_TO_usr_status_bridge_m0_read,                 --                                  .read
			usr_status_bridge_m0_readdata             => CONNECTED_TO_usr_status_bridge_m0_readdata,             --                                  .readdata
			usr_status_bridge_m0_readdatavalid        => CONNECTED_TO_usr_status_bridge_m0_readdatavalid,        --                                  .readdatavalid
			usr_status_bridge_m0_waitrequest          => CONNECTED_TO_usr_status_bridge_m0_waitrequest,          --                                  .waitrequest
			usr_status_bridge_m0_write                => CONNECTED_TO_usr_status_bridge_m0_write,                --                                  .write
			usr_status_bridge_m0_writedata            => CONNECTED_TO_usr_status_bridge_m0_writedata             --                                  .writedata
		);

