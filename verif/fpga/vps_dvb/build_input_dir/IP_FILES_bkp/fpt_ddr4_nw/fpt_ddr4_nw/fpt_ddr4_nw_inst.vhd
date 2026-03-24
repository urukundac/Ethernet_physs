	component fpt_ddr4_nw is
		port (
			clk_misc_sa_clk          : in  std_logic                      := 'X';             -- clk
			clk_mm_0_clk             : in  std_logic                      := 'X';             -- clk
			clk_mm_1_clk             : in  std_logic                      := 'X';             -- clk
			clk_mm_2_clk             : in  std_logic                      := 'X';             -- clk
			clk_mm_3_clk             : in  std_logic                      := 'X';             -- clk
			ddr4_amm_address         : out std_logic_vector(25 downto 0);                     -- address
			ddr4_amm_burstcount      : out std_logic_vector(6 downto 0);                      -- burstcount
			ddr4_amm_byteenable      : out std_logic_vector(63 downto 0);                     -- byteenable
			ddr4_amm_debugaccess     : out std_logic;                                         -- debugaccess
			ddr4_amm_read            : out std_logic;                                         -- read
			ddr4_amm_readdata        : in  std_logic_vector(511 downto 0) := (others => 'X'); -- readdata
			ddr4_amm_readdatavalid   : in  std_logic                      := 'X';             -- readdatavalid
			ddr4_amm_waitrequest     : in  std_logic                      := 'X';             -- waitrequest
			ddr4_amm_write           : out std_logic;                                         -- write
			ddr4_amm_writedata       : out std_logic_vector(511 downto 0);                    -- writedata
			reset_emif_reset_n       : in  std_logic                      := 'X';             -- reset_n
			clk_emif_clk             : in  std_logic                      := 'X';             -- clk
			mm_0_address             : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- address
			mm_0_burstcount          : in  std_logic_vector(3 downto 0)   := (others => 'X'); -- burstcount
			mm_0_byteenable          : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- byteenable
			mm_0_debugaccess         : in  std_logic                      := 'X';             -- debugaccess
			mm_0_read                : in  std_logic                      := 'X';             -- read
			mm_0_readdata            : out std_logic_vector(255 downto 0);                    -- readdata
			mm_0_readdatavalid       : out std_logic;                                         -- readdatavalid
			mm_0_waitrequest         : out std_logic;                                         -- waitrequest
			mm_0_write               : in  std_logic                      := 'X';             -- write
			mm_0_writedata           : in  std_logic_vector(255 downto 0) := (others => 'X'); -- writedata
			mm_1_address             : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- address
			mm_1_burstcount          : in  std_logic_vector(3 downto 0)   := (others => 'X'); -- burstcount
			mm_1_byteenable          : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- byteenable
			mm_1_debugaccess         : in  std_logic                      := 'X';             -- debugaccess
			mm_1_read                : in  std_logic                      := 'X';             -- read
			mm_1_readdata            : out std_logic_vector(255 downto 0);                    -- readdata
			mm_1_readdatavalid       : out std_logic;                                         -- readdatavalid
			mm_1_waitrequest         : out std_logic;                                         -- waitrequest
			mm_1_write               : in  std_logic                      := 'X';             -- write
			mm_1_writedata           : in  std_logic_vector(255 downto 0) := (others => 'X'); -- writedata
			mm_2_address             : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- address
			mm_2_burstcount          : in  std_logic_vector(3 downto 0)   := (others => 'X'); -- burstcount
			mm_2_byteenable          : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- byteenable
			mm_2_debugaccess         : in  std_logic                      := 'X';             -- debugaccess
			mm_2_read                : in  std_logic                      := 'X';             -- read
			mm_2_readdata            : out std_logic_vector(255 downto 0);                    -- readdata
			mm_2_readdatavalid       : out std_logic;                                         -- readdatavalid
			mm_2_waitrequest         : out std_logic;                                         -- waitrequest
			mm_2_write               : in  std_logic                      := 'X';             -- write
			mm_2_writedata           : in  std_logic_vector(255 downto 0) := (others => 'X'); -- writedata
			mm_3_address             : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- address
			mm_3_burstcount          : in  std_logic_vector(3 downto 0)   := (others => 'X'); -- burstcount
			mm_3_byteenable          : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- byteenable
			mm_3_debugaccess         : in  std_logic                      := 'X';             -- debugaccess
			mm_3_read                : in  std_logic                      := 'X';             -- read
			mm_3_readdata            : out std_logic_vector(255 downto 0);                    -- readdata
			mm_3_readdatavalid       : out std_logic;                                         -- readdatavalid
			mm_3_waitrequest         : out std_logic;                                         -- waitrequest
			mm_3_write               : in  std_logic                      := 'X';             -- write
			mm_3_writedata           : in  std_logic_vector(255 downto 0) := (others => 'X'); -- writedata
			mm_csr_address           : out std_logic_vector(10 downto 0);                     -- address
			mm_csr_burstcount        : out std_logic_vector(3 downto 0);                      -- burstcount
			mm_csr_byteenable        : out std_logic_vector(3 downto 0);                      -- byteenable
			mm_csr_debugaccess       : out std_logic;                                         -- debugaccess
			mm_csr_read              : out std_logic;                                         -- read
			mm_csr_readdata          : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- readdata
			mm_csr_readdatavalid     : in  std_logic                      := 'X';             -- readdatavalid
			mm_csr_waitrequest       : in  std_logic                      := 'X';             -- waitrequest
			mm_csr_write             : out std_logic;                                         -- write
			mm_csr_writedata         : out std_logic_vector(31 downto 0);                     -- writedata
			mm_misc_sa_address       : in  std_logic_vector(33 downto 0)  := (others => 'X'); -- address
			mm_misc_sa_burstcount    : in  std_logic_vector(3 downto 0)   := (others => 'X'); -- burstcount
			mm_misc_sa_byteenable    : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- byteenable
			mm_misc_sa_debugaccess   : in  std_logic                      := 'X';             -- debugaccess
			mm_misc_sa_read          : in  std_logic                      := 'X';             -- read
			mm_misc_sa_readdata      : out std_logic_vector(255 downto 0);                    -- readdata
			mm_misc_sa_readdatavalid : out std_logic;                                         -- readdatavalid
			mm_misc_sa_waitrequest   : out std_logic;                                         -- waitrequest
			mm_misc_sa_write         : in  std_logic                      := 'X';             -- write
			mm_misc_sa_writedata     : in  std_logic_vector(255 downto 0) := (others => 'X'); -- writedata
			emif_mmr_address         : out std_logic_vector(9 downto 0);                      -- address
			emif_mmr_burstcount      : out std_logic_vector(0 downto 0);                      -- burstcount
			emif_mmr_byteenable      : out std_logic_vector(3 downto 0);                      -- byteenable
			emif_mmr_debugaccess     : out std_logic;                                         -- debugaccess
			emif_mmr_read            : out std_logic;                                         -- read
			emif_mmr_readdata        : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- readdata
			emif_mmr_readdatavalid   : in  std_logic                      := 'X';             -- readdatavalid
			emif_mmr_waitrequest     : in  std_logic                      := 'X';             -- waitrequest
			emif_mmr_write           : out std_logic;                                         -- write
			emif_mmr_writedata       : out std_logic_vector(31 downto 0);                     -- writedata
			rst_misc_sa_reset_n      : in  std_logic                      := 'X';             -- reset_n
			rst_mm_0_reset_n         : in  std_logic                      := 'X';             -- reset_n
			rst_mm_1_reset_n         : in  std_logic                      := 'X';             -- reset_n
			rst_mm_2_reset_n         : in  std_logic                      := 'X';             -- reset_n
			rst_mm_3_reset_n         : in  std_logic                      := 'X'              -- reset_n
		);
	end component fpt_ddr4_nw;

	u0 : component fpt_ddr4_nw
		port map (
			clk_misc_sa_clk          => CONNECTED_TO_clk_misc_sa_clk,          -- clk_misc_sa.clk
			clk_mm_0_clk             => CONNECTED_TO_clk_mm_0_clk,             --    clk_mm_0.clk
			clk_mm_1_clk             => CONNECTED_TO_clk_mm_1_clk,             --    clk_mm_1.clk
			clk_mm_2_clk             => CONNECTED_TO_clk_mm_2_clk,             --    clk_mm_2.clk
			clk_mm_3_clk             => CONNECTED_TO_clk_mm_3_clk,             --    clk_mm_3.clk
			ddr4_amm_address         => CONNECTED_TO_ddr4_amm_address,         --    ddr4_amm.address
			ddr4_amm_burstcount      => CONNECTED_TO_ddr4_amm_burstcount,      --            .burstcount
			ddr4_amm_byteenable      => CONNECTED_TO_ddr4_amm_byteenable,      --            .byteenable
			ddr4_amm_debugaccess     => CONNECTED_TO_ddr4_amm_debugaccess,     --            .debugaccess
			ddr4_amm_read            => CONNECTED_TO_ddr4_amm_read,            --            .read
			ddr4_amm_readdata        => CONNECTED_TO_ddr4_amm_readdata,        --            .readdata
			ddr4_amm_readdatavalid   => CONNECTED_TO_ddr4_amm_readdatavalid,   --            .readdatavalid
			ddr4_amm_waitrequest     => CONNECTED_TO_ddr4_amm_waitrequest,     --            .waitrequest
			ddr4_amm_write           => CONNECTED_TO_ddr4_amm_write,           --            .write
			ddr4_amm_writedata       => CONNECTED_TO_ddr4_amm_writedata,       --            .writedata
			reset_emif_reset_n       => CONNECTED_TO_reset_emif_reset_n,       --  reset_emif.reset_n
			clk_emif_clk             => CONNECTED_TO_clk_emif_clk,             --    clk_emif.clk
			mm_0_address             => CONNECTED_TO_mm_0_address,             --        mm_0.address
			mm_0_burstcount          => CONNECTED_TO_mm_0_burstcount,          --            .burstcount
			mm_0_byteenable          => CONNECTED_TO_mm_0_byteenable,          --            .byteenable
			mm_0_debugaccess         => CONNECTED_TO_mm_0_debugaccess,         --            .debugaccess
			mm_0_read                => CONNECTED_TO_mm_0_read,                --            .read
			mm_0_readdata            => CONNECTED_TO_mm_0_readdata,            --            .readdata
			mm_0_readdatavalid       => CONNECTED_TO_mm_0_readdatavalid,       --            .readdatavalid
			mm_0_waitrequest         => CONNECTED_TO_mm_0_waitrequest,         --            .waitrequest
			mm_0_write               => CONNECTED_TO_mm_0_write,               --            .write
			mm_0_writedata           => CONNECTED_TO_mm_0_writedata,           --            .writedata
			mm_1_address             => CONNECTED_TO_mm_1_address,             --        mm_1.address
			mm_1_burstcount          => CONNECTED_TO_mm_1_burstcount,          --            .burstcount
			mm_1_byteenable          => CONNECTED_TO_mm_1_byteenable,          --            .byteenable
			mm_1_debugaccess         => CONNECTED_TO_mm_1_debugaccess,         --            .debugaccess
			mm_1_read                => CONNECTED_TO_mm_1_read,                --            .read
			mm_1_readdata            => CONNECTED_TO_mm_1_readdata,            --            .readdata
			mm_1_readdatavalid       => CONNECTED_TO_mm_1_readdatavalid,       --            .readdatavalid
			mm_1_waitrequest         => CONNECTED_TO_mm_1_waitrequest,         --            .waitrequest
			mm_1_write               => CONNECTED_TO_mm_1_write,               --            .write
			mm_1_writedata           => CONNECTED_TO_mm_1_writedata,           --            .writedata
			mm_2_address             => CONNECTED_TO_mm_2_address,             --        mm_2.address
			mm_2_burstcount          => CONNECTED_TO_mm_2_burstcount,          --            .burstcount
			mm_2_byteenable          => CONNECTED_TO_mm_2_byteenable,          --            .byteenable
			mm_2_debugaccess         => CONNECTED_TO_mm_2_debugaccess,         --            .debugaccess
			mm_2_read                => CONNECTED_TO_mm_2_read,                --            .read
			mm_2_readdata            => CONNECTED_TO_mm_2_readdata,            --            .readdata
			mm_2_readdatavalid       => CONNECTED_TO_mm_2_readdatavalid,       --            .readdatavalid
			mm_2_waitrequest         => CONNECTED_TO_mm_2_waitrequest,         --            .waitrequest
			mm_2_write               => CONNECTED_TO_mm_2_write,               --            .write
			mm_2_writedata           => CONNECTED_TO_mm_2_writedata,           --            .writedata
			mm_3_address             => CONNECTED_TO_mm_3_address,             --        mm_3.address
			mm_3_burstcount          => CONNECTED_TO_mm_3_burstcount,          --            .burstcount
			mm_3_byteenable          => CONNECTED_TO_mm_3_byteenable,          --            .byteenable
			mm_3_debugaccess         => CONNECTED_TO_mm_3_debugaccess,         --            .debugaccess
			mm_3_read                => CONNECTED_TO_mm_3_read,                --            .read
			mm_3_readdata            => CONNECTED_TO_mm_3_readdata,            --            .readdata
			mm_3_readdatavalid       => CONNECTED_TO_mm_3_readdatavalid,       --            .readdatavalid
			mm_3_waitrequest         => CONNECTED_TO_mm_3_waitrequest,         --            .waitrequest
			mm_3_write               => CONNECTED_TO_mm_3_write,               --            .write
			mm_3_writedata           => CONNECTED_TO_mm_3_writedata,           --            .writedata
			mm_csr_address           => CONNECTED_TO_mm_csr_address,           --      mm_csr.address
			mm_csr_burstcount        => CONNECTED_TO_mm_csr_burstcount,        --            .burstcount
			mm_csr_byteenable        => CONNECTED_TO_mm_csr_byteenable,        --            .byteenable
			mm_csr_debugaccess       => CONNECTED_TO_mm_csr_debugaccess,       --            .debugaccess
			mm_csr_read              => CONNECTED_TO_mm_csr_read,              --            .read
			mm_csr_readdata          => CONNECTED_TO_mm_csr_readdata,          --            .readdata
			mm_csr_readdatavalid     => CONNECTED_TO_mm_csr_readdatavalid,     --            .readdatavalid
			mm_csr_waitrequest       => CONNECTED_TO_mm_csr_waitrequest,       --            .waitrequest
			mm_csr_write             => CONNECTED_TO_mm_csr_write,             --            .write
			mm_csr_writedata         => CONNECTED_TO_mm_csr_writedata,         --            .writedata
			mm_misc_sa_address       => CONNECTED_TO_mm_misc_sa_address,       --  mm_misc_sa.address
			mm_misc_sa_burstcount    => CONNECTED_TO_mm_misc_sa_burstcount,    --            .burstcount
			mm_misc_sa_byteenable    => CONNECTED_TO_mm_misc_sa_byteenable,    --            .byteenable
			mm_misc_sa_debugaccess   => CONNECTED_TO_mm_misc_sa_debugaccess,   --            .debugaccess
			mm_misc_sa_read          => CONNECTED_TO_mm_misc_sa_read,          --            .read
			mm_misc_sa_readdata      => CONNECTED_TO_mm_misc_sa_readdata,      --            .readdata
			mm_misc_sa_readdatavalid => CONNECTED_TO_mm_misc_sa_readdatavalid, --            .readdatavalid
			mm_misc_sa_waitrequest   => CONNECTED_TO_mm_misc_sa_waitrequest,   --            .waitrequest
			mm_misc_sa_write         => CONNECTED_TO_mm_misc_sa_write,         --            .write
			mm_misc_sa_writedata     => CONNECTED_TO_mm_misc_sa_writedata,     --            .writedata
			emif_mmr_address         => CONNECTED_TO_emif_mmr_address,         --    emif_mmr.address
			emif_mmr_burstcount      => CONNECTED_TO_emif_mmr_burstcount,      --            .burstcount
			emif_mmr_byteenable      => CONNECTED_TO_emif_mmr_byteenable,      --            .byteenable
			emif_mmr_debugaccess     => CONNECTED_TO_emif_mmr_debugaccess,     --            .debugaccess
			emif_mmr_read            => CONNECTED_TO_emif_mmr_read,            --            .read
			emif_mmr_readdata        => CONNECTED_TO_emif_mmr_readdata,        --            .readdata
			emif_mmr_readdatavalid   => CONNECTED_TO_emif_mmr_readdatavalid,   --            .readdatavalid
			emif_mmr_waitrequest     => CONNECTED_TO_emif_mmr_waitrequest,     --            .waitrequest
			emif_mmr_write           => CONNECTED_TO_emif_mmr_write,           --            .write
			emif_mmr_writedata       => CONNECTED_TO_emif_mmr_writedata,       --            .writedata
			rst_misc_sa_reset_n      => CONNECTED_TO_rst_misc_sa_reset_n,      -- rst_misc_sa.reset_n
			rst_mm_0_reset_n         => CONNECTED_TO_rst_mm_0_reset_n,         --    rst_mm_0.reset_n
			rst_mm_1_reset_n         => CONNECTED_TO_rst_mm_1_reset_n,         --    rst_mm_1.reset_n
			rst_mm_2_reset_n         => CONNECTED_TO_rst_mm_2_reset_n,         --    rst_mm_2.reset_n
			rst_mm_3_reset_n         => CONNECTED_TO_rst_mm_3_reset_n          --    rst_mm_3.reset_n
		);

