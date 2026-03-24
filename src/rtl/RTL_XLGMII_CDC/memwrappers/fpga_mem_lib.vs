//=============================================================================
//  Copyright (c) 2013-2014 Intel Corporation, all rights reserved.
//  THIS PROGRAM IS AN UNPUBLISHED WORK FULLY PROTECTED BY
//  COPYRIGHT LAWS AND IS CONSIDERED A TRADE SECRET BELONGING
//  TO THE INTEL CORPORATION.
//
//  Intel Confidential
//=============================================================================
//
// MOAD Begin
//
//  block                                        : fpga_mem_lib.vs
//  blocktype [fub|hier|shared|module|inst]      : shared
//  design_style [ebb|na|rls]                    : na
//  circuit_style [analog|lsa|na|ROM|ssa|sdp]    : na
//  circuit_owner [userid|na]                    : na
//  cluster [arr|bus|fec|fpc|iec|mec]            : common
//  unit                                         : none
//  part_name                                    : TBD
//  part_owner [userid|na]                       : na
//  rtl_owner [userid]                           : TBD
//
// MOAD End
//
// Current RTL Owner : balaji.g@intel.com
// Original RTL Owner: madhusudanan.seshadri@intel.com
//
//=============================================================================
//
// Description:
//   This file represents the Altera FPGA view of atom_mem.vs
//   
//=============================================================================

// Only 1r1w memories can be mapped to FPGA BRAM 
// hence declare 25 1r1w memories to cover the max supported atom_mem size in GLP (5r5w)

// TNT can have WR_SEGS >= RD_SEGS or can have WR_SEGS < RD_SEGS too
// Always WR_SEGS*WR_SEGSZ == RD_SEGS*RD_SEGSZ is same but width of single seg mem for r/w cannot be same)
// since fpga does not support bit writes each segsz should have separate
// memories. So its better to operate in lowest seg size of rd or wr 

   localparam F_SEGS  = (WR_SEGS > RD_SEGS) ? WR_SEGS : RD_SEGS;
   localparam F_SEGSZ = (WR_SEGS > RD_SEGS) ? WR_SEGSZ: RD_SEGSZ;


   logic [F_SEGS-1:0][F_SEGSZ-1:0] fidinp0, fidinp1, fidinp2, fidinp3, fidinp4, fidinp5, fidinp6, fidinp7;
   logic [(F_SEGS*F_SEGSZ)-1:0] fidinp0tmp, fidinp1tmp, fidinp2tmp, fidinp3tmp, fidinp4tmp, fidinp5tmp, fidinp6tmp, fidinp7tmp;
   logic [F_SEGS-1 :0] fwenp0,fwenp1,fwenp2,fwenp3,fwenp4,fwenp5,fwenp6,fwenp7;
   logic [RD_PORTS-1:0][F_SEGS-1:0][F_SEGSZ-1:0] fodoutp0, fodoutp1, fodoutp2, fodoutp3, fodoutp4, fodoutp5,fodoutp6,fodoutp7;
   logic [F_SEGS-1:0][F_SEGSZ-1:0] ffodoutp0, ffodoutp1, ffodoutp2, ffodoutp3, ffodoutp4, ffodoutp5,ffodoutp6, ffodoutp7,ffodoutp8, ffodoutp9, ffodoutp10, ffodoutp11;
   logic [(F_SEGS*F_SEGSZ)-1:0] ffodoutp0tmp, ffodoutp1tmp, ffodoutp2tmp, ffodoutp3tmp, ffodoutp4tmp, ffodoutp5tmp, ffodoutp6tmp, ffodoutp7tmp, ffodoutp8tmp, ffodoutp9tmp, ffodoutp10tmp, ffodoutp11tmp;
   logic [F_SEGS-1 :0] frenp0,frenp1,frenp2,frenp3,frenp4,frenp5,frenp6,frenp7,frenp8,frenp9,frenp10,frenp11;
   logic [((WR_PORTS > 1) ? $clog2(WR_PORTS)-1:0):0] track[F_SEGS-1:0][WORDS-1 :0];

   logic [WIDTH-1:0] rom_array[WORDS-1:0] /*synthesis syn_romstyle="block_rom"*/;
   logic [WIDTH-1:0] romoutp0;
   logic [RD_SEGS-1:0][RD_SEGSZ-1:0] odoutp0frz, odoutp1frz, odoutp2frz, odoutp3frz, odoutp4frz,odoutp5frz, odoutp6frz, odoutp7frz, odoutp8frz,odoutp9frz, odoutp10frz, odoutp11frz ;
   logic [F_SEGS-1 :0] renp0frz,renp1frz,renp2frz,renp3frz,renp4frz,renp5frz, renp6frz, renp7frz, renp8frz, renp9frz, renp10frz, renp11frz;
   logic [WORDLOG2-1:0] arp0_r, arp1_r, arp2_r, arp3_r, arp4_r, arp5_r, arp6_r, arp7_r, arp8_r, arp9_r, arp10_r, arp11_r ;
   logic [RD_PORTS-1:0][WORDLOG2-1:0] arp;
   logic [RD_PORTS-1:0][F_SEGS-1 :0] frenp;

// Pack fidinp from idinp depending on seg & segsz
always_comb begin
  // unpack data into single variable 
  for (int unsigned seg=0; seg<WR_SEGS; seg++) begin
    for (int unsigned segsz=0; segsz<WR_SEGSZ; segsz++) begin
      fidinp0tmp[(seg*WR_SEGSZ)+segsz]  = idinp0[seg][segsz];
      fidinp1tmp[(seg*WR_SEGSZ)+segsz]  = idinp1[seg][segsz];
      fidinp2tmp[(seg*WR_SEGSZ)+segsz]  = idinp2[seg][segsz];
      fidinp3tmp[(seg*WR_SEGSZ)+segsz]  = idinp3[seg][segsz];
      fidinp4tmp[(seg*WR_SEGSZ)+segsz]  = idinp4[seg][segsz];
      fidinp5tmp[(seg*WR_SEGSZ)+segsz]  = idinp5[seg][segsz];
      fidinp6tmp[(seg*WR_SEGSZ)+segsz]  = idinp6[seg][segsz];
      fidinp7tmp[(seg*WR_SEGSZ)+segsz]  = idinp7[seg][segsz];
    end
  end
end

always_comb begin
  // pack into new F_SEGS and F_SEGSZ
  for (int unsigned seg=0; seg<F_SEGS; seg++) begin
    for (int unsigned segsz=0; segsz<F_SEGSZ; segsz++) begin
      fidinp0[seg][segsz]  = fidinp0tmp[(seg*F_SEGSZ)+segsz];
      fidinp1[seg][segsz]  = fidinp1tmp[(seg*F_SEGSZ)+segsz];
      fidinp2[seg][segsz]  = fidinp2tmp[(seg*F_SEGSZ)+segsz];
      fidinp3[seg][segsz]  = fidinp3tmp[(seg*F_SEGSZ)+segsz];
      fidinp4[seg][segsz]  = fidinp4tmp[(seg*F_SEGSZ)+segsz];
      fidinp5[seg][segsz]  = fidinp5tmp[(seg*F_SEGSZ)+segsz];
      fidinp6[seg][segsz]  = fidinp6tmp[(seg*F_SEGSZ)+segsz];
      fidinp7[seg][segsz]  = fidinp7tmp[(seg*F_SEGSZ)+segsz];
    end
  end
end
   
// Pack fwenp from wenp depending on seg
generate
  if ( WR_SEGS >= RD_SEGS ) begin
    always_comb begin
      fwenp0    = wenp0;
      fwenp1    = wenp1;
      fwenp2    = wenp2;
      fwenp3    = wenp3;
      fwenp4    = wenp4;
      fwenp5    = wenp5;
      fwenp6    = wenp6;
      fwenp7    = wenp7;
    end
  end
  else begin
    always_comb begin
      for (int unsigned bitsz=0; bitsz<WR_SEGS; bitsz++) begin
        fwenp0[bitsz*(RD_SEGS/WR_SEGS)+:(RD_SEGS/WR_SEGS)]   = {RD_SEGS/WR_SEGS{wenp0[bitsz]}};
        fwenp1[bitsz*(RD_SEGS/WR_SEGS)+:(RD_SEGS/WR_SEGS)]   = {RD_SEGS/WR_SEGS{wenp1[bitsz]}};
        fwenp2[bitsz*(RD_SEGS/WR_SEGS)+:(RD_SEGS/WR_SEGS)]   = {RD_SEGS/WR_SEGS{wenp2[bitsz]}};
        fwenp3[bitsz*(RD_SEGS/WR_SEGS)+:(RD_SEGS/WR_SEGS)]   = {RD_SEGS/WR_SEGS{wenp3[bitsz]}};
        fwenp4[bitsz*(RD_SEGS/WR_SEGS)+:(RD_SEGS/WR_SEGS)]   = {RD_SEGS/WR_SEGS{wenp4[bitsz]}};
        fwenp5[bitsz*(RD_SEGS/WR_SEGS)+:(RD_SEGS/WR_SEGS)]   = {RD_SEGS/WR_SEGS{wenp5[bitsz]}};
        fwenp6[bitsz*(RD_SEGS/WR_SEGS)+:(RD_SEGS/WR_SEGS)]   = {RD_SEGS/WR_SEGS{wenp6[bitsz]}};
        fwenp7[bitsz*(RD_SEGS/WR_SEGS)+:(RD_SEGS/WR_SEGS)]   = {RD_SEGS/WR_SEGS{wenp7[bitsz]}};
      end
    end
  end
