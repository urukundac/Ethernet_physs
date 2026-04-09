# `cnic_wrapper.sv` — Module Explanation

## 1. Overview

`cnic_wrapper` is the **top-level FPGA / emulation wrapper** for a Converged NIC (CNIC) SoC subsystem. It instantiates the main network-controller subsystem (`nac_ss`), generates the emulation clock tree, forces internal clocks and resets for prototyping, and provides per-port Ethernet PHY, I2C, and peripheral infrastructure for up to **NUM_PORTS** (default 8) network ports.

**File:** `src/rtl/cnic_wrapper.sv`
**Lines:** ~2547

---

## 2. Module Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `NUM_PORTS` | 8 | Number of Ethernet ports instantiated in the generate block (PHY + I2C + register bank per port). |
| `SB_MAXPLD_WIDTH_1` | 7 | Maximum sideband payload width (used for IOSF sideband buses). |

---

## 3. Port Interface (Lines 1–68)

The module port list is grouped into several categories:

### 3.1 Clock Inputs
| Signal | Description |
|--------|-------------|
| `clk_tcam_fast` | Fast TCAM lookup clock |
| `xtalclk` | Crystal oscillator reference |
| `infra_clk` | Infrastructure / fabric clock |
| `time_ref_clk_cmos` | CMOS-level time-reference clock |
| `XX_SYS_REFCLK` | System reference clock |
| `CLK_EREF0_P / CLK_EREF0_N` | Differential Ethernet reference clock pair |
| `CLKREF_SYNCE_P / CLKREF_SYNCE_N` | Differential SyncE reference clock pair |
| `ephy_refclk` | Ethernet PHY reference clock (20 MHz, drives the PLL) |
| `spi_debug_clk` | SPI debug interface clock |
| `uart_ref_clk` | UART reference clock |
| `pcie_ref_clk_p / pcie_ref_clk_n` | Differential PCIe reference clock |
| `sfi_clk_1g_in` | SFI 1 Gbps clock input |
| `clk_125mhz[NUM_PORTS-1:0]` | Per-port 125 MHz reference clocks |

### 3.2 Reset
| Signal | Direction | Description |
|--------|-----------|-------------|
| `i_reset` | input | Active-low global reset |
| `sys_rst_n` | input | System reset (active-low) |
| `sn2sfi_rst_n` | input | SFI domain reset |

### 3.3 Per-Port Serial Data (Ethernet)
| Signal | Width | Direction | Description |
|--------|-------|-----------|-------------|
| `rx_serial_data` | `[NUM_PORTS-1:0]` | input | SerDes receive lanes (one per port) |
| `tx_serial_data` | `[NUM_PORTS-1:0]` | output | SerDes transmit lanes (one per port) |

### 3.4 Per-Port I2C / QSFP Management
| Signal | Width | Direction | Description |
|--------|-------|-----------|-------------|
| `I2C_SCL` | `[NUM_PORTS-1:0]` | inout (tri) | I2C clock lines |
| `I2C_SDA` | `[NUM_PORTS-1:0]` | inout (tri) | I2C data lines |
| `I2C_MODSELL` | `[NUM_PORTS-1:0]` | output | Module-select (active-low) |
| `I2C_MODPRSL` | `[NUM_PORTS-1:0]` | input | Module-present (active-low) |
| `I2C_INTL` | `[NUM_PORTS-1:0]` | input | Interrupt (active-low) |
| `I2C_RESETL` | `[NUM_PORTS-1:0]` | output | Module reset (active-low) |
| `I2C_LPMODE` | `[NUM_PORTS-1:0]` | output | Low-power mode |
| `i2c_apb_clk` | `[NUM_PORTS-1:0]` | input | Per-port APB clock for I2C controller |

### 3.5 Conditional SPI Hardware Pins (`ifdef SPI_HW`)
When `SPI_HW` is defined, the module exposes the external SPI flash pins (`XX_SPI_IO_0..3`, `XX_SPI_CLK_O`, `XX_SPI_CS0_N_O`, `XX_SPI_FPGA_SEL_DPN`).

---

## 4. Internal Signal Declarations (Lines 70–1019)

Approximately 950 lines declare internal `logic` / `wire` signals. These fall into the following groups:

