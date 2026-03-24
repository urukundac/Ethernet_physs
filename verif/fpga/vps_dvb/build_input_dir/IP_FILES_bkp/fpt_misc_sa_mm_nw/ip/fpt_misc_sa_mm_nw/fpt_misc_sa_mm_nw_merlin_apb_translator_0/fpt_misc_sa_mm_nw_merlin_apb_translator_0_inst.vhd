	component fpt_misc_sa_mm_nw_merlin_apb_translator_0 is
		generic (
			ADDR_WIDTH     : integer := 32;
			DATA_WIDTH     : integer := 32;
			USE_S0_PADDR31 : boolean := false;
			USE_M0_PADDR31 : boolean := false;
			USE_M0_PSLVERR : boolean := false
		);
		port (
			s0_paddr   : in  std_logic_vector(12 downto 0) := (others => 'X'); -- paddr
			s0_psel    : in  std_logic                     := 'X';             -- psel
			s0_penable : in  std_logic                     := 'X';             -- penable
			s0_pwrite  : in  std_logic                     := 'X';             -- pwrite
			s0_pwdata  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- pwdata
			s0_prdata  : out std_logic_vector(31 downto 0);                    -- prdata
			s0_pslverr : out std_logic;                                        -- pslverr
			s0_pready  : out std_logic;                                        -- pready
			clk        : in  std_logic                     := 'X';             -- clk
			reset      : in  std_logic                     := 'X';             -- reset
			m0_paddr   : out std_logic_vector(12 downto 0);                    -- paddr
			m0_psel    : out std_logic;                                        -- psel
			m0_penable : out std_logic;                                        -- penable
			m0_pwrite  : out std_logic;                                        -- pwrite
			m0_pwdata  : out std_logic_vector(31 downto 0);                    -- pwdata
			m0_prdata  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- prdata
			m0_pready  : in  std_logic                     := 'X'              -- pready
		);
	end component fpt_misc_sa_mm_nw_merlin_apb_translator_0;

	u0 : component fpt_misc_sa_mm_nw_merlin_apb_translator_0
		generic map (
			ADDR_WIDTH     => INTEGER_VALUE_FOR_ADDR_WIDTH,
			DATA_WIDTH     => INTEGER_VALUE_FOR_DATA_WIDTH,
			USE_S0_PADDR31 => BOOLEAN_VALUE_FOR_USE_S0_PADDR31,
			USE_M0_PADDR31 => BOOLEAN_VALUE_FOR_USE_M0_PADDR31,
			USE_M0_PSLVERR => BOOLEAN_VALUE_FOR_USE_M0_PSLVERR
		)
		port map (
			s0_paddr   => CONNECTED_TO_s0_paddr,   --        s0.paddr
			s0_psel    => CONNECTED_TO_s0_psel,    --          .psel
			s0_penable => CONNECTED_TO_s0_penable, --          .penable
			s0_pwrite  => CONNECTED_TO_s0_pwrite,  --          .pwrite
			s0_pwdata  => CONNECTED_TO_s0_pwdata,  --          .pwdata
			s0_prdata  => CONNECTED_TO_s0_prdata,  --          .prdata
			s0_pslverr => CONNECTED_TO_s0_pslverr, --          .pslverr
			s0_pready  => CONNECTED_TO_s0_pready,  --          .pready
			clk        => CONNECTED_TO_clk,        --       clk.clk
			reset      => CONNECTED_TO_reset,      -- clk_reset.reset
			m0_paddr   => CONNECTED_TO_m0_paddr,   --        m0.paddr
			m0_psel    => CONNECTED_TO_m0_psel,    --          .psel
			m0_penable => CONNECTED_TO_m0_penable, --          .penable
			m0_pwrite  => CONNECTED_TO_m0_pwrite,  --          .pwrite
			m0_pwdata  => CONNECTED_TO_m0_pwdata,  --          .pwdata
			m0_prdata  => CONNECTED_TO_m0_prdata,  --          .prdata
			m0_pready  => CONNECTED_TO_m0_pready   --          .pready
		);

