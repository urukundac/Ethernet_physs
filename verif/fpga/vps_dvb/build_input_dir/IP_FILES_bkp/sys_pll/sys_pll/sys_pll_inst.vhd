	component sys_pll is
		port (
			rst              : in  std_logic                    := 'X';             -- reset
			refclk           : in  std_logic                    := 'X';             -- clk
			locked           : out std_logic;                                       -- export
			scanclk          : in  std_logic                    := 'X';             -- clk
			phase_en         : in  std_logic                    := 'X';             -- phase_en
			updn             : in  std_logic                    := 'X';             -- updn
			cntsel           : in  std_logic_vector(4 downto 0) := (others => 'X'); -- cntsel
			phase_done       : out std_logic;                                       -- phase_done
			num_phase_shifts : in  std_logic_vector(2 downto 0) := (others => 'X'); -- num_phase_shifts
			outclk_0         : out std_logic;                                       -- clk
			outclk_1         : out std_logic;                                       -- clk
			outclk_2         : out std_logic;                                       -- clk
			outclk_3         : out std_logic;                                       -- clk
			outclk_4         : out std_logic;                                       -- clk
			outclk_5         : out std_logic;                                       -- clk
			outclk_6         : out std_logic;                                       -- clk
			outclk_7         : out std_logic                                        -- clk
		);
	end component sys_pll;

	u0 : component sys_pll
		port map (
			rst              => CONNECTED_TO_rst,              --            reset.reset
			refclk           => CONNECTED_TO_refclk,           --           refclk.clk
			locked           => CONNECTED_TO_locked,           --           locked.export
			scanclk          => CONNECTED_TO_scanclk,          --          scanclk.clk
			phase_en         => CONNECTED_TO_phase_en,         --         phase_en.phase_en
			updn             => CONNECTED_TO_updn,             --             updn.updn
			cntsel           => CONNECTED_TO_cntsel,           --           cntsel.cntsel
			phase_done       => CONNECTED_TO_phase_done,       --       phase_done.phase_done
			num_phase_shifts => CONNECTED_TO_num_phase_shifts, -- num_phase_shifts.num_phase_shifts
			outclk_0         => CONNECTED_TO_outclk_0,         --          outclk0.clk
			outclk_1         => CONNECTED_TO_outclk_1,         --          outclk1.clk
			outclk_2         => CONNECTED_TO_outclk_2,         --          outclk2.clk
			outclk_3         => CONNECTED_TO_outclk_3,         --          outclk3.clk
			outclk_4         => CONNECTED_TO_outclk_4,         --          outclk4.clk
			outclk_5         => CONNECTED_TO_outclk_5,         --          outclk5.clk
			outclk_6         => CONNECTED_TO_outclk_6,         --          outclk6.clk
			outclk_7         => CONNECTED_TO_outclk_7          --          outclk7.clk
		);