| Group | Example Signals | Purpose |
|-------|----------------|---------|
| **Spare / Miscellaneous** | `nac_ss_spare_in/out` | Spare I/O for ECO flexibility |
| **Clock Subsystem (ClockSS) Sideband** | `clockss_boot_pll_iosf_sb_*`, `clockss_nss_pll_*`, `clockss_ts_pll_*`, `clockss_eth_physs_pll_*` | IOSF sideband interfaces to the boot PLL, NSS PLL, timestamp PLL, and Ethernet PHY SS PLL |
| **CML Buffer Sideband** | `clkss_cmlbuf_iosf_sb_intf_*`, `clkss_cmlbuf_phy_ss_*` | CML clock-buffer sideband control |
| **Debug / DFT / DTF** | `nac_ss_debug_*`, `nac_ss_dtf_*`, `nac_ss_tpiu_*` | Debug trace (TPIU), DTF upstream / downstream, APB debug interfaces, CSS600 SWD |
| **IOSF Sideband Post** | `nac_post_iosf_sb_*` | NAC post-silicon sideband interface |
| **Thermal / SVID** | `nac_thermtrip_*`, `svid*`, `NAC_XX_THERM*` | Die thermal sensors, SVID voltage control |
| **Resource Adapter DTS** | `rsrc_adapt_dts_nac{0,1,2}_*` | Digital temperature sensor sideband interfaces (3 instances) |
| **Reset Distribution** | `nac_pwrgood_rst_b`, `inf_rstbus_rst_b`, `early_boot_rst_b`, etc. | Various reset domains |
| **AXI-to-Sideband Bridges** | `axi2sb_gpsb_*`, `axi2sb_pmsb_*` | General-purpose and PM sideband bridges |
| **SFI Link / Data / Header** | `sfi_tx_link_*`, `sfi_tx_hdr_*`, `sfi_tx_data_*`, `sfi_rx_*` | Scalable Fabric Interconnect TX/RX link-layer, header, and data channels (1024-bit data bus) |
| **IOSF2SFI / SN2IOSF Sideband** | `iosf2sfi_sb_*`, `sn2iosf_sb_*` | IOSF-to-SFI and SN-to-IOSF sideband interfaces |
| **APB-to-IOSF Sideband** | `apb2iosfsb_in_*`, `apb2iosfsb_out_*` | APB-to-IOSF sideband bridge signals |
| **GPIO NE 1.8 V Sideband** | `gpio_ne_1p8_in_*`, `gpio_ne_1p8_out_*` | 1.8 V GPIO north-east sideband bus |
| **PCIe PHY Lanes** | `PCIE_RX/TX{0..15}_P/N`, `PCIE_REF_PAD_CLK{0..3}_P/N` | 4 × quad (16 lanes) PCIe differential pairs + reference clocks |
| **Ethernet Analog Lanes** | `ETH_TXP/N{0..15}`, `ETH_RXP/N{0..15}` | 16 differential Ethernet TX/RX analog pairs |
| **BSCAN / JTAG / IJTAG** | `BSCAN_*`, `tms`, `tck`, `tdi`, `trst_b`, `ijtag_*` | Boundary scan, JTAG, and IJTAG test infrastructure |
| **Peripheral I/O** | `XX_SPI_*`, `XX_I2C_*`, `XX_UART_*`, `XX_NCSI_*`, `XX_MDIO_*` | SPI flash, I2C, UART, NC-SI, MDIO interfaces |
| **CFIO / APB** | `cfio_p*`, `i_nmf_t_cnic_physs_gpio_p*` | CFIO pad-ring APB interface |
| **SSN Bus** | `ssn_bus_data_in/out`, `ssn_bus_clock_in` | Supply-sense noise monitoring bus |

---

## 5. Emulation Clock Generation — `fpga_chs_car0` (Lines 1048–1135)

An instance named `nsc_veloce_pll_inst` of `fpga_chs_car0` generates a full clock tree from the 20 MHz `ephy_refclk` input. It produces divided and domain-specific clocks:

| Output Clock | ASIC Freq / Emu Freq | Purpose |
|-------------|----------------------|---------|
| `core_clk` (gclk1_div2) | 900 MHz / ~10 MHz | Core domain for many NSS IPs |
| `nss_cosq_clk` | Same | NSS CoS queue clock |
| `nss_core_clk`, `nss_fxp_clk`, `nss_hif_clk`, `nss_lan_clk` | Same | Various NSS domain clocks |
| `imc_core_clk`, `mt_clk`, `ecm_clk` | Same | IMC, memory-test, ECM clocks |
| `physs_intf0_clk`, `physs_funcx2_clk` | Same | PHY subsystem interface clocks |
| `div_2_clk` (gclk1_div4) | 450 MHz / ~5 MHz | `imc_sys_clk`, `nss_psm_clk`, etc. |
| `div_4_clk` (gclk1_div8) | 250 MHz / ~2.5 MHz | `soc_tsgen_clk`, NCSI clock |
| `div_8_clk` (gclk1_div16) | 112.5 MHz / ~1.25 MHz | `soc_per_clk`, APB bus clock |
| `div_16_clk` (gclk1_div32) | 50 MHz / ~625 kHz | Low-speed peripherals |
| `div_32_clk` (gclk1_div64) | 25 MHz / ~312.5 kHz | DFX clocks |
| `div8_div5_clk` (gclk1_div40) | 20 MHz / ~500 kHz | UART reference clock |