endgenerate

   
// pack renp to new size
generate
  if ( WR_SEGS <= RD_SEGS ) begin
    always_comb begin
      frenp0    = renp0;
      frenp1    = renp1;
      frenp2    = renp2;
      frenp3    = renp3;
      frenp4    = renp4;
      frenp5    = renp5;
      frenp6    = renp6;
      frenp7    = renp7;
      frenp8    = renp8;
      frenp9    = renp9;
      frenp10    = renp10;
      frenp11    = renp11;
    end
  end
  else begin
    always_comb begin
      for (int unsigned bitsz=0; bitsz<RD_SEGS; bitsz++) begin
        frenp0[bitsz*(WR_SEGS/RD_SEGS)+:(WR_SEGS/RD_SEGS)]   = {WR_SEGS/RD_SEGS{renp0[bitsz]}};
        frenp1[bitsz*(WR_SEGS/RD_SEGS)+:(WR_SEGS/RD_SEGS)]   = {WR_SEGS/RD_SEGS{renp1[bitsz]}};
        frenp2[bitsz*(WR_SEGS/RD_SEGS)+:(WR_SEGS/RD_SEGS)]   = {WR_SEGS/RD_SEGS{renp2[bitsz]}};
        frenp3[bitsz*(WR_SEGS/RD_SEGS)+:(WR_SEGS/RD_SEGS)]   = {WR_SEGS/RD_SEGS{renp3[bitsz]}};
        frenp4[bitsz*(WR_SEGS/RD_SEGS)+:(WR_SEGS/RD_SEGS)]   = {WR_SEGS/RD_SEGS{renp4[bitsz]}};
        frenp5[bitsz*(WR_SEGS/RD_SEGS)+:(WR_SEGS/RD_SEGS)]   = {WR_SEGS/RD_SEGS{renp5[bitsz]}};
        frenp6[bitsz*(WR_SEGS/RD_SEGS)+:(WR_SEGS/RD_SEGS)]   = {WR_SEGS/RD_SEGS{renp6[bitsz]}};
        frenp7[bitsz*(WR_SEGS/RD_SEGS)+:(WR_SEGS/RD_SEGS)]   = {WR_SEGS/RD_SEGS{renp7[bitsz]}};
        frenp8[bitsz*(WR_SEGS/RD_SEGS)+:(WR_SEGS/RD_SEGS)]   = {WR_SEGS/RD_SEGS{renp8[bitsz]}};
        frenp9[bitsz*(WR_SEGS/RD_SEGS)+:(WR_SEGS/RD_SEGS)]   = {WR_SEGS/RD_SEGS{renp9[bitsz]}};
        frenp10[bitsz*(WR_SEGS/RD_SEGS)+:(WR_SEGS/RD_SEGS)]   = {WR_SEGS/RD_SEGS{renp10[bitsz]}};
        frenp11[bitsz*(WR_SEGS/RD_SEGS)+:(WR_SEGS/RD_SEGS)]   = {WR_SEGS/RD_SEGS{renp11[bitsz]}};
      end
    end
  end
endgenerate

// pack arp and renp into array so that depending on RD_PORTS the memory connection is done.
// all assignments are made under generate statements to conditionally generate required code
assign arp[0] = arp0;
genvar i_RD_PORTS;
generate
  for(i_RD_PORTS=2; i_RD_PORTS<=RD_PORTS;i_RD_PORTS++)
  begin
    if(i_RD_PORTS == 2) assign arp[1] = arp1;
    if(i_RD_PORTS == 3) assign arp[2] = arp2;
    if(i_RD_PORTS == 4) assign arp[3] = arp3;
    if(i_RD_PORTS == 5) assign arp[4] = arp4;
    if(i_RD_PORTS == 6) assign arp[5] = arp5;
    if(i_RD_PORTS == 7) assign arp[6] = arp6;
    if(i_RD_PORTS == 8) assign arp[7] = arp7;
    if(i_RD_PORTS == 9) assign arp[8] = arp8;
    if(i_RD_PORTS == 10) assign arp[9] = arp9;
    if(i_RD_PORTS == 11) assign arp[10] = arp10;
    if(i_RD_PORTS == 12) assign arp[11] = arp11;
  end

  always_comb 
    for (int unsigned seg=0; seg<F_SEGS; seg++) 
      frenp[0][seg] = frenp0[seg];

  for(i_RD_PORTS=2; i_RD_PORTS<=RD_PORTS;i_RD_PORTS++)
  begin
    if(i_RD_PORTS == 2)
      always_comb 
        for (int unsigned seg=0; seg<F_SEGS; seg++)
          frenp[1][seg] = frenp1[seg];
    if(i_RD_PORTS == 3)
      always_comb 
        for (int unsigned seg=0; seg<F_SEGS; seg++)
          frenp[2][seg] = frenp2[seg];
    if(i_RD_PORTS == 4)
      always_comb
        for (int unsigned seg=0; seg<F_SEGS; seg++)
          frenp[3][seg] = frenp3[seg];
    if(i_RD_PORTS == 5)
      always_comb 
        for (int unsigned seg=0; seg<F_SEGS; seg++)
          frenp[4][seg] = frenp4[seg];
    if(i_RD_PORTS == 6)
      always_comb 
        for (int unsigned seg=0; seg<F_SEGS; seg++)
          frenp[5][seg] = frenp5[seg];
    if(i_RD_PORTS == 7)
      always_comb 
        for (int unsigned seg=0; seg<F_SEGS; seg++)
          frenp[6][seg] = frenp6[seg];
    if(i_RD_PORTS == 8)
      always_comb 
        for (int unsigned seg=0; seg<F_SEGS; seg++)
          frenp[7][seg] = frenp7[seg];
    if(i_RD_PORTS == 9)
      always_comb 
        for (int unsigned seg=0; seg<F_SEGS; seg++)
          frenp[8][seg] = frenp8[seg];
    if(i_RD_PORTS == 10)
      always_comb 
        for (int unsigned seg=0; seg<F_SEGS; seg++)
          frenp[9][seg] = frenp9[seg];
    if(i_RD_PORTS == 11)
      always_comb 
        for (int unsigned seg=0; seg<F_SEGS; seg++)
          frenp[10][seg] = frenp10[seg];
    if(i_RD_PORTS == 12)
      always_comb 
        for (int unsigned seg=0; seg<F_SEGS; seg++)
          frenp[11][seg] = frenp11[seg];
  end

endgenerate

