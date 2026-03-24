module  IW_fpga_i2c_slave2avmm #(
  parameter I2C_ADDR     = 7'h28,
  parameter AVMM_DATA_W  = 32,
  parameter AVMM_ADDR_W  = 16
)

(
  //Clock, Resets
  input       clk,
  input       rst_n,

  //I2C Bus
  input       SCL,
  inout       SDA,

  //Register Interface
  output  reg                        avmm_write,
  output  reg                        avmm_read,
  output  reg [AVMM_ADDR_W-1:0]      avmm_address,
  output  reg [AVMM_DATA_W-1:0]      avmm_writedata,
  output      [(AVMM_DATA_W/8)-1:0]  avmm_byteenable,
  input       [AVMM_DATA_W-1:0]      avmm_readdata,
  input                              avmm_readdatavalid,
  input                              avmm_waitrequest

);

  localparam  I2C_ACK_BIT       = 1'b0;
  localparam  I2C_NACK_BIT      = 1'b1;
  localparam  BFFR_W            = (AVMM_DATA_W > AVMM_ADDR_W) ? AVMM_DATA_W  : AVMM_ADDR_W;
  localparam  NUM_ADDR_CYCLES   = AVMM_ADDR_W  / 8;
  localparam  NUM_DATA_CYCLES   = AVMM_DATA_W  / 8;
  localparam  ADDR_CYCLE_CNTR_W = $clog2(NUM_ADDR_CYCLES) + 1;
  localparam  DATA_CYCLE_CNTR_W = $clog2(NUM_DATA_CYCLES) + 1;
  localparam  CYCLE_CNTR_W      = (ADDR_CYCLE_CNTR_W  > DATA_CYCLE_CNTR_W)  ? ADDR_CYCLE_CNTR_W : DATA_CYCLE_CNTR_W;


  //Internal Registers
  reg                         sda_out_f;
  reg                         sda_in_1d;
  reg                         scl_in_1d;
  reg                         release_sda_c;
  reg     [BFFR_W-1:0]        i2c_bffr_f;
  reg     [3:0]               i2c_bit_cntr_f,i2c_bit_cntr_nxt_c;
  reg     [CYCLE_CNTR_W-1:0]  cycle_cntr_f;


  //Internal Wires
  wire                        sda_in_w;
  wire                        scl_in_w;
  wire                        start_det_c;
  wire                        stop_det_c;
  wire                        scl_posedge_det_c;
  wire                        scl_negedge_det_c;
  wire                        i2c_addr_match_c;
  wire    [CYCLE_CNTR_W-1:0]  cycle_cnt_max_c;
  wire                        phase_ovr_c;


  //FSM State
  parameter [2:0] IDLE_S          = 3'd0,
                  START_S         = 3'd1,
                  I2C_ADDR_S      = 3'd2,
                  REG_WADDR_S     = 3'd3,
                  REG_WDATA_S     = 3'd4,
                  REG_RDATA_S     = 3'd5,
                  WAIT_FOR_STOP_S = 3'd6;

  reg [2:0]   fsm_pstate, next_state;

  //synthesis translate_off
  reg [8*12:0]    state_name;
  
  always @ (fsm_pstate)
  begin
    case (fsm_pstate)
      IDLE_S          : state_name  = "IDLE_S";
      START_S         : state_name  = "START_S";
      I2C_ADDR_S      : state_name  = "I2C_ADDR_S";
      REG_WADDR_S     : state_name  = "REG_WADDR_S";
      REG_WDATA_S     : state_name  = "REG_WDATA_S";
      REG_RDATA_S     : state_name  = "REG_RDATA_S";
      WAIT_FOR_STOP_S : state_name  = "WAIT_FOR_STOP_S";
      default         : state_name  = "INVALID!";
    endcase
  end
  //synthesis translate_on

  localparam TIMEOUT_VALUE = 32'hDEADF00D;

  /*  Debounce the SDA & SCL input to get rid  of ringing */
  localparam NUM_DEBOUNCE = 32;
  reg  [NUM_DEBOUNCE-1:0] scl_d;
  reg  [NUM_DEBOUNCE-1:0] sda_d;
  wire [NUM_DEBOUNCE-1:2] scl_slice;
  wire [NUM_DEBOUNCE-1:2] sda_slice;
 
  always @(posedge clk) begin
    scl_d <= {scl_d[NUM_DEBOUNCE-2:0],SCL};
    sda_d <= {sda_d[NUM_DEBOUNCE-2:0],SDA};
  end

  assign scl_slice = scl_d[NUM_DEBOUNCE-1:2];
  assign sda_slice = sda_d[NUM_DEBOUNCE-1:2];

  assign sda_in_w = &sda_slice;
  assign scl_in_w = &scl_slice;

  //Check if the i2c address matches with this node
  assign  i2c_addr_match_c  = (i2c_bffr_f[7:1]  ==  I2C_ADDR) ? 1'b1  : 1'b0;


  /*  FSM Sequential Logic  */
  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      fsm_pstate              <=  IDLE_S;
      sda_in_1d               <=  1;
      scl_in_1d               <=  1;
      i2c_bffr_f              <=  0;
      i2c_bit_cntr_f          <=  0;
      sda_out_f               <=  I2C_ACK_BIT;
      cycle_cntr_f            <=  0;
    end
    else
    begin
      fsm_pstate              <=  next_state;
      sda_in_1d               <=  sda_in_w;
      scl_in_1d               <=  scl_in_w;

      i2c_bit_cntr_f          <=  i2c_bit_cntr_nxt_c;

      case(fsm_pstate)

        I2C_ADDR_S  :
        begin
          if(i2c_bit_cntr_f[3])
          begin
            sda_out_f         <=  i2c_addr_match_c  ? I2C_ACK_BIT : I2C_NACK_BIT;
            // Load default value as Read data from register. Actual value from register
            // will override this value. If this value is received, then
						// reduce the frequency of I2C to provide more time for Slave
						// interface to get the data
            if(scl_negedge_det_c) begin
              i2c_bffr_f <= TIMEOUT_VALUE[BFFR_W-1:0];
            end
          end
          else
          begin
            i2c_bffr_f        <=  scl_posedge_det_c ? {i2c_bffr_f[BFFR_W-2:0],sda_in_w} : i2c_bffr_f;
          end
        end

        REG_WADDR_S :
        begin
          if(i2c_bit_cntr_f[3]  & scl_negedge_det_c)
          begin
            cycle_cntr_f      <=  phase_ovr_c ? 0 : cycle_cntr_f  + 1'b1;
          end

          i2c_bffr_f          <=  (scl_posedge_det_c  & ~i2c_bit_cntr_f[3]) ? {i2c_bffr_f[BFFR_W-2:0],sda_in_w} : i2c_bffr_f;
        end

        REG_WDATA_S :
        begin
          if(i2c_bit_cntr_f[3]  & scl_negedge_det_c)
          begin
            cycle_cntr_f      <=  phase_ovr_c ? 0 : cycle_cntr_f  + 1'b1;
          end

          i2c_bffr_f          <=  (scl_posedge_det_c  & ~i2c_bit_cntr_f[3]) ? {i2c_bffr_f[BFFR_W-2:0],sda_in_w} : i2c_bffr_f;
        end

        REG_RDATA_S :
        begin
          if(i2c_bit_cntr_f[3]  & scl_negedge_det_c)
          begin
            cycle_cntr_f      <=  phase_ovr_c ? 0 : cycle_cntr_f  + 1'b1;
          end

          if(scl_negedge_det_c  & ~i2c_bit_cntr_f[3])
          begin
            i2c_bffr_f        <=  {i2c_bffr_f[BFFR_W-2:0],1'b0};
          end
          else if(avmm_readdatavalid & (i2c_bit_cntr_f == 0))
          begin
            i2c_bffr_f[AVMM_DATA_W-1:0]  <=  avmm_readdata;
          end
          else
          begin
            i2c_bffr_f        <= i2c_bffr_f;
          end

          sda_out_f           <=  (i2c_bit_cntr_f[3]) ? I2C_ACK_BIT  : i2c_bffr_f[AVMM_DATA_W-1]; //sample MSb
        end

        default :
        begin
          cycle_cntr_f        <=  0;
          sda_out_f           <=  I2C_ACK_BIT;
        end
      endcase
    end
  end

  //Check for valid start & stop conditions on the I2C bus
  assign  start_det_c         =   ~sda_in_w & sda_in_1d & scl_in_w;
  assign  stop_det_c          =   sda_in_w  & ~sda_in_1d & scl_in_w;

  //Check for psedge & negedge transitionson the SCL line
  assign  scl_posedge_det_c   =   scl_in_w  & ~scl_in_1d;
  assign  scl_negedge_det_c   =   ~scl_in_w & scl_in_1d;

  //Switch between max values for cycle_cntr_f in ADDR & DATA phases
  assign  cycle_cnt_max_c     =   (fsm_pstate ==  REG_WADDR_S)  ? NUM_ADDR_CYCLES - 1 : NUM_DATA_CYCLES - 1;

  //Check if the phase is over
  assign  phase_ovr_c         =   (cycle_cntr_f ==  cycle_cnt_max_c)  ? 1'b1  : 1'b0;

  /*  FSM Combinational Logic */
  always@(*)
  begin
    next_state                =   fsm_pstate;
    i2c_bit_cntr_nxt_c        =   i2c_bit_cntr_f;
    release_sda_c             =   1'b1;

    case(fsm_pstate)
      IDLE_S  :
      begin
        if(start_det_c)
        begin
          i2c_bit_cntr_nxt_c  =   0;
          next_state          =   START_S;
        end
      end

      START_S :
      begin
        if(scl_negedge_det_c)
        begin
          next_state          =   I2C_ADDR_S;
        end
      end

      I2C_ADDR_S  :
      begin
        if(i2c_bit_cntr_f[3]  & scl_negedge_det_c)
        begin
          i2c_bit_cntr_nxt_c  =   0;

          if(i2c_addr_match_c)
          begin
            next_state        =   i2c_bffr_f[0] ? REG_RDATA_S : REG_WADDR_S;
          end
          else
          begin
            next_state        =   WAIT_FOR_STOP_S;
          end
        end
        else
        begin
          i2c_bit_cntr_nxt_c  =   i2c_bit_cntr_f  + scl_negedge_det_c;
        end

        release_sda_c         =   i2c_bit_cntr_f[3] ? ~i2c_addr_match_c : 1'b1;
      end

      REG_WADDR_S :
      begin
        if(stop_det_c)
        begin
          next_state          = IDLE_S;
        end
        else if(i2c_bit_cntr_f[3]  & scl_negedge_det_c)
        begin
          i2c_bit_cntr_nxt_c  =   0;

          next_state          =   phase_ovr_c ? REG_WDATA_S : REG_WADDR_S;
        end
        else
        begin
          i2c_bit_cntr_nxt_c  =   i2c_bit_cntr_f  + scl_negedge_det_c;
        end

        release_sda_c         =   ~i2c_bit_cntr_f[3];
      end

      REG_WDATA_S :
      begin
        if(stop_det_c)
        begin
          next_state          = IDLE_S;
        end
        else if(i2c_bit_cntr_f[3]  & scl_negedge_det_c)
        begin
          i2c_bit_cntr_nxt_c  =   0;

          next_state          =   phase_ovr_c ? WAIT_FOR_STOP_S : REG_WDATA_S;
        end
        else
        begin
          i2c_bit_cntr_nxt_c  =   i2c_bit_cntr_f  + scl_negedge_det_c;
        end

        release_sda_c         =   ~i2c_bit_cntr_f[3];
      end

      REG_RDATA_S :
      begin
        if(i2c_bit_cntr_f[3])
        begin
          if(scl_posedge_det_c)
          begin
            next_state        =   ((sda_in_w ==  I2C_NACK_BIT)  | phase_ovr_c)  ? WAIT_FOR_STOP_S : REG_RDATA_S;
          end

          i2c_bit_cntr_nxt_c  =   scl_negedge_det_c ? 0 : i2c_bit_cntr_f;
        end
        else
        begin
          i2c_bit_cntr_nxt_c  =   i2c_bit_cntr_f  + scl_negedge_det_c;
        end

        release_sda_c         =   i2c_bit_cntr_f[3];
      end

      WAIT_FOR_STOP_S :
      begin
        i2c_bit_cntr_nxt_c    =   0;

        if(stop_det_c)
        begin
          next_state          =   IDLE_S;
        end
      end

    endcase
  end

  //SDA Tristate logic
  assign  SDA                 =   release_sda_c ? 1'bz  : sda_out_f;


  /*  Register Output Logic */
  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      avmm_write             <=  0;
      avmm_read              <=  0;
      avmm_address           <=  0;
      avmm_writedata         <=  0;
    end
    else
    begin
      case(fsm_pstate)

        I2C_ADDR_S :
        begin
          if(i2c_bit_cntr_f[3]  & scl_negedge_det_c & i2c_bffr_f[0])
          begin
            avmm_read             <= 1'b1; 
          end
        end

        REG_WADDR_S :
        begin
          if(i2c_bit_cntr_f[3]  & scl_negedge_det_c)
          begin
            avmm_address          <=  {avmm_address[AVMM_ADDR_W-8-1:0],i2c_bffr_f[7:0]};
            avmm_read             <=  avmm_waitrequest ? avmm_read : 0; 
          end

        end

        REG_WDATA_S :
        begin
          if(i2c_bit_cntr_f[3]  & scl_negedge_det_c)
          begin
            avmm_writedata         <=  {avmm_writedata[AVMM_DATA_W-8-1:0],i2c_bffr_f[7:0]};
          end

          avmm_write         <=  i2c_bit_cntr_f[3]  & scl_negedge_det_c  & (cycle_cntr_f ==  NUM_DATA_CYCLES-1);
          avmm_read          <=  avmm_waitrequest ? avmm_read : 0; 
        end

        default :
        begin
          avmm_write         <=  avmm_waitrequest ? avmm_write : 0;
          avmm_read          <=  avmm_waitrequest ? avmm_read : 0; 
          avmm_address       <=  avmm_address;
          avmm_writedata     <=  avmm_writedata;
        end
      endcase
    end
  end


 assign  avmm_byteenable        =  {(AVMM_DATA_W/8){1'b1}};

endmodule //IW_fpga_i2c_slave2avmm
