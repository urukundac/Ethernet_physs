module IW_sbr_port_endpoint (
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
  input                                    sbr_pok;
  
  output                                   sbr_cg_en;

  /***************************************************************************
   * Port 0 ports signals for when this port is considered to be a fabric port
   * A fabric port connects to agent ports.  Thus, it provides the fabric_ism
   **************************************************************************/
  input                                  sbr_port_MNPPUT;
  input                                  sbr_port_MPCPUT;
  output                                 sbr_port_MNPCUP;
  output                                 sbr_port_MPCCUP;
  input                                  sbr_port_MEOM;
  input [(DATA_WIDTH)-1:0]               sbr_port_MPAYLOAD;
  output                                 sbr_port_TNPPUT;
  output                                 sbr_port_TPCPUT;
  input                                  sbr_port_TNPCUP;
  input                                  sbr_port_TPCCUP;
  output                                 sbr_port_TEOM;
  output [(DATA_WIDTH)-1:0]              sbr_port_TPAYLOAD;
  input [2:0]                            sbr_port_SIDE_ISM_AGENT;
  output [2:0]                           sbr_port_SIDE_ISM_FABRIC;
  /****************************************************************************************
   * Bundelled signals for mux/demux
   ****************************************************************************************/
  output [NUM_MUX_SIGNALS-1 :0]           mux_data;
  input [NUM_DEMUX_SIGNALS-1 :0]          demux_data;

  /****************************************************************************************/

  wire [NUM_MUX_SIGNALS-1 :0]             mux_signals;
  wire [NUM_DEMUX_SIGNALS-1 :0]           demux_signals;


  assign {
                sbr_cg_en,
                sbr_port_MNPCUP,
                sbr_port_MPCCUP,
                sbr_port_TNPPUT,
                sbr_port_TPCPUT,
                sbr_port_TEOM,
                sbr_port_TPAYLOAD,
                sbr_port_SIDE_ISM_FABRIC
        } = demux_data;

  assign mux_data = {
                sbr_pok,
                sbr_port_TNPCUP,
                sbr_port_TPCCUP,
                sbr_port_MNPPUT,
                sbr_port_MPCPUT,
                sbr_port_MEOM,
                sbr_port_MPAYLOAD,
                sbr_port_SIDE_ISM_AGENT
        };


endmodule