// Pack odoutp 
if (WR_PORTS == 0) begin : gen_rom
`ifndef FPGA_ALTERA_RAM
   if(ROM_FILE_TYPE == "HEX")
      initial $readmemh(ROM_LOAD_FILE, rom_array);
   else
      initial $readmemb(ROM_LOAD_FILE, rom_array);

   assign romoutp0 = rom_array[arp0_r];
`else
// Synplify not auto infering BRAM for ROM case
       altsyncram      altsyncram_component (
                                .address_a (arp0),
                                .byteena_a (1'b1),
                                .clock0 (ckrd),
                                .data_a ({WIDTH{1'b0}}),
                                .wren_a (1'b0),
                                .rden_a (1'b1),
                                .q_a (romoutp0),
                                .aclr0 (1'b0),
                                .aclr1 (1'b0),
                                .address_b (1'b1),
                                .addressstall_a (1'b0),
                                .addressstall_b (1'b0),
                                .byteena_b (1'b1),
                                .clock1 (1'b1),
                                .clocken0 (1'b1),
                                .clocken1 (1'b1),
                                .clocken2 (1'b1),
                                .clocken3 (1'b1),
                                .data_b (1'b1),
                                .eccstatus (),
                                .q_b (),
                                .rden_b (1'b1),
                                .wren_b (1'b0));
        defparam
                altsyncram_component.clock_enable_input_a = "NORMAL",
                altsyncram_component.clock_enable_output_a = "NORMAL",
                altsyncram_component.init_file =  ROM_LOAD_FILE,
                altsyncram_component.intended_device_family = "Stratix V",
                altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",
                altsyncram_component.lpm_type = "altsyncram",
                altsyncram_component.numwords_a = WORDS,
                altsyncram_component.operation_mode = "SINGLE_PORT",
                altsyncram_component.outdata_aclr_a = "NONE",
                altsyncram_component.outdata_reg_a = "UNREGISTERED",
                altsyncram_component.power_up_uninitialized = "FALSE",
                altsyncram_component.read_during_write_mode_port_a = "NEW_DATA_NO_NBE_READ",
                altsyncram_component.widthad_a = WORDLOG2,
                altsyncram_component.width_a = WIDTH;

`endif

end : gen_rom

// Pack odoutp  and also support ROM 
  always_comb begin
    // unpack data into single variable 
    for (int unsigned seg=0; seg<F_SEGS; seg++) begin
      for (int unsigned segsz=0; segsz<F_SEGSZ; segsz++) begin
        ffodoutp0tmp[(seg*F_SEGSZ)+segsz]  = ffodoutp0[seg][segsz];
        ffodoutp1tmp[(seg*F_SEGSZ)+segsz]  = ffodoutp1[seg][segsz];
        ffodoutp2tmp[(seg*F_SEGSZ)+segsz]  = ffodoutp2[seg][segsz];
        ffodoutp3tmp[(seg*F_SEGSZ)+segsz]  = ffodoutp3[seg][segsz];
        ffodoutp4tmp[(seg*F_SEGSZ)+segsz]  = ffodoutp4[seg][segsz];
        ffodoutp5tmp[(seg*F_SEGSZ)+segsz]  = ffodoutp5[seg][segsz];
        ffodoutp6tmp[(seg*F_SEGSZ)+segsz]  = ffodoutp6[seg][segsz];
        ffodoutp7tmp[(seg*F_SEGSZ)+segsz]  = ffodoutp7[seg][segsz];
        ffodoutp8tmp[(seg*F_SEGSZ)+segsz]  = ffodoutp8[seg][segsz];
        ffodoutp9tmp[(seg*F_SEGSZ)+segsz]  = ffodoutp9[seg][segsz];
        ffodoutp10tmp[(seg*F_SEGSZ)+segsz]  = ffodoutp10[seg][segsz];
        ffodoutp11tmp[(seg*F_SEGSZ)+segsz]  = ffodoutp11[seg][segsz];
      end
    end
  end
    // pack into new F_SEGS and F_SEGSZ
  always_comb begin
    for (int unsigned seg=0; seg<RD_SEGS; seg++) begin
      for (int unsigned segsz=0; segsz<RD_SEGSZ; segsz++) begin
        s_odoutp0[seg][segsz]  = (WR_PORTS==0) ? romoutp0[(seg*RD_SEGSZ)+segsz] :
                               (renp0frz[seg]==1) ? ffodoutp0tmp[(seg*RD_SEGSZ)+segsz] :
                                odoutp0frz[seg][segsz];
        s_odoutp1[seg][segsz]  = (renp1frz[seg]==1) ? ffodoutp1tmp[(seg*RD_SEGSZ)+segsz] :
                                odoutp1frz[seg][segsz];
        s_odoutp2[seg][segsz]  = (renp2frz[seg]==1) ? ffodoutp2tmp[(seg*RD_SEGSZ)+segsz] :
                                odoutp2frz[seg][segsz];
        s_odoutp3[seg][segsz]  = (renp3frz[seg]==1) ? ffodoutp3tmp[(seg*RD_SEGSZ)+segsz] :
                                odoutp3frz[seg][segsz];
        s_odoutp4[seg][segsz]  = (renp4frz[seg]==1) ? ffodoutp4tmp[(seg*RD_SEGSZ)+segsz] :
                                odoutp4frz[seg][segsz];
        s_odoutp5[seg][segsz]  = (renp5frz[seg]==1) ? ffodoutp5tmp[(seg*RD_SEGSZ)+segsz] :
                                odoutp5frz[seg][segsz];
        s_odoutp6[seg][segsz]  = (renp6frz[seg]==1) ? ffodoutp6tmp[(seg*RD_SEGSZ)+segsz] :
                                odoutp6frz[seg][segsz];
        s_odoutp7[seg][segsz]  = (renp7frz[seg]==1) ? ffodoutp7tmp[(seg*RD_SEGSZ)+segsz] :
                                odoutp7frz[seg][segsz];
        s_odoutp8[seg][segsz]  = (renp8frz[seg]==1) ? ffodoutp8tmp[(seg*RD_SEGSZ)+segsz] :
                                odoutp8frz[seg][segsz];
        s_odoutp9[seg][segsz]  = (renp9frz[seg]==1) ? ffodoutp9tmp[(seg*RD_SEGSZ)+segsz] :
                                odoutp9frz[seg][segsz];
        s_odoutp10[seg][segsz]  = (renp10frz[seg]==1) ? ffodoutp10tmp[(seg*RD_SEGSZ)+segsz] :
                                odoutp10frz[seg][segsz];
        s_odoutp11[seg][segsz]  = (renp11frz[seg]==1) ? ffodoutp11tmp[(seg*RD_SEGSZ)+segsz] :
                                odoutp11frz[seg][segsz];
      end
    end
  end

// Freeze last data on the odoutp ports. They might toggle due to track sel
// after renp window is over

  always_ff @(posedge ckrd) begin
    renp0frz    <= renp0;
    renp1frz    <= renp1;
    renp2frz    <= renp2;
    renp3frz    <= renp3;
    renp4frz    <= renp4;
    renp5frz    <= renp5;
    renp6frz    <= renp6;
    renp7frz    <= renp7;
    renp8frz    <= renp8;
    renp9frz    <= renp9;
    renp10frz    <= renp10;
    renp11frz    <= renp11;

    for (int unsigned seg=0; seg<RD_SEGS; seg++) begin
      if (renp0frz[seg]) odoutp0frz[seg] <= s_odoutp0[seg];
      if (renp1frz[seg]) odoutp1frz[seg] <= s_odoutp1[seg];
      if (renp2frz[seg]) odoutp2frz[seg] <= s_odoutp2[seg];
      if (renp3frz[seg]) odoutp3frz[seg] <= s_odoutp3[seg];
      if (renp4frz[seg]) odoutp4frz[seg] <= s_odoutp4[seg];
      if (renp5frz[seg]) odoutp5frz[seg] <= s_odoutp5[seg];
      if (renp6frz[seg]) odoutp6frz[seg] <= s_odoutp6[seg];
      if (renp7frz[seg]) odoutp7frz[seg] <= s_odoutp7[seg];
      if (renp8frz[seg]) odoutp8frz[seg] <= s_odoutp8[seg];
      if (renp9frz[seg]) odoutp9frz[seg] <= s_odoutp9[seg];
      if (renp10frz[seg]) odoutp10frz[seg] <= s_odoutp10[seg];
      if (renp11frz[seg]) odoutp11frz[seg] <= s_odoutp11[seg];
    end
    
  end

// altsyncram only take integer value for its parameter
localparam integer RAM_ADDR_WDTH = ADDR_WDTH;
localparam integer RAM_WORDS = WORDS;

genvar RP,SEG,RSEG;
generate
  // 25 memories are again segmented based on F_SEGS
  for (SEG = 0; SEG < F_SEGS; SEG++) begin : SEG_MEM
  // every read port has a memory for a write port
   // for e.g if mem is 5wr6 then each rd port will have 5 memories. A track
   // mem to select final rd data from last mem write
    for (RP =0; RP < RD_PORTS; RP++ )  begin : RP_MEM
     // Not using generate statement since the physical port name is diff for each port. 
     // unused port memories will be removed by synth tool

     if (WR_PORTS > 0) begin
       fpgamem #(.ADDR_WD ( RAM_ADDR_WDTH ),
                 .DATA_WD ( F_SEGSZ ) ) ram0 (
         .ckwr      ( ckwr ),
         .wr        ( fwenp0[SEG] ),
         .wrptr     ( awp0 ),
         .datain    ( fidinp0[SEG] ),
         .ckrd      ( ckrd ),
         .rd        ( frenp[RP][SEG] ),
         .rdptr     ( arp[RP] ),
         .dataout   ( fodoutp0[RP][SEG] )
       );
     end

        
     if (WR_PORTS > 1) begin
       fpgamem #(.ADDR_WD ( RAM_ADDR_WDTH ),
                 .DATA_WD ( F_SEGSZ ) ) ram1 (
         .ckwr      ( ckwr ),
         .wr        ( fwenp1[SEG] ),
         .wrptr     ( awp1 ),
         .datain    ( fidinp1[SEG] ),
         .ckrd      ( ckrd ),
         .rd        ( frenp[RP][SEG] ),
         .rdptr     ( arp[RP] ),
         .dataout   ( fodoutp1[RP][SEG] )
       );
     end
         
     if (WR_PORTS > 2) begin
       fpgamem #(.ADDR_WD ( RAM_ADDR_WDTH ),
                 .DATA_WD ( F_SEGSZ ) ) ram2 (
         .ckwr      ( ckwr ),
         .wr        ( fwenp2[SEG] ),
         .wrptr     ( awp2 ),
         .datain    ( fidinp2[SEG] ),
         .ckrd      ( ckrd ),
         .rd        ( frenp[RP][SEG] ),
         .rdptr     ( arp[RP] ),
         .dataout   ( fodoutp2[RP][SEG] )
       );
     end
         
     if (WR_PORTS > 3) begin
       fpgamem #(.ADDR_WD ( RAM_ADDR_WDTH ),
                 .DATA_WD ( F_SEGSZ ) ) ram3 (
         .ckwr      ( ckwr ),
         .wr        ( fwenp3[SEG] ),
         .wrptr     ( awp3 ),
         .datain    ( fidinp3[SEG] ),
         .ckrd      ( ckrd ),
         .rd        ( frenp[RP][SEG] ),
         .rdptr     ( arp[RP] ),
         .dataout   ( fodoutp3[RP][SEG] )
       );
     end
         
     if (WR_PORTS > 4) begin
       fpgamem #(.ADDR_WD ( RAM_ADDR_WDTH ),
                 .DATA_WD ( F_SEGSZ ) ) ram4 (
         .ckwr      ( ckwr ),
         .wr        ( fwenp4[SEG] ),
         .wrptr     ( awp4 ),
         .datain    ( fidinp4[SEG] ),
         .ckrd      ( ckrd ),
         .rd        ( frenp[RP][SEG] ),
         .rdptr     ( arp[RP] ),
         .dataout   ( fodoutp4[RP][SEG] )
       );
     end
   
  if (WR_PORTS > 5) begin
       fpgamem #(.ADDR_WD ( RAM_ADDR_WDTH ),
                 .DATA_WD ( F_SEGSZ ) ) ram5 (
         .ckwr      ( ckwr ),
         .wr        ( fwenp5[SEG] ),
         .wrptr     ( awp5 ),
         .datain    ( fidinp5[SEG] ),
         .ckrd      ( ckrd ),
         .rd        ( frenp[RP][SEG] ),
         .rdptr     ( arp[RP] ),
         .dataout   ( fodoutp5[RP][SEG] )
       );
     end

  if (WR_PORTS > 6) begin
       fpgamem #(.ADDR_WD ( RAM_ADDR_WDTH ),
                 .DATA_WD ( F_SEGSZ ) ) ram6 (
         .ckwr      ( ckwr ),
         .wr        ( fwenp6[SEG] ),
         .wrptr     ( awp6 ),
         .datain    ( fidinp6[SEG] ),
         .ckrd      ( ckrd ),
         .rd        ( frenp[RP][SEG] ),
         .rdptr     ( arp[RP] ),
         .dataout   ( fodoutp6[RP][SEG] )
       );
     end

  if (WR_PORTS > 7) begin
       fpgamem #(.ADDR_WD ( RAM_ADDR_WDTH ),
                 .DATA_WD ( F_SEGSZ ) ) ram7 (
         .ckwr      ( ckwr ),
         .wr        ( fwenp7[SEG] ),
         .wrptr     ( awp7 ),
         .datain    ( fidinp7[SEG] ),
         .ckrd      ( ckrd ),
         .rd        ( frenp[RP][SEG] ),
         .rdptr     ( arp[RP] ),
         .dataout   ( fodoutp7[RP][SEG] )
       );
     end

    end // for generate RP_MEM

     // tracker memory which marks the wr port number for each addr location
     // so that while read the latest mem is picked up
     if (WR_PORTS > 1)
        always_ff @ (posedge ckwr)
          // assumption multi port don't write on same address on the same clk
          for (int unsigned addr=0; addr < WORDS; addr++ ) begin
            if (WR_PORTS > 0 && fwenp0[SEG] && (awp0==addr)) track[SEG][addr] <= 0;
            if (WR_PORTS > 1 && fwenp1[SEG] && (awp1==addr)) track[SEG][addr] <= 1;
            if (WR_PORTS > 2 && fwenp2[SEG] && (awp2==addr)) track[SEG][addr] <= 2;
            if (WR_PORTS > 3 && fwenp3[SEG] && (awp3==addr)) track[SEG][addr] <= 3;
            if (WR_PORTS > 4 && fwenp4[SEG] && (awp4==addr)) track[SEG][addr] <= 4;
            if (WR_PORTS > 5 && fwenp5[SEG] && (awp5==addr)) track[SEG][addr] <= 5;
            if (WR_PORTS > 6 && fwenp6[SEG] && (awp6==addr)) track[SEG][addr] <= 6;
            if (WR_PORTS > 7 && fwenp7[SEG] && (awp7==addr)) track[SEG][addr] <= 7;
          end // for

    end // for SEG_MEM

// sync the track memory content to data availability from ram.
  always_ff @(posedge ckrd) begin
    arp0_r   <= arp0;
    arp1_r   <= arp1;
    arp2_r   <= arp2;
    arp3_r   <= arp3;
    arp4_r   <= arp4;
    arp5_r   <= arp5;
    arp6_r   <= arp6;
    arp7_r   <= arp7;
    arp8_r   <= arp8;
    arp9_r   <= arp9;
    arp10_r   <= arp10;
    arp11_r   <= arp11;
  end

  for (RSEG = 0; RSEG < F_SEGS; RSEG++)
        always_comb 
          ffodoutp0[RSEG] = ((track[RSEG][arp0_r]==0) || WR_PORTS==1)? fodoutp0[0][RSEG] :
                            ((track[RSEG][arp0_r]==1) && WR_PORTS>1) ? fodoutp1[0][RSEG] :
                            ((track[RSEG][arp0_r]==2) && WR_PORTS>2) ? fodoutp2[0][RSEG] :
                            ((track[RSEG][arp0_r]==3) && WR_PORTS>3) ? fodoutp3[0][RSEG] :
                            ((track[RSEG][arp0_r]==4) && WR_PORTS>4) ? fodoutp4[0][RSEG] :
                            ((track[RSEG][arp0_r]==5) && WR_PORTS>5) ? fodoutp5[0][RSEG] :
                            ((track[RSEG][arp0_r]==6) && WR_PORTS>6) ? fodoutp6[0][RSEG] :
                                                                       fodoutp7[0][RSEG] ;
  
  if (RD_PORTS > 1)
    for (RSEG = 0; RSEG < F_SEGS; RSEG++)
      always_comb
        ffodoutp1[RSEG] = ((track[RSEG][arp1_r]==0) || WR_PORTS==1)? fodoutp0[1][RSEG] :
                            ((track[RSEG][arp1_r]==1) && WR_PORTS>1) ? fodoutp1[1][RSEG] :
                            ((track[RSEG][arp1_r]==2) && WR_PORTS>2) ? fodoutp2[1][RSEG] :
                            ((track[RSEG][arp1_r]==3) && WR_PORTS>3) ? fodoutp3[1][RSEG] :
                            ((track[RSEG][arp1_r]==4) && WR_PORTS>4) ? fodoutp4[1][RSEG] :
                            ((track[RSEG][arp1_r]==5) && WR_PORTS>5) ? fodoutp5[1][RSEG] :
                            ((track[RSEG][arp1_r]==6) && WR_PORTS>6) ? fodoutp6[1][RSEG] :
                                                                       fodoutp7[1][RSEG] ;
  if (RD_PORTS > 2)
    for (RSEG = 0; RSEG < F_SEGS; RSEG++)
      always_comb
        ffodoutp2[RSEG] = ((track[RSEG][arp2_r]==0) || WR_PORTS==1)? fodoutp0[2][RSEG] :
                            ((track[RSEG][arp2_r]==1) && WR_PORTS>1) ? fodoutp1[2][RSEG] :
                            ((track[RSEG][arp2_r]==2) && WR_PORTS>2) ? fodoutp2[2][RSEG] :
                            ((track[RSEG][arp2_r]==3) && WR_PORTS>3) ? fodoutp3[2][RSEG] :
                            ((track[RSEG][arp2_r]==4) && WR_PORTS>4) ? fodoutp4[2][RSEG] :
                            ((track[RSEG][arp2_r]==5) && WR_PORTS>5) ? fodoutp5[2][RSEG] :
                            ((track[RSEG][arp2_r]==6) && WR_PORTS>6) ? fodoutp6[2][RSEG] :
                                                                       fodoutp7[2][RSEG] ;
  if (RD_PORTS > 3)
    for (RSEG = 0; RSEG < F_SEGS; RSEG++)
      always_comb
          ffodoutp3[RSEG] = ((track[RSEG][arp3_r]==0) || WR_PORTS==1)? fodoutp0[3][RSEG] :
                            ((track[RSEG][arp3_r]==1) && WR_PORTS>1) ? fodoutp1[3][RSEG] :
                            ((track[RSEG][arp3_r]==2) && WR_PORTS>2) ? fodoutp2[3][RSEG] :
                            ((track[RSEG][arp3_r]==3) && WR_PORTS>3) ? fodoutp3[3][RSEG] :
                            ((track[RSEG][arp3_r]==4) && WR_PORTS>4) ? fodoutp4[3][RSEG] :
                            ((track[RSEG][arp3_r]==5) && WR_PORTS>5) ? fodoutp5[3][RSEG] :
                            ((track[RSEG][arp3_r]==6) && WR_PORTS>6) ? fodoutp6[3][RSEG] :
                                                                       fodoutp7[3][RSEG] ;
  if (RD_PORTS > 4)
    for (RSEG = 0; RSEG < F_SEGS; RSEG++)
      always_comb
          ffodoutp4[RSEG] = ((track[RSEG][arp4_r]==0) || WR_PORTS==1)? fodoutp0[4][RSEG] :
                            ((track[RSEG][arp4_r]==1) && WR_PORTS>1) ? fodoutp1[4][RSEG] :
                            ((track[RSEG][arp4_r]==2) && WR_PORTS>2) ? fodoutp2[4][RSEG] :
                            ((track[RSEG][arp4_r]==3) && WR_PORTS>3) ? fodoutp3[4][RSEG] :
                            ((track[RSEG][arp4_r]==4) && WR_PORTS>4) ? fodoutp4[4][RSEG] :
                            ((track[RSEG][arp4_r]==5) && WR_PORTS>5) ? fodoutp5[4][RSEG] :
                            ((track[RSEG][arp4_r]==6) && WR_PORTS>6) ? fodoutp6[4][RSEG] :
                                                                       fodoutp7[4][RSEG] ;
  if (RD_PORTS > 5)
    for (RSEG = 0; RSEG < F_SEGS; RSEG++)
      always_comb
          ffodoutp5[RSEG] = ((track[RSEG][arp5_r]==0) || WR_PORTS==1)? fodoutp0[5][RSEG] :
                            ((track[RSEG][arp5_r]==1) && WR_PORTS>1) ? fodoutp1[5][RSEG] :
                            ((track[RSEG][arp5_r]==2) && WR_PORTS>2) ? fodoutp2[5][RSEG] :
                            ((track[RSEG][arp5_r]==3) && WR_PORTS>3) ? fodoutp3[5][RSEG] :
                            ((track[RSEG][arp5_r]==4) && WR_PORTS>4) ? fodoutp4[5][RSEG] :
                            ((track[RSEG][arp5_r]==5) && WR_PORTS>5) ? fodoutp5[5][RSEG] :
                            ((track[RSEG][arp5_r]==6) && WR_PORTS>6) ? fodoutp6[5][RSEG] :
                                                                       fodoutp7[5][RSEG] ;
  if (RD_PORTS > 6)
    for (RSEG = 0; RSEG < F_SEGS; RSEG++)
      always_comb
          ffodoutp6[RSEG] = ((track[RSEG][arp6_r]==0) || WR_PORTS==1)? fodoutp0[6][RSEG] :
                            ((track[RSEG][arp6_r]==1) && WR_PORTS>1) ? fodoutp1[6][RSEG] :
                            ((track[RSEG][arp6_r]==2) && WR_PORTS>2) ? fodoutp2[6][RSEG] :
                            ((track[RSEG][arp6_r]==3) && WR_PORTS>3) ? fodoutp3[6][RSEG] :
                            ((track[RSEG][arp6_r]==4) && WR_PORTS>4) ? fodoutp4[6][RSEG] :
                            ((track[RSEG][arp6_r]==5) && WR_PORTS>5) ? fodoutp5[6][RSEG] :
                            ((track[RSEG][arp6_r]==6) && WR_PORTS>6) ? fodoutp6[6][RSEG] :
                                                                       fodoutp7[6][RSEG] ;
  if (RD_PORTS > 7)
    for (RSEG = 0; RSEG < F_SEGS; RSEG++)
      always_comb
          ffodoutp7[RSEG] = ((track[RSEG][arp7_r]==0) || WR_PORTS==1)? fodoutp0[7][RSEG] :
                            ((track[RSEG][arp7_r]==1) && WR_PORTS>1) ? fodoutp1[7][RSEG] :
                            ((track[RSEG][arp7_r]==2) && WR_PORTS>2) ? fodoutp2[7][RSEG] :
                            ((track[RSEG][arp7_r]==3) && WR_PORTS>3) ? fodoutp3[7][RSEG] :
                            ((track[RSEG][arp7_r]==4) && WR_PORTS>4) ? fodoutp4[7][RSEG] :
                            ((track[RSEG][arp7_r]==5) && WR_PORTS>5) ? fodoutp5[7][RSEG] :
                            ((track[RSEG][arp7_r]==6) && WR_PORTS>6) ? fodoutp6[7][RSEG] :
                                                                       fodoutp7[7][RSEG] ;

  if (RD_PORTS > 8)
    for (RSEG = 0; RSEG < F_SEGS; RSEG++)
      always_comb
          ffodoutp8[RSEG] = ((track[RSEG][arp8_r]==0) || WR_PORTS==1)? fodoutp0[8][RSEG] :
                            ((track[RSEG][arp8_r]==1) && WR_PORTS>1) ? fodoutp1[8][RSEG] :
                            ((track[RSEG][arp8_r]==2) && WR_PORTS>2) ? fodoutp2[8][RSEG] :
                            ((track[RSEG][arp8_r]==3) && WR_PORTS>3) ? fodoutp3[8][RSEG] :
                            ((track[RSEG][arp8_r]==4) && WR_PORTS>4) ? fodoutp4[8][RSEG] :
                            ((track[RSEG][arp8_r]==5) && WR_PORTS>5) ? fodoutp5[8][RSEG] :
                            ((track[RSEG][arp8_r]==6) && WR_PORTS>6) ? fodoutp6[8][RSEG] :
                                                                       fodoutp7[8][RSEG] ;

  if (RD_PORTS > 9)
    for (RSEG = 0; RSEG < F_SEGS; RSEG++)
      always_comb
          ffodoutp9[RSEG] = ((track[RSEG][arp9_r]==0) || WR_PORTS==1)? fodoutp0[9][RSEG] :
                            ((track[RSEG][arp9_r]==1) && WR_PORTS>1) ? fodoutp1[9][RSEG] :
                            ((track[RSEG][arp9_r]==2) && WR_PORTS>2) ? fodoutp2[9][RSEG] :
                            ((track[RSEG][arp9_r]==3) && WR_PORTS>3) ? fodoutp3[9][RSEG] :
                            ((track[RSEG][arp9_r]==4) && WR_PORTS>4) ? fodoutp4[9][RSEG] :
                            ((track[RSEG][arp9_r]==5) && WR_PORTS>5) ? fodoutp5[9][RSEG] :
                            ((track[RSEG][arp9_r]==6) && WR_PORTS>6) ? fodoutp6[9][RSEG] :
                                                                       fodoutp7[9][RSEG] ;

  if (RD_PORTS > 10)
    for (RSEG = 0; RSEG < F_SEGS; RSEG++)
      always_comb
          ffodoutp10[RSEG] = ((track[RSEG][arp10_r]==0) || WR_PORTS==1)? fodoutp0[10][RSEG] :
                            ((track[RSEG][arp10_r]==1) && WR_PORTS>1) ? fodoutp1[10][RSEG] :
                            ((track[RSEG][arp10_r]==2) && WR_PORTS>2) ? fodoutp2[10][RSEG] :
                            ((track[RSEG][arp10_r]==3) && WR_PORTS>3) ? fodoutp3[10][RSEG] :
                            ((track[RSEG][arp10_r]==4) && WR_PORTS>4) ? fodoutp4[10][RSEG] :
                            ((track[RSEG][arp10_r]==5) && WR_PORTS>5) ? fodoutp5[10][RSEG] :
                            ((track[RSEG][arp10_r]==6) && WR_PORTS>6) ? fodoutp6[10][RSEG] :
                                                                        fodoutp7[10][RSEG] ;

  if (RD_PORTS > 11)
    for (RSEG = 0; RSEG < F_SEGS; RSEG++)
      always_comb
          ffodoutp11[RSEG] = ((track[RSEG][arp11_r]==0) || WR_PORTS==1)? fodoutp0[11][RSEG] :
                            ((track[RSEG][arp11_r]==1) && WR_PORTS>1) ? fodoutp1[11][RSEG] :
                            ((track[RSEG][arp11_r]==2) && WR_PORTS>2) ? fodoutp2[11][RSEG] :
                            ((track[RSEG][arp11_r]==3) && WR_PORTS>3) ? fodoutp3[11][RSEG] :
                            ((track[RSEG][arp11_r]==4) && WR_PORTS>4) ? fodoutp4[11][RSEG] :
                            ((track[RSEG][arp11_r]==5) && WR_PORTS>5) ? fodoutp5[11][RSEG] :
                            ((track[RSEG][arp11_r]==6) && WR_PORTS>6) ? fodoutp6[11][RSEG] :
                                                                        fodoutp7[11][RSEG] ;

endgenerate

////////////////////////////////////////////////////////////
// code added to handle simultaneous read and write to
// same location through different ports
////////////////////////////////////////////////////////////
always_ff @(posedge ckwr) begin
  wenp0_d1 <= wenp0;
  wenp1_d1 <= wenp1;
  wenp2_d1 <= wenp2;
  wenp3_d1 <= wenp3;
  wenp4_d1 <= wenp4;
  wenp5_d1 <= wenp5;
  wenp6_d1 <= wenp6;
  wenp7_d1 <= wenp7;
  
  awp0_d1 <= awp0;
  awp1_d1 <= awp1;
  awp2_d1 <= awp2;
  awp3_d1 <= awp3;
  awp4_d1 <= awp4;
  awp5_d1 <= awp5;
  awp6_d1 <= awp6;
  awp7_d1 <= awp7;

  idinp0_d1 <= idinp0;
  idinp1_d1 <= idinp1;
  idinp2_d1 <= idinp2;
  idinp3_d1 <= idinp3;
  idinp4_d1 <= idinp4;
  idinp5_d1 <= idinp5;
  idinp6_d1 <= idinp6;
  idinp7_d1 <= idinp7;

end

always_ff @(posedge ckrd) begin
  arp0_d1 <= arp0;
  arp1_d1 <= arp1;
  arp2_d1 <= arp2;
  arp3_d1 <= arp3;
  arp4_d1 <= arp4;
  arp5_d1 <= arp5;
  arp6_d1 <= arp6;
  arp7_d1 <= arp7;
  arp8_d1 <= arp8;
  arp9_d1 <= arp9;
  arp10_d1 <= arp10;
  arp11_d1 <= arp11;

  renp0_d1 <= renp0;
  renp1_d1 <= renp1;
  renp2_d1 <= renp2;
  renp3_d1 <= renp3;
  renp4_d1 <= renp4;
  renp5_d1 <= renp5;
  renp6_d1 <= renp6;
  renp7_d1 <= renp7;
  renp8_d1 <= renp8;
  renp9_d1 <= renp9;
  renp10_d1 <= renp10;
  renp11_d1 <= renp11;
end

genvar idx;

for(idx=0;idx<RD_SEGS;idx = idx + 1) begin : rd_wr_conflict
  always_comb
  begin
    s_odoutp0_bp[idx] = ((wenp0_d1[idx] == 'b1) && (awp0_d1 == arp0_d1) && (renp0_d1[idx] == 'b1)) ? idinp0_d1[idx] :
              ((wenp1_d1[idx] == 'b1) && (awp1_d1 == arp0_d1) && (renp0_d1[idx] == 'b1)) ? idinp1_d1[idx] :
              ((wenp2_d1[idx] == 'b1) && (awp2_d1 == arp0_d1) && (renp0_d1[idx] == 'b1)) ? idinp2_d1[idx] :
              ((wenp3_d1[idx] == 'b1) && (awp3_d1 == arp0_d1) && (renp0_d1[idx] == 'b1)) ? idinp3_d1[idx] :
              ((wenp4_d1[idx] == 'b1) && (awp4_d1 == arp0_d1) && (renp0_d1[idx] == 'b1)) ? idinp4_d1[idx] :
              ((wenp5_d1[idx] == 'b1) && (awp5_d1 == arp0_d1) && (renp0_d1[idx] == 'b1)) ? idinp5_d1[idx] :
              ((wenp6_d1[idx] == 'b1) && (awp6_d1 == arp0_d1) && (renp0_d1[idx] == 'b1)) ? idinp6_d1[idx] :
              ((wenp7_d1[idx] == 'b1) && (awp7_d1 == arp0_d1) && (renp0_d1[idx] == 'b1)) ? idinp7_d1[idx] :
              s_odoutp0[idx];
  
    s_odoutp1_bp[idx] = ((wenp0_d1[idx] == 'b1) && (awp0_d1 == arp1_d1) && (renp1_d1[idx] == 'b1)) ? idinp0_d1[idx] :
              ((wenp1_d1[idx] == 'b1) && (awp1_d1 == arp1_d1) && (renp1_d1[idx] == 'b1)) ? idinp1_d1[idx] :
              ((wenp2_d1[idx] == 'b1) && (awp2_d1 == arp1_d1) && (renp1_d1[idx] == 'b1)) ? idinp2_d1[idx] :
              ((wenp3_d1[idx] == 'b1) && (awp3_d1 == arp1_d1) && (renp1_d1[idx] == 'b1)) ? idinp3_d1[idx] :
              ((wenp4_d1[idx] == 'b1) && (awp4_d1 == arp1_d1) && (renp1_d1[idx] == 'b1)) ? idinp4_d1[idx] :
              ((wenp5_d1[idx] == 'b1) && (awp5_d1 == arp1_d1) && (renp1_d1[idx] == 'b1)) ? idinp5_d1[idx] :
              ((wenp6_d1[idx] == 'b1) && (awp6_d1 == arp1_d1) && (renp1_d1[idx] == 'b1)) ? idinp6_d1[idx] :
              ((wenp7_d1[idx] == 'b1) && (awp7_d1 == arp1_d1) && (renp1_d1[idx] == 'b1)) ? idinp7_d1[idx] :
              s_odoutp1[idx];
  
    s_odoutp2_bp[idx] = ((wenp0_d1[idx] == 'b1) && (awp0_d1 == arp2_d1) && (renp2_d1[idx] == 'b1)) ? idinp0_d1[idx] :
              ((wenp1_d1[idx] == 'b1) && (awp1_d1 == arp2_d1) && (renp2_d1[idx] == 'b1)) ? idinp1_d1[idx] :
              ((wenp2_d1[idx] == 'b1) && (awp2_d1 == arp2_d1) && (renp2_d1[idx] == 'b1)) ? idinp2_d1[idx] :
              ((wenp3_d1[idx] == 'b1) && (awp3_d1 == arp2_d1) && (renp2_d1[idx] == 'b1)) ? idinp3_d1[idx] :
              ((wenp4_d1[idx] == 'b1) && (awp4_d1 == arp2_d1) && (renp2_d1[idx] == 'b1)) ? idinp4_d1[idx] :
              ((wenp5_d1[idx] == 'b1) && (awp5_d1 == arp2_d1) && (renp2_d1[idx] == 'b1)) ? idinp5_d1[idx] :
              ((wenp6_d1[idx] == 'b1) && (awp6_d1 == arp2_d1) && (renp2_d1[idx] == 'b1)) ? idinp6_d1[idx] :
              ((wenp7_d1[idx] == 'b1) && (awp7_d1 == arp2_d1) && (renp2_d1[idx] == 'b1)) ? idinp7_d1[idx] :
              s_odoutp2[idx];
  
    s_odoutp3_bp[idx] = ((wenp0_d1[idx] == 'b1) && (awp0_d1 == arp3_d1) && (renp3_d1[idx] == 'b1)) ? idinp0_d1[idx] :
              ((wenp1_d1[idx] == 'b1) && (awp1_d1 == arp3_d1) && (renp3_d1[idx] == 'b1)) ? idinp1_d1[idx] :
              ((wenp2_d1[idx] == 'b1) && (awp2_d1 == arp3_d1) && (renp3_d1[idx] == 'b1)) ? idinp2_d1[idx] :
              ((wenp3_d1[idx] == 'b1) && (awp3_d1 == arp3_d1) && (renp3_d1[idx] == 'b1)) ? idinp3_d1[idx] :
              ((wenp4_d1[idx] == 'b1) && (awp4_d1 == arp3_d1) && (renp3_d1[idx] == 'b1)) ? idinp4_d1[idx] :
              ((wenp5_d1[idx] == 'b1) && (awp5_d1 == arp3_d1) && (renp3_d1[idx] == 'b1)) ? idinp5_d1[idx] :
              ((wenp5_d1[idx] == 'b1) && (awp5_d1 == arp3_d1) && (renp3_d1[idx] == 'b1)) ? idinp5_d1[idx] :
              ((wenp6_d1[idx] == 'b1) && (awp6_d1 == arp3_d1) && (renp3_d1[idx] == 'b1)) ? idinp6_d1[idx] :
              ((wenp7_d1[idx] == 'b1) && (awp7_d1 == arp3_d1) && (renp3_d1[idx] == 'b1)) ? idinp7_d1[idx] :
              s_odoutp3[idx];
  
    s_odoutp4_bp[idx] = ((wenp0_d1[idx] == 'b1) && (awp0_d1 == arp4_d1) && (renp4_d1[idx] == 'b1)) ? idinp0_d1[idx] :
              ((wenp1_d1[idx] == 'b1) && (awp1_d1 == arp4_d1) && (renp4_d1[idx] == 'b1)) ? idinp1_d1[idx] :
              ((wenp2_d1[idx] == 'b1) && (awp2_d1 == arp4_d1) && (renp4_d1[idx] == 'b1)) ? idinp2_d1[idx] :
              ((wenp3_d1[idx] == 'b1) && (awp3_d1 == arp4_d1) && (renp4_d1[idx] == 'b1)) ? idinp3_d1[idx] :
              ((wenp4_d1[idx] == 'b1) && (awp4_d1 == arp4_d1) && (renp4_d1[idx] == 'b1)) ? idinp4_d1[idx] :
              ((wenp5_d1[idx] == 'b1) && (awp5_d1 == arp4_d1) && (renp4_d1[idx] == 'b1)) ? idinp5_d1[idx] :
              ((wenp6_d1[idx] == 'b1) && (awp6_d1 == arp4_d1) && (renp4_d1[idx] == 'b1)) ? idinp6_d1[idx] :
              ((wenp7_d1[idx] == 'b1) && (awp7_d1 == arp4_d1) && (renp4_d1[idx] == 'b1)) ? idinp7_d1[idx] :
              s_odoutp4[idx];
  
    s_odoutp5_bp[idx] = ((wenp0_d1[idx] == 'b1) && (awp0_d1 == arp5_d1) && (renp5_d1[idx] == 'b1)) ? idinp0_d1[idx] :
              ((wenp1_d1[idx] == 'b1) && (awp1_d1 == arp5_d1) && (renp5_d1[idx] == 'b1)) ? idinp1_d1[idx] :
              ((wenp2_d1[idx] == 'b1) && (awp2_d1 == arp5_d1) && (renp5_d1[idx] == 'b1)) ? idinp2_d1[idx] :
              ((wenp3_d1[idx] == 'b1) && (awp3_d1 == arp5_d1) && (renp5_d1[idx] == 'b1)) ? idinp3_d1[idx] :
              ((wenp4_d1[idx] == 'b1) && (awp4_d1 == arp5_d1) && (renp5_d1[idx] == 'b1)) ? idinp4_d1[idx] :
              ((wenp5_d1[idx] == 'b1) && (awp5_d1 == arp5_d1) && (renp5_d1[idx] == 'b1)) ? idinp5_d1[idx] :
              ((wenp6_d1[idx] == 'b1) && (awp6_d1 == arp5_d1) && (renp5_d1[idx] == 'b1)) ? idinp6_d1[idx] :
              ((wenp7_d1[idx] == 'b1) && (awp7_d1 == arp5_d1) && (renp5_d1[idx] == 'b1)) ? idinp7_d1[idx] :
              s_odoutp5[idx];
  
    s_odoutp6_bp[idx] = ((wenp0_d1[idx] == 'b1) && (awp0_d1 == arp6_d1) && (renp6_d1[idx] == 'b1)) ? idinp0_d1[idx] :
              ((wenp1_d1[idx] == 'b1) && (awp1_d1 == arp6_d1) && (renp6_d1[idx] == 'b1)) ? idinp1_d1[idx] :
              ((wenp2_d1[idx] == 'b1) && (awp2_d1 == arp6_d1) && (renp6_d1[idx] == 'b1)) ? idinp2_d1[idx] :
              ((wenp3_d1[idx] == 'b1) && (awp3_d1 == arp6_d1) && (renp6_d1[idx] == 'b1)) ? idinp3_d1[idx] :
              ((wenp4_d1[idx] == 'b1) && (awp4_d1 == arp6_d1) && (renp6_d1[idx] == 'b1)) ? idinp4_d1[idx] :
              ((wenp5_d1[idx] == 'b1) && (awp5_d1 == arp6_d1) && (renp6_d1[idx] == 'b1)) ? idinp5_d1[idx] :
              ((wenp6_d1[idx] == 'b1) && (awp6_d1 == arp6_d1) && (renp6_d1[idx] == 'b1)) ? idinp6_d1[idx] :
              ((wenp7_d1[idx] == 'b1) && (awp7_d1 == arp6_d1) && (renp6_d1[idx] == 'b1)) ? idinp7_d1[idx] :
              s_odoutp6[idx];
  
    s_odoutp7_bp[idx] = ((wenp0_d1[idx] == 'b1) && (awp0_d1 == arp7_d1) && (renp7_d1[idx] == 'b1)) ? idinp0_d1[idx] :
              ((wenp1_d1[idx] == 'b1) && (awp1_d1 == arp7_d1) && (renp7_d1[idx] == 'b1)) ? idinp1_d1[idx] :
              ((wenp2_d1[idx] == 'b1) && (awp2_d1 == arp7_d1) && (renp7_d1[idx] == 'b1)) ? idinp2_d1[idx] :
              ((wenp3_d1[idx] == 'b1) && (awp3_d1 == arp7_d1) && (renp7_d1[idx] == 'b1)) ? idinp3_d1[idx] :
              ((wenp4_d1[idx] == 'b1) && (awp4_d1 == arp7_d1) && (renp7_d1[idx] == 'b1)) ? idinp4_d1[idx] :
              ((wenp5_d1[idx] == 'b1) && (awp5_d1 == arp7_d1) && (renp7_d1[idx] == 'b1)) ? idinp5_d1[idx] :
              ((wenp6_d1[idx] == 'b1) && (awp6_d1 == arp7_d1) && (renp7_d1[idx] == 'b1)) ? idinp6_d1[idx] :
              ((wenp7_d1[idx] == 'b1) && (awp7_d1 == arp7_d1) && (renp7_d1[idx] == 'b1)) ? idinp7_d1[idx] :
              s_odoutp7[idx];
  
    s_odoutp8_bp[idx] = ((wenp0_d1[idx] == 'b1) && (awp0_d1 == arp8_d1) && (renp8_d1[idx] == 'b1)) ? idinp0_d1[idx] :
              ((wenp1_d1[idx] == 'b1) && (awp1_d1 == arp8_d1) && (renp8_d1[idx] == 'b1)) ? idinp1_d1[idx] :
              ((wenp2_d1[idx] == 'b1) && (awp2_d1 == arp8_d1) && (renp8_d1[idx] == 'b1)) ? idinp2_d1[idx] :
              ((wenp3_d1[idx] == 'b1) && (awp3_d1 == arp8_d1) && (renp8_d1[idx] == 'b1)) ? idinp3_d1[idx] :
              ((wenp4_d1[idx] == 'b1) && (awp4_d1 == arp8_d1) && (renp8_d1[idx] == 'b1)) ? idinp4_d1[idx] :
              ((wenp5_d1[idx] == 'b1) && (awp5_d1 == arp8_d1) && (renp8_d1[idx] == 'b1)) ? idinp5_d1[idx] :
              ((wenp6_d1[idx] == 'b1) && (awp6_d1 == arp8_d1) && (renp8_d1[idx] == 'b1)) ? idinp6_d1[idx] :
              ((wenp7_d1[idx] == 'b1) && (awp7_d1 == arp8_d1) && (renp8_d1[idx] == 'b1)) ? idinp7_d1[idx] :
              s_odoutp8[idx];
  
    s_odoutp9_bp[idx] = ((wenp0_d1[idx] == 'b1) && (awp0_d1 == arp9_d1) && (renp9_d1[idx] == 'b1)) ? idinp0_d1[idx] :
              ((wenp1_d1[idx] == 'b1) && (awp1_d1 == arp9_d1) && (renp9_d1[idx] == 'b1)) ? idinp1_d1[idx] :
              ((wenp2_d1[idx] == 'b1) && (awp2_d1 == arp9_d1) && (renp9_d1[idx] == 'b1)) ? idinp2_d1[idx] :
              ((wenp3_d1[idx] == 'b1) && (awp3_d1 == arp9_d1) && (renp9_d1[idx] == 'b1)) ? idinp3_d1[idx] :
              ((wenp4_d1[idx] == 'b1) && (awp4_d1 == arp9_d1) && (renp9_d1[idx] == 'b1)) ? idinp4_d1[idx] :
              ((wenp5_d1[idx] == 'b1) && (awp5_d1 == arp9_d1) && (renp9_d1[idx] == 'b1)) ? idinp5_d1[idx] :
              ((wenp6_d1[idx] == 'b1) && (awp6_d1 == arp9_d1) && (renp9_d1[idx] == 'b1)) ? idinp6_d1[idx] :
              ((wenp6_d1[idx] == 'b1) && (awp7_d1 == arp9_d1) && (renp9_d1[idx] == 'b1)) ? idinp7_d1[idx] :
              s_odoutp9[idx];
  
    s_odoutp10_bp[idx] = ((wenp0_d1[idx] == 'b1) && (awp0_d1 == arp10_d1) && (renp10_d1[idx] == 'b1)) ? idinp0_d1[idx] :
              ((wenp1_d1[idx] == 'b1) && (awp1_d1 == arp10_d1) && (renp10_d1[idx] == 'b1)) ? idinp1_d1[idx] :
              ((wenp2_d1[idx] == 'b1) && (awp2_d1 == arp10_d1) && (renp10_d1[idx] == 'b1)) ? idinp2_d1[idx] :
              ((wenp3_d1[idx] == 'b1) && (awp3_d1 == arp10_d1) && (renp10_d1[idx] == 'b1)) ? idinp3_d1[idx] :
              ((wenp4_d1[idx] == 'b1) && (awp4_d1 == arp10_d1) && (renp10_d1[idx] == 'b1)) ? idinp4_d1[idx] :
              ((wenp5_d1[idx] == 'b1) && (awp5_d1 == arp10_d1) && (renp10_d1[idx] == 'b1)) ? idinp5_d1[idx] :
              ((wenp6_d1[idx] == 'b1) && (awp6_d1 == arp10_d1) && (renp10_d1[idx] == 'b1)) ? idinp6_d1[idx] :
              ((wenp7_d1[idx] == 'b1) && (awp7_d1 == arp10_d1) && (renp10_d1[idx] == 'b1)) ? idinp7_d1[idx] :
              s_odoutp10[idx];
  
    s_odoutp11_bp[idx] = ((wenp0_d1[idx] == 'b1) && (awp0_d1 == arp11_d1) && (renp11_d1[idx] == 'b1)) ? idinp0_d1[idx] :
              ((wenp1_d1[idx] == 'b1) && (awp1_d1 == arp11_d1) && (renp11_d1[idx] == 'b1)) ? idinp1_d1[idx] :
              ((wenp2_d1[idx] == 'b1) && (awp2_d1 == arp11_d1) && (renp11_d1[idx] == 'b1)) ? idinp2_d1[idx] :
              ((wenp3_d1[idx] == 'b1) && (awp3_d1 == arp11_d1) && (renp11_d1[idx] == 'b1)) ? idinp3_d1[idx] :
              ((wenp4_d1[idx] == 'b1) && (awp4_d1 == arp11_d1) && (renp11_d1[idx] == 'b1)) ? idinp4_d1[idx] :
              ((wenp5_d1[idx] == 'b1) && (awp5_d1 == arp11_d1) && (renp11_d1[idx] == 'b1)) ? idinp5_d1[idx] :
              ((wenp6_d1[idx] == 'b1) && (awp6_d1 == arp11_d1) && (renp11_d1[idx] == 'b1)) ? idinp6_d1[idx] :
              ((wenp7_d1[idx] == 'b1) && (awp7_d1 == arp11_d1) && (renp11_d1[idx] == 'b1)) ? idinp7_d1[idx] :
              s_odoutp11[idx];
  end //always
end //end for loop

// If read and write clocks are same, RW_MPORT_CONFLICT can be
// set to 1. 
if(RW_MPORT_CONFLICT == 1)
  begin
    assign odoutp0 = s_odoutp0_bp;
    assign odoutp1 = s_odoutp1_bp;
    assign odoutp2 = s_odoutp2_bp;
    assign odoutp3 = s_odoutp3_bp;
    assign odoutp4 = s_odoutp4_bp;
    assign odoutp5 = s_odoutp5_bp;
    assign odoutp6 = s_odoutp6_bp;
    assign odoutp7 = s_odoutp7_bp;
    assign odoutp8 = s_odoutp8_bp;
    assign odoutp9 = s_odoutp9_bp;
    assign odoutp10 = s_odoutp10_bp;
    assign odoutp11 = s_odoutp11_bp;
  end
else
  begin
    assign odoutp0 = s_odoutp0;
    assign odoutp1 = s_odoutp1;
    assign odoutp2 = s_odoutp2;
    assign odoutp3 = s_odoutp3;
    assign odoutp4 = s_odoutp4;
    assign odoutp5 = s_odoutp5;
    assign odoutp6 = s_odoutp6;
    assign odoutp7 = s_odoutp7;
    assign odoutp8 = s_odoutp8;
    assign odoutp9 = s_odoutp9;
    assign odoutp10 = s_odoutp10;
    assign odoutp11 = s_odoutp11;
  end

// A check code for parameter verification
if(RW_MPORT_CONFLICT == 1)
  begin
  time event_ckwr_r;
  time event_ckwr_f;
  time event_ckrd_r;
  time event_ckrd_f;

    always @(posedge ckwr)
      event_ckwr_r <= $time;

    always @(negedge ckwr)
      event_ckwr_f <= $time;

  always @(posedge ckrd)
      event_ckrd_r <= $time;

  always @(negedge ckrd)
      event_ckrd_f <= $time;

    always @(ckrd, ckwr)
      begin
      #1;
    if((event_ckrd_r !== event_ckwr_r) || (event_ckrd_f !== event_ckwr_f))
      $display("Read & Write clocks are different, Conflict parameter set! in %m");
    end

  end

////////////////////////////////////////////
/////////// ARRAY INJECTION ////////////////
////////////////////////////////////////////
//
//// Below code mimics injections happening on main simulation memory
//// This helps to check read output of fpga memory against simulation memory in regressions
////
//   `ifndef SVA_OFF
//      for (genvar i = 0; i < WORDS; i++)
//         always @ (memsim[i])
//            if (~ckwrpx) begin
//               if (WR_PORTS > 0) begin
//                  if (RD_PORTS > 0) force memsimr0w0[i] = memsim[i];
//                  if (RD_PORTS > 1) force memsimr1w0[i] = memsim[i];
//                  if (RD_PORTS > 2) force memsimr2w0[i] = memsim[i];
//                  if (RD_PORTS > 3) force memsimr3w0[i] = memsim[i];
//                  if (RD_PORTS > 4) force memsimr4w0[i] = memsim[i];
//               end
//               if (WR_PORTS > 1) begin
//                  if (RD_PORTS > 0) force memsimr0w1[i] = memsim[i];
//                  if (RD_PORTS > 1) force memsimr1w1[i] = memsim[i];
//                  if (RD_PORTS > 2) force memsimr2w1[i] = memsim[i];
//                  if (RD_PORTS > 3) force memsimr3w1[i] = memsim[i];
//                  if (RD_PORTS > 4) force memsimr4w1[i] = memsim[i];
//               end
//               if (WR_PORTS > 2) begin
//                  if (RD_PORTS > 0) force memsimr0w2[i] = memsim[i];
//                  if (RD_PORTS > 1) force memsimr1w2[i] = memsim[i];
//                  if (RD_PORTS > 2) force memsimr2w2[i] = memsim[i];
//                  if (RD_PORTS > 3) force memsimr3w2[i] = memsim[i];
//                  if (RD_PORTS > 4) force memsimr4w2[i] = memsim[i];
//               end
//               if (WR_PORTS > 3) begin
//                  if (RD_PORTS > 0) force memsimr0w3[i] = memsim[i];
//                  if (RD_PORTS > 1) force memsimr1w3[i] = memsim[i];
//                  if (RD_PORTS > 2) force memsimr2w3[i] = memsim[i];
//                  if (RD_PORTS > 3) force memsimr3w3[i] = memsim[i];
//                  if (RD_PORTS > 4) force memsimr4w3[i] = memsim[i];
//               end
//               if (WR_PORTS > 4) begin
//                  if (RD_PORTS > 0) force memsimr0w4[i] = memsim[i];
//                  if (RD_PORTS > 1) force memsimr1w4[i] = memsim[i];
//                  if (RD_PORTS > 2) force memsimr2w4[i] = memsim[i];
//                  if (RD_PORTS > 3) force memsimr3w4[i] = memsim[i];
//                  if (RD_PORTS > 4) force memsimr4w4[i] = memsim[i];
//               end
//
//               if (WR_PORTS > 0) begin
//                  if (RD_PORTS > 0) release memsimr0w0[i];
//                  if (RD_PORTS > 1) release memsimr1w0[i];
//                  if (RD_PORTS > 2) release memsimr2w0[i];
//                  if (RD_PORTS > 3) release memsimr3w0[i];
//                  if (RD_PORTS > 4) release memsimr4w0[i];
//               end
//               if (WR_PORTS > 1) begin
//                  if (RD_PORTS > 0) release memsimr0w1[i];
//                  if (RD_PORTS > 1) release memsimr1w1[i];
//                  if (RD_PORTS > 2) release memsimr2w1[i];
//                  if (RD_PORTS > 3) release memsimr3w1[i];
//                  if (RD_PORTS > 4) release memsimr4w1[i];
//               end
//               if (WR_PORTS > 2) begin
//                  if (RD_PORTS > 0) release memsimr0w2[i];
//                  if (RD_PORTS > 1) release memsimr1w2[i];
//                  if (RD_PORTS > 2) release memsimr2w2[i];
//                  if (RD_PORTS > 3) release memsimr3w2[i];
//                  if (RD_PORTS > 4) release memsimr4w2[i];
//               end
//               if (WR_PORTS > 3) begin
//                  if (RD_PORTS > 0) release memsimr0w3[i];
//                  if (RD_PORTS > 1) release memsimr1w3[i];
//                  if (RD_PORTS > 2) release memsimr2w3[i];
//                  if (RD_PORTS > 3) release memsimr3w3[i];
//                  if (RD_PORTS > 4) release memsimr4w3[i];
//               end              
//               if (WR_PORTS > 4) begin
//                  if (RD_PORTS > 0) release memsimr0w4[i];
//                  if (RD_PORTS > 1) release memsimr1w4[i];
//                  if (RD_PORTS > 2) release memsimr2w4[i];
//                  if (RD_PORTS > 3) release memsimr3w4[i];
//                  if (RD_PORTS > 4) release memsimr4w4[i];
//               end              
//
//               // reset trackers if injection is happening
//               force track[0][i] = 0; release track[0][i]; 
//               force track[1][i] = 0; release track[1][i];
//               force track[2][i] = 0; release track[2][i];
//               force track[3][i] = 0; release track[3][i];
//               force track[4][i] = 0; release track[4][i];
//            end
//   `endif

//--------------------------------------------------------------------------------
// Modification History
// Date       Name of      Description
//            Engineer
//--------------------------------------------------------------------------------
// 12-Mar-'19 Sachin Jain  Support for 2 more read ports and 1 write ports
//                         added.
// 13-Mar-'19 Vikas        SIOB related issue is resolved, by converting 
//                         Procedural if to Generate if.
//                         See solvnet record: 2376939
//                         https://solvnet.synopsys.com/retrieve/2376939.html
// 01-Jun-'19 Vikas        mport memory Read address and write address
//                         being same condition handled 
// 13-May-'20 Vikas        When read and write addresses match, the dataout
//                         should correspond to data being written
// 19-Apr-'21 Sachin Jain  Added 4 reads and 2 write ports additionally
