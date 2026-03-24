module IW_sbr_port_router (
  sbr_pok,
  sbr_cg_en,
  sbr_port_MNPPUT,
  sbr_port_MPCPUT,
  sbr_port_MNPCUP,
  sbr_port_MPCCUP,
  sbr_port_MEOM,
  sbr_port_MPAYLOAD,
  sbr_port_TNPPUT,
  sbr_port_TPCPUT,
  sbr_port_TNPCUP,
  sbr_port_TPCCUP,
  sbr_port_TEOM,
  sbr_port_TPAYLOAD,
  sbr_port_SIDE_ISM_AGENT,
  sbr_port_SIDE_ISM_FABRIC,
  
  mux_data,
  demux_data
);

  parameter DATA_WIDTH = 8;

  parameter NUM_MUX_SIGNALS =  (9 + DATA_WIDTH );
  parameter NUM_DEMUX_SIGNALS =  (9 + DATA_WIDTH );



  // --------------------------------
  // Power ok
  // --------------------------------
  output                                    sbr_pok;
  
  input                                   sbr_cg_en;

  /***************************************************************************
   * Port 0 ports signals for when this port is considered to be a fabric port
   * A fabric port connects to agent ports.  Thus, it provides the fabric_ism
   **************************************************************************/
  output                                  sbr_port_MNPPUT;
  output                                  sbr_port_MPCPUT;
  input                                   sbr_port_MNPCUP;
  input                                   sbr_port_MPCCUP;
  output                                  sbr_port_MEOM;
  output [(DATA_WIDTH)-1:0]               sbr_port_MPAYLOAD;
  input                                   sbr_port_TNPPUT;
  input                                   sbr_port_TPCPUT;
  output                                  sbr_port_TNPCUP;
  output                                  sbr_port_TPCCUP;
  input                                   sbr_port_TEOM;
  input [(DATA_WIDTH)-1:0]                sbr_port_TPAYLOAD;
  output [2:0]                            sbr_port_SIDE_ISM_AGENT;
  input [2:0]                             sbr_port_SIDE_ISM_FABRIC;
  /****************************************************************************************
   * Bundelled signals for mux/demux
   ****************************************************************************************/
  output [NUM_MUX_SIGNALS-1 :0]           mux_data;
  input [NUM_DEMUX_SIGNALS-1 :0]          demux_data;

  /****************************************************************************************/

  wire [NUM_MUX_SIGNALS-1 :0]             mux_signals;
  wire [NUM_DEMUX_SIGNALS-1 :0]           demux_signals;


  assign mux_data = {
                sbr_cg_en,
                sbr_port_MNPCUP,
                sbr_port_MPCCUP,
                sbr_port_TNPPUT,
                sbr_port_TPCPUT,
                sbr_port_TEOM,
                sbr_port_TPAYLOAD,
                sbr_port_SIDE_ISM_FABRIC
        };

  assign {
                sbr_pok,
                sbr_port_TNPCUP,
                sbr_port_TPCCUP,
                sbr_port_MNPPUT,
                sbr_port_MPCPUT,
                sbr_port_MEOM,
                sbr_port_MPAYLOAD,
                sbr_port_SIDE_ISM_AGENT
        } = demux_data;


endmodule