> **Note:** The ASIC frequencies reflect the real silicon clock plan. The emulation frequencies are scaled down by the FPGA PLL from the 20 MHz `ephy_refclk` input. Exact emulation frequencies depend on the `fpga_chs_car0` PLL configuration.

---

## 6. Includes and Static Forces (Lines 1137–1141)

```systemverilog
`include "nsc_assign.sv"      // Signal assignments (Veloce-specific)
`include "tcam_def_forces.sv" // TCAM parameter and clock forces
```

These included files contain emulation-specific assignments and parameter forces for the TCAM subsystem.

---

## 7. Initial Block — Clock and Reset Forces (Lines 1145–1231)

An `initial` block uses `force` statements to drive internal clocks inside the `nac_ss` hierarchy during emulation/prototyping. This bypasses the ASIC PLL/clock-generation logic that does not synthesize to FPGA. Key areas:

1. **NSS clocks** (lines 1158–1197): Forces all NSS domain clocks (`aonclk1x`, `imc_core_clk`, `nss_core_clk`, `nss_lan_clk`, `ecm_clk`, etc.) to the appropriate divided clock from the FPGA PLL.

2. **HLP clocks** (lines 1200–1212, guarded by `ifndef HLP_PHYSS_STUB` / `ifndef NAC_STUB` / `ifndef NMC_ONLY`): Forces HLP block clocks (`pgcb_clk`, `aclk_s`, `ports_clk`, `switch_clk`) and asserts `hlp_rst_b`.

3. **PHY SS clocks** (lines 1215–1227): Forces PHY subsystem clocks (`rclk_diff_p/n`, `soc_per_clk`, `physs_intf0_clk`, `physs_funcx2_clk`, `tsu_clk`, `nss_cosq_clk0/1`, `clk_1588_freq`).

---

## 8. `nac_ss` Instantiation (Lines 1234–2183)

The main subsystem `nac_ss` (NAC Subsystem) is instantiated with the sideband payload width parameter `SB_MAXPLD_WIDTH_1 = 7`. This is the largest instantiation in the file (~950 lines of port connections) and represents the full network-controller SoC.

Key connection patterns:
- **Clocks routed from wrapper ports** or tied to `xtalclk` for unused analog clocks.
- **Resets tied to `sys_rst_n`** (e.g., `nac_pwrgood_rst_b`, `inf_rstbus_rst_b`, `early_boot_rst_b`, `sn2sfi_powergood`, etc.) — simplifying the reset tree for emulation.
- **Debug interfaces tied to zero** (e.g., `nac_ss_debug_snib_apb_*` inputs driven to `0`).
- **ISA clock acknowledgments looped back** (e.g., `.isa_iosf2sfi_isa_clk_ack(iosf2sfi_isa_clk_req)` — immediately acknowledges the clock request).
- **JTAG ports** mostly tied inactive (TMS=0, TCK=0, IJTAG signals=0).
- **Full SFI data path** connected for header (256-bit), data (1024-bit), and link-layer credit-return signals.
- **PCIe x16 lanes** (4 quads × 4 lanes) connected.
- **16 Ethernet differential pairs** connected (ETH_TXP/N0..15, ETH_RXP/N0..15).

---

## 9. SPI Flash Interface (Lines 2186–2258)

### 9.1 When `SPI_HW` Is Defined
- Routes SPI signals to actual FPGA pads via `tristate_buf` instances.
- Directly connects `XX_SPI_CLK_O`, `XX_SPI_CS0_N_O`.

### 9.2 When `SPI_HW` Is NOT Defined
- Routes SPI signals through internal `SIO[3:0]` wires to a **SPI flash behavioral model** (`vps_n25q512a_sm` — Micron N25Q512A flash simulation model).
- The model is parameterized with timing values from `define_n25q512a.sv`.

---

## 10. UART Instance (Lines 2261–2274)

A `RED_VUART` virtual UART transactor is instantiated to connect to the IMC UART (`XX_UART_HMP_RXD` / `XX_UART_HMP_TXD`). An additional HIF UART instance is present but commented out.

---

## 11. Per-Port Generate Block (Lines 2278–2538)

A `generate for (k=0; k<NUM_PORTS; k++)` block instantiates the following **per port**:

### 11.1 Per-Port FPLL — `s10_fpll_ref125Mhz_625Mhz`
Generates a 625 MHz TX serial clock from the per-port 125 MHz reference clock. Provides `fpll_locked_SGMII[k]` lock indicator.

### 11.2 Per-Port IO PLL — `io_pll_125mhz_eth_clks`
Derives two output clocks from the per-port 125 MHz input:
- `pcs_ref_clk_125mhz[k]` — PCS reference
- `onpi_3_125mhz_clk[k]` — additional 125 MHz clock

### 11.3 Per-Port Reset Synchronizer — `IW_sync_reset`
Synchronizes `i_reset` deassert to the per-port `pcs_ref_clk_125mhz[k]` domain.

### 11.4 Per-Port Ethernet PHY — `ethernet_altera_phy`
Connects the PCS reference clock, XCVR serial clock, reset, loopback control, and serial data lanes. Performs the actual 1G Ethernet SerDes and PCS functions.

### 11.5 Per-Port I2C Tristate Buffers
`tristate_buf` instances for `I2C_SCL[k]` and `I2C_SDA[k]` pads implement the open-drain I2C interface.

### 11.6 Per-Port I2C APB Master — `RED_VAPB`
A virtual APB master transactor (`phy_i2c_vapb_master`) drives the I2C controller through APB.

### 11.7 Per-Port I2C Controller — `Imc_DW_apb_i2c`
A DesignWare APB I2C controller (`A00_i2c`) provides I2C master functionality for QSFP/SFP+ module management.

### 11.8 Per-Port PHY Register Bank — `phy_regbank`
Accessed through another `RED_VAPB` APB master, this register bank exposes:
- `phy_config_vector` (5-bit, read-write, default `0x1C`)
- `phy_status_vector` (16-bit, read-only, returns `0xDEADBEEF` truncated)
- Auto-negotiation control/status
- Miscellaneous debug read (`0x12345678`)

---

## 12. Included Forces (Line 2546)

```systemverilog
`include "hlp_physs_forces.sv"
```

This included file contains additional HLP/PHY-SS level force statements for emulation.

---

## 13. Architecture Summary Diagram

```
cnic_wrapper (top)
│
├── fpga_chs_car0 (nsc_veloce_pll_inst)     — FPGA clock tree from 20 MHz
│     └── Generates: core_clk, div_2..div_32, domain-specific clocks
│
├── nac_ss (nac_ss)                           — Main NAC SoC Subsystem
│     ├── nss                                 — Network Switch Subsystem
│     │     ├── IMC (Integrated Management Controller)
│     │     ├── HIF (Host Interface)
│     │     ├── NLF, CoSQ, PSM, SEP, ...
│     │     └── SN2SFI (Switch-Network to SFI bridge)
│     ├── hlp                                 — HLP (Helper/LAN Processor)
│     ├── physs                               — PHY Subsystem
│     ├── par_sn2sfi                          — SFI partition
│     ├── Clock subsystem (ClockSS)
│     ├── Debug/DFT/JTAG infrastructure
│     └── Peripherals (SPI, I2C, UART, GPIO, NCSI, MDIO)
│
├── tristate_buf × 4                          — SPI flash I/O buffers
├── vps_n25q512a_sm (spi_sm)                  — SPI flash behavioral model
│
├── RED_VUART (uart_inst)                     — Virtual UART for IMC
│
└── generate GEN_PORT[0..NUM_PORTS-1]         — Per-port infrastructure
      ├── s10_fpll_ref125Mhz_625Mhz           — TX serial clock PLL
      ├── io_pll_125mhz_eth_clks              — PCS reference clock PLL
      ├── IW_sync_reset                        — Reset synchronizer
      ├── ethernet_altera_phy                  — 1G Ethernet PHY (SerDes + PCS)
      ├── tristate_buf × 2                     — I2C SCL/SDA open-drain buffers
      ├── RED_VAPB (phy_i2c_vapb_master)       — I2C APB master transactor
      ├── Imc_DW_apb_i2c (A00_i2c)            — DesignWare I2C controller
      ├── RED_VAPB (phy_regbank)               — PHY register-bank APB transactor
      └── phy_regbank (u_phy_regbank)          — PHY configuration/status registers
```

---

## 14. Key Design Notes

1. **Emulation/Prototyping Focus**: The extensive use of `force` statements and behavioral models (`RED_VUART`, `RED_VAPB`, `vps_n25q512a_sm`) indicates this wrapper is designed for FPGA prototyping or hardware emulation (e.g., Veloce), not for ASIC synthesis.

2. **Conditional Compilation**: Multiple `ifdef` / `ifndef` guards control feature inclusion:
   - `SPI_HW` — real SPI pads vs. behavioral flash model
   - `HLP_PHYSS_STUB`, `NAC_STUB`, `NMC_ONLY` — stub/partial configurations
   - `ON_BOARD_MEM` — on-board memory initialization

3. **IOSF Sideband**: The design makes heavy use of Intel's IOSF (Intel On-chip System Fabric) sideband protocol for configuration, clock management, and debug access.

4. **SFI (Scalable Fabric Interconnect)**: The 1024-bit data bus with header/credit-return flow control connects the NAC subsystem to the broader SoC fabric.

5. **Multi-Port Scalability**: The `NUM_PORTS` parameter and generate block allow the design to scale from a single port to 8+ ports by changing one parameter.
