////////////////////////////////////////////////////////////////////////////////////////////////
// this module is the top for the generic transactor chassis                                  //
// this module includes all instantiations that are required in order to bring up             //
// the FGC and the transactor connected to it                                            //
//                                                                                            //
// from one side it is connected to the pcie, from the other side to the the transactors      //
//                                                                                            //
// AS DRAWN IN VISIO FILE                                                                     //
// written by: idanreuv, January 2020                                                         //
////////////////////////////////////////////////////////////////////////////////////////////////
module fpga_transactors_top # (
				parameter 		EXT_PIPE_SIM        					= "FALSE",
				parameter 		LOCAL_BUS_IS_28b						= "FALSE",
				parameter 		PL_FAST_TRAIN       					= "FALSE", // Simulation Speedup
				parameter 		PCIE_EXT_CLK        					= "TRUE",    // Use External Clocking Module
				parameter 		PCIE_EXT_GT_COMMON  					= "FALSE",
				parameter 		REF_CLK_FREQ        					= 0,	       
				parameter 		C_DATA_WIDTH        					= 128, // RX/TX interface data width
				//parameter 		KEEP_WIDTH          					= C_DATA_WIDTH / 8, // TSTRB Width
				 `ifndef USE_AXIS_70
				parameter 		KEEP_WIDTH        						= C_DATA_WIDTH / 32, // TSTRB Width
				parameter 		COMP_USER_WIDTH     					= 33,
				parameter 		REQ_USER_WIDTH      					= 85,
				`else
				parameter 		KEEP_WIDTH        						= C_DATA_WIDTH / 8, // TSTRB Width
				parameter 		COMP_USER_WIDTH     					= 22,
				parameter 		REQ_USER_WIDTH      					= 22,
				`endif 
				`ifdef PCIE_BRIDGE
                parameter [255:0] BDF_LIST 								= 256'h1,
                    parameter logic [127:0] PCIE_BRIDGE_PHY_TYPE   			= `ifdef USE_ALTERA_PCIE_BRIDGE "STRATIX10M" `else "HAPS_80" `endif, 
                `endif
                `ifdef FGT_DPI
                parameter 		HVCS_MEM_PORT_NUMBER 					= 54000,
                parameter 		HVCS_INTERRUPT_PORT_NUMBER 				= 55000,
                parameter string HVCS_MEM_SOCKET_READY_FILE 			= "hvcs_mem_socket_ready",
                parameter string HVCS_INTERRUPT_SOCKET_READY_FILE 		= "hvcs_interrupt_socket_ready",
                `endif 
				parameter 		ENABLE_ILA          					= 1,
				parameter 		NUM_OF_DUMMY_TRANSACTOR   				= 0, //0>=NUM_OF_DUMMY_TRANSACTOR<=15
				parameter 		NUM_OF_CXL_CACHE_HOST   				= 0,
				parameter 		NUM_OF_CXL_CACHE_DEVICE     			= 0,
				parameter 		NUM_OF_CXL_CACHE_V3_HOST   				= 0,
				parameter 		NUM_OF_CXL_CACHE_V3_DEVICE     			= 0,
				parameter 		NUM_OF_CXL_G_FABRIC     			    = 0,
				parameter 		NUM_OF_CXL_G_AGENT   				 	= 0,
				parameter 		NUM_OF_CXL_MEM_MASTER     				= 0,           
				parameter 		NUM_OF_CXL_MEM_SLAVE      				= 0,
				parameter     	NUM_OF_DDI_TRANSACTOR             		= 0,
				//parameter NUM_OF_C2U_IDI_TRANSACTOR 				= 0, //0>=NUM_OF_C2U_IDI_TRANSACTOR<=15
				//parameter NUM_OF_CMI_REQ_TRANSACTOR 				= 0, //0>=NUM_OF_CMI_REQ_TRANSACTOR<=15
				//parameter NUM_OF_CMI_RSP_TRANSACTOR 				= 0, //0>=NUM_OF_CMI_RSP_TRANSACTOR<=15
				parameter 		NUM_OF_UFI_1_FABRIC 					= 0,
				parameter 		NUM_OF_UFI_1_AGENT 						= 0,
				parameter 		NUM_OF_ICXL_HOST			 			= 0,
				parameter 		NUM_OF_ICXL_DEVICE		 				= 0,
				parameter 		NUM_OF_SB_AGENT_TRANSACTOR   			= 0,
				parameter 		NUM_OF_SB_FABRIC_TRANSACTOR  			= 0,
				parameter 		NUM_OF_TEMPLATE_TRANSACTOR  			= 0,
				parameter 		NUM_OF_AXIM_SLAVE_TRANSACTOR 			= 0,        
				parameter 		NUM_OF_AXIM_MASTER_TRANSACTOR 			= 0,
				parameter 		NUM_OF_GPIO_TRANSACTOR 					= 0,
				parameter 		NUM_OF_AUX_TRANSACTOR 					= 0,
				parameter 		NUM_OF_ADDITIONAL_COMM_BLOCKS 			= 0,
				parameter 		NUM_OF_APB_MASTER_TRANSACTOR 			= 0,
				parameter 		NUM_OF_APB_SLAVE_TRANSACTOR 			= 0,
        		parameter 		NUM_OF_CFI_TRANSACTOR 					= 0,
        		parameter 		NUM_OF_DDR_BACKDOOR_TRANSACTOR 			= 0,
        		parameter 		NUM_OF_UFI_2_FABRIC 					= 0,
       			parameter 		NUM_OF_UFI_2_AGENT 						= 0,
       			parameter 		NUM_OF_SFI_TRANSACTOR					= 0,
				parameter 		NUM_OF_IOSF_P_TRANSACTOR        		= 0,
				
				parameter 		NUM_OF_COMM_BLOCK_USED_FOR_DIRECT		= 0,
				
        		parameter int 	SB_AGENT_MAXPLDBIT				[5:0] 	= '{default:7},
				parameter int 	SB_FABRIC_MAXPLDBIT				[5:0]  	= '{default:7},
        		parameter int 	SB_AGENT_SUPPORT_HSB_AND_SSB	[5:0] 	= '{default:0},
        		parameter int 	SB_FABRIC_SUPPORT_HSB_AND_SSB	[5:0] 	= '{default:0},
        		parameter int 	TEMPLATE_INPUT_PORT_WIDTH		[5:0] 	= '{default:7},
        		parameter int 	TEMPLATE_OUTPUT_PORT_WIDTH		[5:0]  	= '{default:7},

        		parameter 		AXIMM_PORTS_TO_TRANSACTOR 				= 1,    //number of aximm ports to transactor, per communication block
				parameter 		SAMPLE_AXI_FROM_CROSSBAR				= 0,	
				parameter 		AXIMM_DATA_SIZE           				= 64,   //64 or 128, this is the size of the data of the aximm		
				parameter 		FIFO_DATA_SIZE            				= 128,  //this is the size of the data that comes into/from the fifo and interface with the transactor
				parameter 		AXIM_LOOPBACK           				= 0,
				parameter 		GPIO_LOOPBACK           				= 0,
				parameter 		UFI_2_LOOPBACK           				= 0,
				parameter int   NUM_OF_GPIO_IN          		[3:0]  	= {128,128,128,128},
				parameter int   NUM_OF_GPIO_OUT         		[3:0]  	= {128,128,128,128},
				parameter int   DDI_GENERATOR               	[3:0]   = '{default:1},
				parameter int   DDI_NUM_EMBEDDED_PORTS      	[3:0]   = '{default:1},
				parameter int   DDI_NUM_LANES               	[3:0]   = '{default:1},
				parameter int   RESET_VALUE_GPIO        		[3:0]  	= {128'b0,128'b0,128'b0,128'b0},
				parameter int   AXIM_MASTER_ADDR_COMMAND_WIDTH	[3:0]  	= {128,128,128,128},
				parameter int   AXIM_SLAVE_ADDR_COMMAND_WIDTH 	[3:0]  	= {128,128,128,128},
				parameter int   AXI_MASTER_DATA_WIDTH   		[3:0]  	= {128,128,128,512},
				parameter int   AXI_SLAVE_DATA_WIDTH    		[3:0]   = {128,128,128,512},
				parameter int   CXL_G_MAX_CREDITS               		= 12, 
				parameter int 	MISORDER_TEST           				= 0,

				parameter		HPARITY									= 1,
				parameter  		M										= 1,
				parameter  		H										= 32,
				parameter int 	SFI_D							[5:0]	= '{default:64}, //supported values: 64, 128
				parameter  		DS										= 1,
				parameter  		NDCRD									= 4,
				parameter  		NHCRD									= 4,

				parameter 		APB_LOOPBACK           					= 0,
				parameter 		CFI_LOOPBACK           					= 0,
				parameter 		SFI_LOOPBACK           					= 0,
				parameter 		IOSF_P_LOOPBACK             			= 0,
				parameter int 	IOSF_FIP_IS_FABRIC 				[3:0] 	= {0, // iosf_p_xtor 3
																		   0, // iosf_p_xtor 2
																	       0, // iosf_p_xtor 1
																	       1},  // iosf_p_xtor 0          
                                             
 
		    `include "IOSF_P_param_on_top.sv"
	
        //those paramter are used in the communication block,
        //each of the numbers goes to a communication block by it's order
        //the range is form 0 and up to 16 fifos in a level of fifos
        //for zero fifos enter 4'b0, for 16 fifo
        parameter bit[3:0] NUM_OF_TX_FIFO [14:0] = {4'd1, //for communication block 14
                                               4'd1, //for communication block 13
                                               4'd1, //for communication block 12
                                               4'd1, //for communication block 11
                                               4'd1, //for communication block 10
                                               4'd1, //for communication block 9
                                               4'd1, //for communication block 8
                                               4'd1, //for communication block 7
                                               4'd1, //for communication block 6
                                               4'd1, //for communication block 5
                                               4'd1, //for communication block 4
                                               4'd1, //for communication block 3
                                               4'd1, //for communication block 2
                                               4'd1, //for communication block 1
                                               4'd1  //for communication block 0
                                               },

        parameter bit[3:0] NUM_OF_RX_FIFO [14:0] = {4'd1, //for communication block 14
                                               4'd1, //for communication block 13
                                               4'd1, //for communication block 12
                                               4'd1, //for communication block 11
                                               4'd1, //for communication block 10
                                               4'd1, //for communication block 9
                                               4'd1, //for communication block 8
                                               4'd1, //for communication block 7
                                               4'd1, //for communication block 6
                                               4'd1, //for communication block 5
                                               4'd1, //for communication block 4
                                               4'd1, //for communication block 3
                                               4'd1, //for communication block 2
                                               4'd1, //for communication block 1
                                               4'd1  //for communication block 0 
                                               },	       

        parameter UFI_1_COUNT_MAX              					= 5'd12,
        parameter UFI_1_NUM_OF_CREDIT_CH       					= 1,
        parameter bit [4:0] UFI_1_CREDIT_ID [15:0] = {5'b0,//, // vc_id(3bits),protocol_id(2bits)
                                                5'b0, 
                                                5'b0,
                                                5'b0, 
                                                5'b0,
                                                5'b0, 
                                                5'b0,
                                                5'b0, 
                                                5'b0,
                                                5'b0, 
                                                5'b0,
                                                5'b0, 
                                                5'b0,
                                                5'b0, 
                                                5'b0,
                                                5'b0},
        parameter UFI_2_COUNT_MAX              					= 5'd12,
        parameter UFI_2_NUM_OF_CREDIT_CH       					= 1,
        parameter bit [5:0] UFI_2_CREDIT_ID [15:0] = {6'b0,//, // vc_id(3bits),protocol_id(2bits)
                                                6'b0, 
                                                6'b0,
                                                6'b0, 
                                                6'b0,
                                                6'b0, 
                                                6'b0,
                                                6'b0, 
                                                6'b0,
                                                6'b0, 
                                                6'b0,
                                                6'b0, 
                                                6'b0,
                                                6'b0, 
                                                6'b0,
                                                6'b0},
       parameter CFI_COUNT_MAX              		   = 5'd12,                                         
       parameter int CFI_EARLY_DELAY               = 1,                                           
       parameter int CFI_AGENT_MODE [3:0] =   {0, // cfi_xtor 3
                                               0, // cfi_xtor 2
                                               1, // cfi_xtor 1
                                               0}  // cfi_xtor 0 
       `ifdef FGT_DPI
        ,parameter int HVCS_PORT_NUMBER = 54000
        ,parameter string HVCS_SOCKET_READY_FILE = "hvcs_socket_ready"
       `endif
                                 
                                                    )
(
  `ifndef PCIE_BRIDGE
	 `ifndef ALTERA_BOARD 
    `ifdef VIRTEX7
    // GPIOlink interface
	input 				       	haps_gpioLink_in, // Serial input signal from the GPIOLINK_IN pad of the FPGA
	output 				       	haps_gpioLink_out, // Serial output signal to the GPIOLINK_OUT pad of the FPGA
   // System HAPS CAR

	input 				       	haps_gpioLink_clock, //100MHz
	input 				       	haps_gpioLink_reset_n, // Board reset used for GPIOLINK module
   `else // ifndef VIREX7
   	input           			haps80_mgb2_6_PERST,
    output        				haps80_mgb2_8_WAKE_N,
    output           			haps80_mgb2_9_PRSNT_n, 
    `endif //VIRTEX7
  `else //ifdef ALTERA_BOARD
    input              			altera_sys_rst_n, 
    input              			pcie_perst,
    input              			pcie_npor,
  `endif //ALTERA_BOARD
  `else // ifdef PCIE_BRIDGE
     `ifdef USE_ALTERA_PCIE_BRIDGE
        input                 altera_sys_rst_n,
        input              		pcie_perst, // UNUSED
        input              		pcie_npor, // UNUSED
      `else     
        input           			haps80_mgb2_6_PERST,
        output        				haps80_mgb2_8_WAKE_N,
        output           			haps80_mgb2_9_PRSNT_n, 
     `endif
  `endif // PCIE_BRIDGE

    
  `ifdef FGC_CDC 
    input      					fgc_clk,
  `endif 

  `ifdef F2F_BRIDGE
  output wire             fgt_rst_n,
  `endif
 	output  wire [3:0]  		pci_exp_txp,
	output  wire [3:0]  		pci_exp_txn,
	input   wire [3:0]  		pci_exp_rxp,
	input   wire [3:0]  		pci_exp_rxn,
	input   wire 	      		PCIE_REFCLK_P,
	input   wire 	      		PCIE_REFCLK_N
 
  

      




);


  parameter NUM_OF_COMM_BLOCKS = NUM_OF_DUMMY_TRANSACTOR    //+ NUM_OF_C2U_IDI_TRANSACTOR
                               //+ NUM_OF_CMI_REQ_TRANSACTOR  + NUM_OF_CMI_RSP_TRANSACTOR
                               + NUM_OF_CXL_CACHE_HOST    		+ NUM_OF_CXL_MEM_MASTER 
                               + NUM_OF_CXL_CACHE_DEVICE    	+ NUM_OF_CXL_MEM_SLAVE 
                               + NUM_OF_CXL_CACHE_V3_HOST   	+ NUM_OF_CXL_CACHE_V3_DEVICE
                               + NUM_OF_CXL_G_FABRIC          + NUM_OF_CXL_G_AGENT
                               + NUM_OF_DDI_TRANSACTOR
                               + NUM_OF_UFI_1_FABRIC  			+ NUM_OF_UFI_1_AGENT
                               + NUM_OF_ICXL_HOST				+ NUM_OF_ICXL_DEVICE
                               + NUM_OF_SB_AGENT_TRANSACTOR 	+ NUM_OF_SB_FABRIC_TRANSACTOR
                               + NUM_OF_TEMPLATE_TRANSACTOR 	+ NUM_OF_AXIM_SLAVE_TRANSACTOR
                               + NUM_OF_AXIM_MASTER_TRANSACTOR 	+ NUM_OF_GPIO_TRANSACTOR
                               + NUM_OF_AUX_TRANSACTOR 			+ NUM_OF_ADDITIONAL_COMM_BLOCKS
                               + NUM_OF_APB_MASTER_TRANSACTOR 	+ NUM_OF_APB_SLAVE_TRANSACTOR 
                               + NUM_OF_CFI_TRANSACTOR 			+ NUM_OF_DDR_BACKDOOR_TRANSACTOR 
                               + NUM_OF_UFI_2_FABRIC 			+ NUM_OF_UFI_2_AGENT 
                               + NUM_OF_SFI_TRANSACTOR 			+ NUM_OF_IOSF_P_TRANSACTOR;
 
  parameter START_OF_DUMMY            	    	= 0;
  parameter START_OF_CXL_CACHE_HOST 	    	= NUM_OF_DUMMY_TRANSACTOR;
  parameter START_OF_CXL_MEM_MASTER   	    	= START_OF_CXL_CACHE_HOST        	+ NUM_OF_CXL_CACHE_HOST;
  parameter START_OF_CXL_CACHE_DEVICE       	= START_OF_CXL_MEM_MASTER        	+ NUM_OF_CXL_MEM_MASTER;
  parameter START_OF_CXL_MEM_SLAVE    	    	= START_OF_CXL_CACHE_DEVICE      	+ NUM_OF_CXL_CACHE_DEVICE;
  //parameter START_OF_CMI_REQ          	    	= START_OF_CXL_MEM_SLAVE         	+ NUM_OF_CXL_MEM_SLAVE;
  //parameter START_OF_CMI_RSP          	    	= START_OF_CMI_REQ               	+ NUM_OF_CMI_REQ_TRANSACTOR;
  parameter START_OF_UFI_1_FABRIC       	    = START_OF_CXL_MEM_SLAVE         	+ NUM_OF_CXL_MEM_SLAVE;//START_OF_CMI_RSP               	+ NUM_OF_CMI_RSP_TRANSACTOR;
  parameter START_OF_UFI_1_AGENT              	= START_OF_UFI_1_FABRIC            	+ NUM_OF_UFI_1_FABRIC;
  parameter START_OF_ICXL_HOST       	    	= START_OF_UFI_1_AGENT             	+ NUM_OF_UFI_1_AGENT;
  parameter START_OF_ICXL_DEVICE       	    	= START_OF_ICXL_HOST             	+ NUM_OF_ICXL_HOST;
  parameter START_OF_SB_AGENT_TRANSACTOR    	= START_OF_ICXL_DEVICE           	+ NUM_OF_ICXL_DEVICE;
  parameter START_OF_SB_FABRIC_TRANSACTOR   	= START_OF_SB_AGENT_TRANSACTOR   	+ NUM_OF_SB_AGENT_TRANSACTOR;
  parameter START_OF_TEMPLATE_TRANSACTOR    	= START_OF_SB_FABRIC_TRANSACTOR  	+ NUM_OF_SB_FABRIC_TRANSACTOR;
  parameter START_OF_AXIM_SLAVE_TRANSACTOR  	= START_OF_TEMPLATE_TRANSACTOR   	+ NUM_OF_TEMPLATE_TRANSACTOR;
  parameter START_OF_AXIM_MASTER_TRANSACTOR 	= START_OF_AXIM_SLAVE_TRANSACTOR 	+ NUM_OF_AXIM_SLAVE_TRANSACTOR;
  parameter START_OF_GPIO_TRANSACTOR        	= START_OF_AXIM_MASTER_TRANSACTOR	+ NUM_OF_AXIM_MASTER_TRANSACTOR;
  parameter START_OF_AUX_TRANSACTOR          	= START_OF_GPIO_TRANSACTOR       	+ NUM_OF_GPIO_TRANSACTOR;    
  parameter START_OF_APB_MASTER_TRANSACTOR  	= START_OF_AUX_TRANSACTOR       	+ NUM_OF_AUX_TRANSACTOR; 
  parameter START_OF_APB_SLAVE_TRANSACTOR   	= START_OF_APB_MASTER_TRANSACTOR 	+ NUM_OF_APB_MASTER_TRANSACTOR;
  parameter START_OF_CFI_TRANSACTOR  			= START_OF_APB_SLAVE_TRANSACTOR  	+ NUM_OF_APB_SLAVE_TRANSACTOR;
  parameter START_OF_DDR_BACKDOOR_TRANSACTOR 	= START_OF_CFI_TRANSACTOR 			+ NUM_OF_CFI_TRANSACTOR; 
  parameter START_OF_UFI_2_FABRIC       	    = START_OF_DDR_BACKDOOR_TRANSACTOR	+ NUM_OF_DDR_BACKDOOR_TRANSACTOR;
  parameter START_OF_UFI_2_AGENT              	= START_OF_UFI_2_FABRIC 			+ NUM_OF_UFI_2_FABRIC; 
  parameter START_OF_CXL_CACHE_V3_HOST          = START_OF_UFI_2_AGENT        		+ NUM_OF_UFI_2_AGENT;
  parameter START_OF_CXL_CACHE_V3_DEVICE        = START_OF_CXL_CACHE_V3_HOST  		+ NUM_OF_CXL_CACHE_V3_HOST;
  parameter START_OF_DDI_TRANSACTOR             = START_OF_CXL_CACHE_V3_DEVICE 		+ NUM_OF_CXL_CACHE_V3_DEVICE;
  parameter START_OF_CXL_G_FABRIC               = START_OF_DDI_TRANSACTOR 			  + NUM_OF_DDI_TRANSACTOR;
  parameter START_OF_CXL_G_AGENT                = START_OF_CXL_G_FABRIC           + NUM_OF_CXL_G_FABRIC;
  parameter START_OF_SFI_TRANSACTOR            	= START_OF_CXL_G_AGENT 			      + NUM_OF_CXL_G_AGENT;   
  parameter START_OF_IOSF_P_TRANSACTOR 			= START_OF_SFI_TRANSACTOR			+ NUM_OF_SFI_TRANSACTOR;
  parameter START_OF_ADDITIONAL_COMM_BLOCKS 	= START_OF_IOSF_P_TRANSACTOR 		+ NUM_OF_IOSF_P_TRANSACTOR;
	
	
	
  	parameter DUMMY_TYPE    			 = 8'h0;
    parameter CXL_MEM_MASTER_TYPE        = 8'h1;
  	parameter CXL_MEM_SLAVE_TYPE         = 8'h2;
    parameter CXL_CACHE_HOST_TYPE        = 8'h3;
	parameter CXL_CACHE_DEVICE_TYPE      = 8'h4;	
	parameter UFI_1_FABRIC_TYPE      	 = 8'h5;	
	parameter UFI_1_AGENT_TYPE      	 = 8'h6;	
	parameter ICXL_HOST_TYPE      		 = 8'h7;	
	parameter ICXL_DEVICE_TYPE     		 = 8'h8;
    parameter SB_AGENT_TYPE   			 = 8'h9;
    parameter SB_FABRIC_TYPE  			 = 8'ha;
    parameter TEMPLATE_TYPE				 = 8'hb;
    parameter AXIM_SLAVE_TYPE			 = 8'hc;
    parameter AXIM_MASTER_TYPE			 = 8'hd;
    parameter GPIO_TYPE              	 = 8'he;
    parameter APB_MASTER_TYPE        	 = 8'hf;
    parameter APB_SLAVE_TYPE         	 = 8'h10;
//    parameter CFI_FABRIC_TYPE        = 8'h11;
    parameter DDR_BACKDOOR_TYPE      	 = 8'h12;
  	parameter UFI_2_FABRIC_TYPE     	 = 8'h13;	
  	parameter UFI_2_AGENT_TYPE      	 = 8'h14;	
	parameter SFI_TYPE      	 		 = 8'h15;
    parameter CXL_CACHE_V3_HOST_TYPE     = 8'h16;
	parameter CXL_CACHE_V3_DEVICE_TYPE 	 = 8'h17;
    parameter DDI_TYPE               = 8'h18;
    parameter CFI_TYPE        			 = 8'h20; // CFI_AGENT is 8'h21
    parameter AUX_TYPE        			 = 8'h23;
    parameter IOSF_P_TYPE        		 = 8'h24;
    parameter CXL_G_FABRIC_TYPE      = 8'h25;
  	parameter CXL_G_AGENT_TYPE       = 8'h26;

   
///////////////////////////////////////////////////////////////////////////////
//DO NOT CHANGE THIS PARAMETER - AUTO UPDATE IN DROP FLOW!!
          parameter DROP_VERSION = 29;    
///////////////////////////////////////////////////////////////////////////////

     /////////////////////////////////////////
     
  	parameter DUMMY_VERSION        				= 0;
    parameter CXL_MEM_VERSION               	= 0;
    parameter CXL_CACHE_VERSION             	= 0;
    parameter CXL_CACHE_V3_VERSION          	= 3;
    parameter CXL_G_VERSION          	        = 0;
   	parameter UFI_1_FABRIC_VERSION 		    	= 0;	
   	parameter UFI_1_AGENT_VERSION    	        = 0;	
   	parameter ICXL_HOST_VERSION     	    	= 0;	
  	parameter ICXL_DEVICE_VERSION     			= 0;
    parameter SB_AGENT_TRANSACTOR_VERSION   	= 0;
    parameter SB_FABRIC_TRANSACTOR_VERSION  	= 0; 
    parameter TEMPLATE_TRANSACTOR_VERSION   	= 0;
    parameter AXIM_SLAVE_TRANSACTOR_VERSION   	= 0;
    parameter AXIM_MASTER_TRANSACTOR_VERSION   	= 0;
    parameter GPIO_TRANSACTOR_VERSION   		= 2;
    parameter DDI_TRANSACTOR_VERSION            = 0;
    parameter APB_MASTER_TRANSACTOR_VERSION    	= 0;
    parameter APB_SLAVE_TRANSACTOR_VERSION    	= 0;
    parameter CFI_TRANSACTOR_VERSION    		= 1;
    parameter DDR_BACKDOOR_TRANSACTOR_VERSION   = 0;
    parameter UFI_2_FABRIC_VERSION 		        = 0;	
   	parameter UFI_2_AGENT_VERSION    	        = 0;	
   	parameter SFI_TRANSACTOR_VERSION   	        = 2;
   	parameter AUX_TRANSACTOR_VERSION   	        = 0;	  
   	parameter IOSF_P_TRANSACTOR_VERSION         = 1;
   // parameter [255:0]   					= 256'h0;
    parameter NUM_OF_COMM_BLOCK_USED            = 0;
  //generic_chassis inst
  parameter NUM_OF_DUMMY = NUM_OF_DUMMY_TRANSACTOR;

`ifndef  COLLAGE_COMPILE

 `include "fpga_generic_chassis_with_dummy_inst.sv"

 `ifdef F2F_BRIDGE
  assign fgt_rst_n = generic_chassis_rst ;
  `endif
 
//wires for CXL_CACHE_UNCORE (HOST)

`include "CXL_CACHE_wires.sv"

//wires for CXL_MEM_MASTER - SHOULD BE MOVED INTO AN INCLUDE FILE AND INTO THE GENERATE BUT NOT IN THE LOOP!!!@@@@ 

`include "CXL_MEM_wires.sv"

  
  //generate instantiation for CXL CACHE HOST
  genvar f;
  generate if (NUM_OF_CXL_CACHE_HOST != 0) 
  begin: CXL_CACHE_HOST
    for (f=START_OF_CXL_CACHE_HOST; f<START_OF_CXL_MEM_MASTER; f++)
    begin
    
    assign client_clk[f] = cxl_cache_host_clk[f-START_OF_CXL_CACHE_HOST];
    
      CXL_Cache_Transactor_top # (
                          
                              .TRANSACTOR_TYPE(CXL_CACHE_HOST_TYPE),
                              .TRANSACTOR_VERSION(CXL_CACHE_VERSION)                            

)
      CXL_Cache_Transactor_top_inst
      (
        `ifdef FGC_CDC
        .generic_chassis_clk 	(fgc_clk),
        `else
        .generic_chassis_clk 	(user_clk),
        `endif
        .generic_chassis_rst 	(generic_chassis_rst), 
        .cxl_clk  	     	 	(cxl_cache_host_clk[f-START_OF_CXL_CACHE_HOST]),
        .cxl_rst_n     	 		(cxl_cache_host_rstn[f-START_OF_CXL_CACHE_HOST]),
        
        .dout_rx_fifo   		(dout_rx_fifo [f][4:0]), 
        .rd_rx_fifo     		(rd_rx_fifo   [f][4:0]), 
        .empty_rx_fifo  		(empty_rx_fifo[f][4:0]),

        .wr_tx_fifo     		(wr_tx_fifo   [f][4:0]),
        .din_tx_fifo    		(din_tx_fifo  [f][4:0]),
        .full_tx_fifo   		(full_tx_fifo [f][4:0]),

        .C2U_DATA_CREDIT_RETURN      (CXL_CACHE_C2U_DATA_CREDIT_RETURN      [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_CREDIT_RETURN       (CXL_CACHE_C2U_REQ_CREDIT_RETURN       [f-START_OF_CXL_CACHE_HOST]),
        .C2U_RSP_CREDIT_RETURN       (CXL_CACHE_C2U_RSP_CREDIT_RETURN       [f-START_OF_CXL_CACHE_HOST]),
        .U2C_DATA_CHUNKVALID         (CXL_CACHE_U2C_DATA_CHUNKVALID         [f-START_OF_CXL_CACHE_HOST]),
        .U2C_DATA_CQID               (CXL_CACHE_U2C_DATA_CQID               [f-START_OF_CXL_CACHE_HOST]),
        .U2C_DATA_DATA               (CXL_CACHE_U2C_DATA_DATA               [f-START_OF_CXL_CACHE_HOST]),
        .U2C_DATA_ECC                (CXL_CACHE_U2C_DATA_ECC                [f-START_OF_CXL_CACHE_HOST]),
        .U2C_DATA_ECC_VALID          (CXL_CACHE_U2C_DATA_ECC_VALID          [f-START_OF_CXL_CACHE_HOST]),
        .U2C_DATA_GO_ERR             (CXL_CACHE_U2C_DATA_GO_ERR             [f-START_OF_CXL_CACHE_HOST]),
        .U2C_DATA_PARITY             (CXL_CACHE_U2C_DATA_PARITY             [f-START_OF_CXL_CACHE_HOST]),
        .U2C_DATA_POISON             (CXL_CACHE_U2C_DATA_POISON             [f-START_OF_CXL_CACHE_HOST]),
        .U2C_DATA_PRE                (CXL_CACHE_U2C_DATA_PRE                [f-START_OF_CXL_CACHE_HOST]),
        .U2C_DATA_SPARE              (CXL_CACHE_U2C_DATA_SPARE              [f-START_OF_CXL_CACHE_HOST]),
        .U2C_DATA_VALID              (CXL_CACHE_U2C_DATA_VALID              [f-START_OF_CXL_CACHE_HOST]),
        .U2C_REQ_ADDRESS             (CXL_CACHE_U2C_REQ_ADDRESS             [f-START_OF_CXL_CACHE_HOST]),
        .U2C_REQ_UQID                (CXL_CACHE_U2C_REQ_UQID                [f-START_OF_CXL_CACHE_HOST]),
        .U2C_REQ_ADDRPARITY          (CXL_CACHE_U2C_REQ_ADDRPARITY          [f-START_OF_CXL_CACHE_HOST]),
        .U2C_REQ_OPCODE              (CXL_CACHE_U2C_REQ_OPCODE              [f-START_OF_CXL_CACHE_HOST]),
        .U2C_REQ_REQDATA             (CXL_CACHE_U2C_REQ_REQDATA             [f-START_OF_CXL_CACHE_HOST]),
        .U2C_REQ_SPARE               (CXL_CACHE_U2C_REQ_SPARE               [f-START_OF_CXL_CACHE_HOST]),
        .U2C_REQ_VALID               (CXL_CACHE_U2C_REQ_VALID               [f-START_OF_CXL_CACHE_HOST]),
        .U2C_RSP_CQID                (CXL_CACHE_U2C_RSP_CQID                [f-START_OF_CXL_CACHE_HOST]),
        .U2C_RSP_OPCODE              (CXL_CACHE_U2C_RSP_OPCODE              [f-START_OF_CXL_CACHE_HOST]),
        .U2C_RSP_PRE                 (CXL_CACHE_U2C_RSP_PRE                 [f-START_OF_CXL_CACHE_HOST]),
        .U2C_RSP_RSPDATA             (CXL_CACHE_U2C_RSP_RSPDATA             [f-START_OF_CXL_CACHE_HOST]),
        .U2C_RSP_SPARE               (CXL_CACHE_U2C_RSP_SPARE               [f-START_OF_CXL_CACHE_HOST]),
        .U2C_RSP_VALID               (CXL_CACHE_U2C_RSP_VALID               [f-START_OF_CXL_CACHE_HOST]),
        .C2U_DATA_BOGUS              (CXL_CACHE_C2U_DATA_BOGUS              [f-START_OF_CXL_CACHE_HOST]),
        .C2U_DATA_BYTE_ENABLE        (CXL_CACHE_C2U_DATA_BYTE_ENABLE        [f-START_OF_CXL_CACHE_HOST]),
        .C2U_DATA_BYTE_ENABLE_PARITY (CXL_CACHE_C2U_DATA_BYTE_ENABLE_PARITY [f-START_OF_CXL_CACHE_HOST]),
        .C2U_DATA_CHUNKVALID         (CXL_CACHE_C2U_DATA_CHUNKVALID         [f-START_OF_CXL_CACHE_HOST]),
        .C2U_DATA_DATA               (CXL_CACHE_C2U_DATA_DATA               [f-START_OF_CXL_CACHE_HOST]),
        .C2U_DATA_ECC                (CXL_CACHE_C2U_DATA_ECC                [f-START_OF_CXL_CACHE_HOST]),
        .C2U_DATA_ECC_VALID          (CXL_CACHE_C2U_DATA_ECC_VALID          [f-START_OF_CXL_CACHE_HOST]),
        .C2U_DATA_FULL_LINE          (CXL_CACHE_C2U_DATA_FULL_LINE          [f-START_OF_CXL_CACHE_HOST]),
        .C2U_DATA_PARITY             (CXL_CACHE_C2U_DATA_PARITY             [f-START_OF_CXL_CACHE_HOST]),
        .C2U_DATA_POISON             (CXL_CACHE_C2U_DATA_POISON             [f-START_OF_CXL_CACHE_HOST]),
        .C2U_DATA_SPARE              (CXL_CACHE_C2U_DATA_SPARE              [f-START_OF_CXL_CACHE_HOST]),
        .C2U_DATA_UQID               (CXL_CACHE_C2U_DATA_UQID               [f-START_OF_CXL_CACHE_HOST]),
        .C2U_DATA_VALID              (CXL_CACHE_C2U_DATA_VALID              [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_ADDRESS             (CXL_CACHE_C2U_REQ_ADDRESS             [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_ADDRPARITY          (CXL_CACHE_C2U_REQ_ADDRPARITY          [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_CACHELOCALLY        (CXL_CACHE_C2U_REQ_CACHELOCALLY        [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_CACHEREMOTELY       (CXL_CACHE_C2U_REQ_CACHEREMOTELY       [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_CLOS                (CXL_CACHE_C2U_REQ_CLOS                [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_CQID                (CXL_CACHE_C2U_REQ_CQID                [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_NT                  (CXL_CACHE_C2U_REQ_NT                  [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_HASH                (CXL_CACHE_C2U_REQ_HASH                [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_LENGTH              (CXL_CACHE_C2U_REQ_LENGTH              [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_LPID                (CXL_CACHE_C2U_REQ_LPID                [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_NONTEMPORAL         (CXL_CACHE_C2U_REQ_NONTEMPORAL         [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_OPCODE              (CXL_CACHE_C2U_REQ_OPCODE              [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_OPGROUP             (CXL_CACHE_C2U_REQ_OPGROUP             [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_RMID                (CXL_CACHE_C2U_REQ_RMID                [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_SAI                 (CXL_CACHE_C2U_REQ_SAI                 [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_SLFSNP              (CXL_CACHE_C2U_REQ_SLFSNP              [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_SPARE               (CXL_CACHE_C2U_REQ_SPARE               [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_TOPOLOGY            (CXL_CACHE_C2U_REQ_TOPOLOGY            [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_VALID               (CXL_CACHE_C2U_REQ_VALID               [f-START_OF_CXL_CACHE_HOST]),
        .C2U_RSP_HLEABORT            (CXL_CACHE_C2U_RSP_HLEABORT            [f-START_OF_CXL_CACHE_HOST]),
        .C2U_RSP_MONEXIST            (CXL_CACHE_C2U_RSP_MONEXIST            [f-START_OF_CXL_CACHE_HOST]),
        .C2U_RSP_OPCODE              (CXL_CACHE_C2U_RSP_OPCODE              [f-START_OF_CXL_CACHE_HOST]),
        .C2U_RSP_SPARE               (CXL_CACHE_C2U_RSP_SPARE               [f-START_OF_CXL_CACHE_HOST]),
        .C2U_RSP_UQID                (CXL_CACHE_C2U_RSP_UQID                [f-START_OF_CXL_CACHE_HOST]),
        .C2U_RSP_VALID               (CXL_CACHE_C2U_RSP_VALID               [f-START_OF_CXL_CACHE_HOST]),
        .U2C_DATA_CREDIT_RETURN      (CXL_CACHE_U2C_DATA_CREDIT_RETURN      [f-START_OF_CXL_CACHE_HOST]),
        .U2C_REQ_CREDIT_RETURN       (CXL_CACHE_U2C_REQ_CREDIT_RETURN       [f-START_OF_CXL_CACHE_HOST]),
        .U2C_RSP_CREDIT_RETURN       (CXL_CACHE_U2C_RSP_CREDIT_RETURN       [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_CREDIT_RETURN_opt   (CXL_CACHE_C2U_REQ_CREDIT_RETURN_opt   [f-START_OF_CXL_CACHE_HOST]),
        .U2C_RSP_CQID_opt            (CXL_CACHE_U2C_RSP_CQID_opt            [f-START_OF_CXL_CACHE_HOST]),
        .U2C_RSP_OPCODE_opt          (CXL_CACHE_U2C_RSP_OPCODE_opt          [f-START_OF_CXL_CACHE_HOST]),
        .U2C_RSP_PRE_opt             (CXL_CACHE_U2C_RSP_PRE_opt             [f-START_OF_CXL_CACHE_HOST]),
        .U2C_RSP_RSPDATA_opt         (CXL_CACHE_U2C_RSP_RSPDATA_opt         [f-START_OF_CXL_CACHE_HOST]),
        .U2C_RSP_SPARE_opt           (CXL_CACHE_U2C_RSP_SPARE_opt           [f-START_OF_CXL_CACHE_HOST]),
        .U2C_RSP_VALID_opt           (CXL_CACHE_U2C_RSP_VALID_opt           [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_ADDRESS_opt         (CXL_CACHE_C2U_REQ_ADDRESS_opt         [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_ADDRPARITY_opt      (CXL_CACHE_C2U_REQ_ADDRPARITY_opt      [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_CACHELOCALLY_opt    (CXL_CACHE_C2U_REQ_CACHELOCALLY_opt    [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_CACHEREMOTELY_opt   (CXL_CACHE_C2U_REQ_CACHEREMOTELY_opt   [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_CLOS_opt            (CXL_CACHE_C2U_REQ_CLOS_opt            [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_CQID_opt            (CXL_CACHE_C2U_REQ_CQID_opt            [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_NT_opt              (CXL_CACHE_C2U_REQ_NT_opt              [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_HASH_opt            (CXL_CACHE_C2U_REQ_HASH_opt            [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_LENGTH_opt          (CXL_CACHE_C2U_REQ_LENGTH_opt          [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_LPID_opt            (CXL_CACHE_C2U_REQ_LPID_opt            [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_NONTEMPORAL_opt     (CXL_CACHE_C2U_REQ_NONTEMPORAL_opt     [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_OPCODE_opt          (CXL_CACHE_C2U_REQ_OPCODE_opt          [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_OPGROUP_opt         (CXL_CACHE_C2U_REQ_OPGROUP_opt         [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_RMID_opt            (CXL_CACHE_C2U_REQ_RMID_opt            [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_SAI_opt             (CXL_CACHE_C2U_REQ_SAI_opt             [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_SLFSNP_opt          (CXL_CACHE_C2U_REQ_SLFSNP_opt          [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_SPARE_opt           (CXL_CACHE_C2U_REQ_SPARE_opt           [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_TOPOLOGY_opt        (CXL_CACHE_C2U_REQ_TOPOLOGY_opt        [f-START_OF_CXL_CACHE_HOST]),
        .C2U_REQ_VALID_opt           (CXL_CACHE_C2U_REQ_VALID_opt           [f-START_OF_CXL_CACHE_HOST]),
        .U2C_RSP_CREDIT_RETURN_opt   (CXL_CACHE_U2C_RSP_CREDIT_RETURN_opt   [f-START_OF_CXL_CACHE_HOST]),
        
        //aximm interface with the client
        .aximm_awvalid    (client_aximm_awvalid[f]),
        .aximm_awready    (client_aximm_awready[f]),
        .aximm_awid       (client_aximm_awid[f]),
        .aximm_awaddr     (client_aximm_awaddr[f]),
        .aximm_awlen      (client_aximm_awlen[f]),
        .aximm_awsize     (client_aximm_awsize[f]),
        .aximm_awburst    (client_aximm_awburst[f]),
        .aximm_awlock     (client_aximm_awlock[f]),
        .aximm_awcache    (client_aximm_awcache[f]),
        .aximm_awqos      (client_aximm_awqos[f]),
                          
        .aximm_wvalid     (client_aximm_wvalid[f]),
        .aximm_wready     (client_aximm_wready[f]),
        .aximm_wlast      (client_aximm_wlast[f]),
        .aximm_wdata      (client_aximm_wdata[f]),
        .aximm_wstrb      (client_aximm_wstrb[f]),
           
        .aximm_bvalid     (client_aximm_bvalid[f]),
        .aximm_bready     (client_aximm_bready[f]),
        .aximm_bid        (client_aximm_bid[f]),
        .aximm_bresp      (client_aximm_bresp[f]),
           
        .aximm_arvalid    (client_aximm_arvalid[f]),
        .aximm_arready    (client_aximm_arready[f]),
        .aximm_arid       (client_aximm_arid[f]),
        .aximm_araddr     (client_aximm_araddr[f]),
        .aximm_arlen      (client_aximm_arlen[f]),
        .aximm_arsize     (client_aximm_arsize[f]),
        .aximm_arburst    (client_aximm_arburst[f]),
        .aximm_arlock     (client_aximm_arlock[f]),
        .aximm_arcache    (client_aximm_arcache[f]),
        .aximm_arqos      (client_aximm_arqos[f]),
        .aximm_rvalid     (client_aximm_rvalid[f]),
        .aximm_rready     (client_aximm_rready[f]),
        .aximm_rid        (client_aximm_rid[f]),
        .aximm_rdata      (client_aximm_rdata[f]),
        .aximm_rresp      (client_aximm_rresp[f]),
        .aximm_rlast      (client_aximm_rlast[f])     
       );                           
    
    assign rd_rx_fifo  [f][14:5] = 'b0;
    assign wr_tx_fifo  [f][14:5] = 'b0;
    assign din_tx_fifo [f][14:5] = 'b0;

    assign axi_rq_tdata_client[f]  = 'b0;
    assign axi_rq_tkeep_client[f]  = 'b0;
    assign axi_rq_tlast_client[f]  = 'b0;
    assign axi_rq_tuser_client[f]  = 'b0;
    assign axi_rq_tvalid_client[f] = 'b0;
    assign axi_rc_tready_client[f] = 'b0;
    
    assign	direct_axis_rx_tready_comm_block_to_client[f]	= 'b0;
	assign	direct_axis_tx_tdata_client_to_comm_block[f]	= 'b0;
	assign	direct_axis_tx_tkeep_client_to_comm_block[f]	= 'b0;
	assign	direct_axis_tx_tlast_client_to_comm_block[f]	= 'b0;
	assign	direct_axis_tx_tvalid_client_to_comm_block[f]	= 'b0;
	assign	direct_axis_tx_tuser_client_to_comm_block[f]	= 'b0;
                                   
    end                                                        
  end // :CXL_CACHE_HOST                                     
  endgenerate                                                   
                                                                
                                                                  
  //generate instantiation for CXL MEM MASTER                  
  genvar c;                                                    
  generate if (NUM_OF_CXL_MEM_MASTER != 0)                      
  begin: CXL_MEM_MASTER                                           
    for (c=START_OF_CXL_MEM_MASTER; c<START_OF_CXL_CACHE_DEVICE; c++)
    begin
    
    `ifdef FGC_CDC
    assign client_clk[c] = cxl_mem_master_clk[c-START_OF_CXL_MEM_MASTER];
    `else
    assign client_clk[c] = user_clk;//cxl_mem_master_clk[g-START_OF_CXL_MEM_MASTER];
    `endif
    
      cxl_mem_master_top # (
                            .TRANSACTOR_TYPE(CXL_MEM_MASTER_TYPE),
                            .TRANSACTOR_VERSION(CXL_MEM_VERSION)

)
      cxl_mem_master_top_inst
      (
         `ifdef FGC_CDC
        .generic_chassis_clk 	(fgc_clk),
        `else
        .generic_chassis_clk 	(user_clk),
        `endif
        .generic_chassis_rst 	(generic_chassis_rst),
        .cxl_clk  				(cxl_mem_master_clk[c-START_OF_CXL_MEM_MASTER]),
        .rstn     				(cxl_mem_master_rst_n[c-START_OF_CXL_MEM_MASTER]),

        .cxl_m2s_req_bus_out    (cxl_m2s_req_bus_out [c-START_OF_CXL_MEM_MASTER]),
        .cxl_m2s_rwd_bus_out    (cxl_m2s_rwd_bus_out [c-START_OF_CXL_MEM_MASTER]),
        .credit_s2m_drs_out     (credit_s2m_drs_out  [c-START_OF_CXL_MEM_MASTER]),
        .credit_s2m_ndr_out     (credit_s2m_ndr_out  [c-START_OF_CXL_MEM_MASTER]),
        .credit_m2s_req_in      (credit_m2s_req_in   [c-START_OF_CXL_MEM_MASTER]),
        .credit_m2s_rwd_in      (credit_m2s_rwd_in   [c-START_OF_CXL_MEM_MASTER]),
        .cxl_s2m_drs_bus_in     (cxl_s2m_drs_bus_in  [c-START_OF_CXL_MEM_MASTER]),
        .cxl_s2m_ndr_bus_in     (cxl_s2m_ndr_bus_in  [c-START_OF_CXL_MEM_MASTER]),
        
        .m2s_req_fifo_data_in   (dout_rx_fifo [c][0]), //fifo 0 on comm block j
        .m2s_req_fifo_re_out    (rd_rx_fifo   [c][0]), //fifo 0 on comm block j
        .m2s_req_fifo_empty_in  (empty_rx_fifo[c][0]), //fifo 0 on comm block j
        .m2s_rwd_fifo_data_in   (dout_rx_fifo [c][1]), //fifo 1 on comm block j
        .m2s_rwd_fifo_re_out    (rd_rx_fifo   [c][1]), //fifo 1 on comm block j
        .m2s_rwd_fifo_empty_in  (empty_rx_fifo[c][1]), //fifo 1 on comm block j

        .s2m_drs_fifo_data_out  (din_tx_fifo  [c][0]), //fifo 0 on comm block j
        .s2m_drs_fifo_we_out    (wr_tx_fifo   [c][0]), //fifo 0 on comm block j
        .s2m_drs_fifo_wait_in   (full_tx_fifo [c][0]), //fifo 0 on comm block j
        .s2m_ndr_fifo_data_out  (din_tx_fifo  [c][1]), //fifo 1 on comm block j
        .s2m_ndr_fifo_we_out    (wr_tx_fifo   [c][1]), //fifo 1 on comm block j
        .s2m_ndr_fifo_wait_in   (full_tx_fifo [c][1]), //fifo 1 on comm block j
        
        .aximm_awvalid    (client_aximm_awvalid[c]),
        .aximm_awready    (client_aximm_awready[c]),
        .aximm_awid       (client_aximm_awid[c]),
        .aximm_awaddr     (client_aximm_awaddr[c]),
        .aximm_awlen      (client_aximm_awlen[c]),
        .aximm_awsize     (client_aximm_awsize[c]),
        .aximm_awburst    (client_aximm_awburst[c]),
        .aximm_awlock     (client_aximm_awlock[c]),
        .aximm_awcache    (client_aximm_awcache[c]),
        .aximm_awqos      (client_aximm_awqos[c]),
                          
        .aximm_wvalid     (client_aximm_wvalid[c]),
        .aximm_wready     (client_aximm_wready[c]),
        .aximm_wlast      (client_aximm_wlast[c]),
        .aximm_wdata      (client_aximm_wdata[c]),
        .aximm_wstrb      (client_aximm_wstrb[c]),
           
        .aximm_bvalid     (client_aximm_bvalid[c]),
        .aximm_bready     (client_aximm_bready[c]),
        .aximm_bid        (client_aximm_bid[c]),
        .aximm_bresp      (client_aximm_bresp[c]),
           
        .aximm_arvalid    (client_aximm_arvalid[c]),
        .aximm_arready    (client_aximm_arready[c]),
        .aximm_arid       (client_aximm_arid[c]),
        .aximm_araddr     (client_aximm_araddr[c]),
        .aximm_arlen      (client_aximm_arlen[c]),
        .aximm_arsize     (client_aximm_arsize[c]),
        .aximm_arburst    (client_aximm_arburst[c]),
        .aximm_arlock     (client_aximm_arlock[c]),
        .aximm_arcache    (client_aximm_arcache[c]),
        .aximm_arqos      (client_aximm_arqos[c]),
        .aximm_rvalid     (client_aximm_rvalid[c]),
        .aximm_rready     (client_aximm_rready[c]),
        .aximm_rid        (client_aximm_rid[c]),
        .aximm_rdata      (client_aximm_rdata[c]),
        .aximm_rresp      (client_aximm_rresp[c]),
        .aximm_rlast      (client_aximm_rlast[c])     
      );

    assign axi_rq_tdata_client[c]  = 'b0;
    assign axi_rq_tkeep_client[c]  = 'b0;
    assign axi_rq_tlast_client[c]  = 'b0;
    assign axi_rq_tuser_client[c]  = 'b0;
    assign axi_rq_tvalid_client[c] = 'b0;
    assign axi_rc_tready_client[c] = 'b0;
    
    assign	direct_axis_rx_tready_comm_block_to_client[c]	= 'b0;
	assign	direct_axis_tx_tdata_client_to_comm_block[c]	= 'b0;
	assign	direct_axis_tx_tkeep_client_to_comm_block[c]	= 'b0;
	assign	direct_axis_tx_tlast_client_to_comm_block[c]	= 'b0;
	assign	direct_axis_tx_tvalid_client_to_comm_block[c]	= 'b0;
	assign	direct_axis_tx_tuser_client_to_comm_block[c]	= 'b0;

    end
  end // :CXL_MEM_MASTER
  endgenerate

  assign cxl_cache_device_clock  = user_clk;
  assign cxl_cache_device_rst_n = ~generic_chassis_rst;
    
  //generate instantiation for CXL CACHE DEVICE
  genvar h;
  generate if (NUM_OF_CXL_CACHE_DEVICE != 0) 
  begin: CXL_CACHE_DEVICE
  
    for (h=START_OF_CXL_CACHE_DEVICE; h<START_OF_CXL_MEM_SLAVE; h++)
    begin
    
     assign client_clk[h] = cxl_cache_host_clk[h-START_OF_CXL_CACHE_DEVICE];
    
    
      CXL_Cache_Transactor_DEVICE_top # (

                                     .TRANSACTOR_TYPE(CXL_CACHE_DEVICE_TYPE), 
                                     .TRANSACTOR_VERSION(CXL_CACHE_VERSION)                           

)
      CXL_Cache_Transactor_DEVICE_top_inst
      (
         `ifdef FGC_CDC
        .generic_chassis_clk 	(fgc_clk),
        `else
        .generic_chassis_clk 	(user_clk),
        `endif
        .generic_chassis_rst 	(generic_chassis_rst),     
        .cxl_clk  	      		(cxl_cache_host_clk[h-START_OF_CXL_CACHE_DEVICE]),
        .cxl_rst_n      	  	(cxl_cache_host_rstn[h-START_OF_CXL_CACHE_DEVICE]),
        
        .dout_rx_fifo   (dout_rx_fifo [h][4:0]), 
        .rd_rx_fifo     (rd_rx_fifo   [h][4:0]), 
        .empty_rx_fifo  (empty_rx_fifo[h][4:0]),

        .wr_tx_fifo     (wr_tx_fifo   [h][4:0]),
        .din_tx_fifo    (din_tx_fifo  [h][4:0]),
        .full_tx_fifo   (full_tx_fifo [h][4:0]),

        .C2U_DATA_CREDIT_RETURN_device      (cxl_cache_C2U_DATA_CREDIT_RETURN      [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_CREDIT_RETURN_device       (cxl_cache_C2U_REQ_CREDIT_RETURN       [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_RSP_CREDIT_RETURN_device       (cxl_cache_C2U_RSP_CREDIT_RETURN       [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_DATA_CHUNKVALID_device         (cxl_cache_U2C_DATA_CHUNKVALID         [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_DATA_CQID_device               (cxl_cache_U2C_DATA_CQID               [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_DATA_DATA_device               (cxl_cache_U2C_DATA_DATA               [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_DATA_ECC_device                (cxl_cache_U2C_DATA_ECC                [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_DATA_ECC_VALID_device          (cxl_cache_U2C_DATA_ECC_VALID          [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_DATA_GO_ERR_device             (cxl_cache_U2C_DATA_GO_ERR             [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_DATA_PARITY_device             (cxl_cache_U2C_DATA_PARITY             [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_DATA_POISON_device             (cxl_cache_U2C_DATA_POISON             [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_DATA_PRE_device                (cxl_cache_U2C_DATA_PRE                [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_DATA_SPARE_device              (cxl_cache_U2C_DATA_SPARE              [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_DATA_VALID_device              (cxl_cache_U2C_DATA_VALID              [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_REQ_ADDRESS_device             (cxl_cache_U2C_REQ_ADDRESS             [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_REQ_UQID_device                (cxl_cache_U2C_REQ_UQID                [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_REQ_ADDRPARITY_device          (cxl_cache_U2C_REQ_ADDRPARITY          [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_REQ_OPCODE_device              (cxl_cache_U2C_REQ_OPCODE              [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_REQ_REQDATA_device             (cxl_cache_U2C_REQ_REQDATA             [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_REQ_SPARE_device               (cxl_cache_U2C_REQ_SPARE               [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_REQ_VALID_device               (cxl_cache_U2C_REQ_VALID               [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_RSP_CQID_device                (cxl_cache_U2C_RSP_CQID                [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_RSP_OPCODE_device              (cxl_cache_U2C_RSP_OPCODE              [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_RSP_PRE_device                 (cxl_cache_U2C_RSP_PRE                 [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_RSP_RSPDATA_device             (cxl_cache_U2C_RSP_RSPDATA             [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_RSP_SPARE_device               (cxl_cache_U2C_RSP_SPARE               [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_RSP_VALID_device               (cxl_cache_U2C_RSP_VALID               [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_DATA_BOGUS_device              (cxl_cache_C2U_DATA_BOGUS              [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_DATA_BYTE_ENABLE_device        (cxl_cache_C2U_DATA_BYTE_ENABLE        [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_DATA_BYTE_ENABLE_PARITY_device (cxl_cache_C2U_DATA_BYTE_ENABLE_PARITY [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_DATA_CHUNKVALID_device         (cxl_cache_C2U_DATA_CHUNKVALID         [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_DATA_DATA_device               (cxl_cache_C2U_DATA_DATA               [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_DATA_ECC_device                (cxl_cache_C2U_DATA_ECC                [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_DATA_ECC_VALID_device          (cxl_cache_C2U_DATA_ECC_VALID          [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_DATA_FULL_LINE_device          (cxl_cache_C2U_DATA_FULL_LINE          [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_DATA_PARITY_device             (cxl_cache_C2U_DATA_PARITY             [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_DATA_POISON_device             (cxl_cache_C2U_DATA_POISON             [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_DATA_SPARE_device              (cxl_cache_C2U_DATA_SPARE              [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_DATA_UQID_device               (cxl_cache_C2U_DATA_UQID               [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_DATA_VALID_device              (cxl_cache_C2U_DATA_VALID              [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_ADDRESS_device             (cxl_cache_C2U_REQ_ADDRESS             [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_ADDRPARITY_device          (cxl_cache_C2U_REQ_ADDRPARITY          [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_CACHELOCALLY_device        (cxl_cache_C2U_REQ_CACHELOCALLY        [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_CACHEREMOTELY_device       (cxl_cache_C2U_REQ_CACHEREMOTELY       [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_CLOS_device                (cxl_cache_C2U_REQ_CLOS                [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_CQID_device                (cxl_cache_C2U_REQ_CQID                [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_NT_device                  (cxl_cache_C2U_REQ_NT                  [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_HASH_device                (cxl_cache_C2U_REQ_HASH                [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_LENGTH_device              (cxl_cache_C2U_REQ_LENGTH              [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_LPID_device                (cxl_cache_C2U_REQ_LPID                [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_NONTEMPORAL_device         (cxl_cache_C2U_REQ_NONTEMPORAL         [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_OPCODE_device              (cxl_cache_C2U_REQ_OPCODE              [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_OPGROUP_device             (cxl_cache_C2U_REQ_OPGROUP             [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_RMID_device                (cxl_cache_C2U_REQ_RMID                [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_SAI_device                 (cxl_cache_C2U_REQ_SAI                 [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_SLFSNP_device              (cxl_cache_C2U_REQ_SLFSNP              [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_SPARE_device               (cxl_cache_C2U_REQ_SPARE               [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_TOPOLOGY_device            (cxl_cache_C2U_REQ_TOPOLOGY            [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_VALID_device               (cxl_cache_C2U_REQ_VALID               [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_RSP_HLEABORT_device            (cxl_cache_C2U_RSP_HLEABORT            [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_RSP_MONEXIST_device            (cxl_cache_C2U_RSP_MONEXIST            [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_RSP_OPCODE_device              (cxl_cache_C2U_RSP_OPCODE              [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_RSP_SPARE_device               (cxl_cache_C2U_RSP_SPARE               [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_RSP_UQID_device                (cxl_cache_C2U_RSP_UQID                [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_RSP_VALID_device               (cxl_cache_C2U_RSP_VALID               [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_DATA_CREDIT_RETURN_device      (cxl_cache_U2C_DATA_CREDIT_RETURN      [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_REQ_CREDIT_RETURN_device       (cxl_cache_U2C_REQ_CREDIT_RETURN       [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_RSP_CREDIT_RETURN_device       (cxl_cache_U2C_RSP_CREDIT_RETURN       [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_CREDIT_RETURN_opt_device   (cxl_cache_C2U_REQ_CREDIT_RETURN_opt   [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_RSP_CQID_opt_device            (cxl_cache_U2C_RSP_CQID_opt            [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_RSP_OPCODE_opt_device          (cxl_cache_U2C_RSP_OPCODE_opt          [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_RSP_PRE_opt_device             (cxl_cache_U2C_RSP_PRE_opt             [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_RSP_RSPDATA_opt_device         (cxl_cache_U2C_RSP_RSPDATA_opt         [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_RSP_SPARE_opt_device           (cxl_cache_U2C_RSP_SPARE_opt           [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_RSP_VALID_opt_device           (cxl_cache_U2C_RSP_VALID_opt           [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_ADDRESS_opt_device         (cxl_cache_C2U_REQ_ADDRESS_opt         [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_ADDRPARITY_opt_device      (cxl_cache_C2U_REQ_ADDRPARITY_opt      [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_CACHELOCALLY_opt_device    (cxl_cache_C2U_REQ_CACHELOCALLY_opt    [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_CACHEREMOTELY_opt_device   (cxl_cache_C2U_REQ_CACHEREMOTELY_opt   [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_CLOS_opt_device            (cxl_cache_C2U_REQ_CLOS_opt            [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_CQID_opt_device            (cxl_cache_C2U_REQ_CQID_opt            [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_NT_opt_device              (cxl_cache_C2U_REQ_NT_opt              [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_HASH_opt_device            (cxl_cache_C2U_REQ_HASH_opt            [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_LENGTH_opt_device          (cxl_cache_C2U_REQ_LENGTH_opt          [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_LPID_opt_device            (cxl_cache_C2U_REQ_LPID_opt            [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_NONTEMPORAL_opt_device     (cxl_cache_C2U_REQ_NONTEMPORAL_opt     [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_OPCODE_opt_device          (cxl_cache_C2U_REQ_OPCODE_opt          [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_OPGROUP_opt_device         (cxl_cache_C2U_REQ_OPGROUP_opt         [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_RMID_opt_device            (cxl_cache_C2U_REQ_RMID_opt            [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_SAI_opt_device             (cxl_cache_C2U_REQ_SAI_opt             [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_SLFSNP_opt_device          (cxl_cache_C2U_REQ_SLFSNP_opt          [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_SPARE_opt_device           (cxl_cache_C2U_REQ_SPARE_opt           [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_TOPOLOGY_opt_device        (cxl_cache_C2U_REQ_TOPOLOGY_opt        [h-START_OF_CXL_CACHE_DEVICE]),
        .C2U_REQ_VALID_opt_device           (cxl_cache_C2U_REQ_VALID_opt           [h-START_OF_CXL_CACHE_DEVICE]),
        .U2C_RSP_CREDIT_RETURN_opt_device   (cxl_cache_U2C_RSP_CREDIT_RETURN_opt   [h-START_OF_CXL_CACHE_DEVICE]),
       
        //aximm interface with the client
        .aximm_awvalid    (client_aximm_awvalid[h]),
        .aximm_awready    (client_aximm_awready[h]),
        .aximm_awid       (client_aximm_awid[h]),
        .aximm_awaddr     (client_aximm_awaddr[h]),
        .aximm_awlen      (client_aximm_awlen[h]),
        .aximm_awsize     (client_aximm_awsize[h]),
        .aximm_awburst    (client_aximm_awburst[h]),
        .aximm_awlock     (client_aximm_awlock[h]),
        .aximm_awcache    (client_aximm_awcache[h]),
        .aximm_awqos      (client_aximm_awqos[h]),
                          
        .aximm_wvalid     (client_aximm_wvalid[h]),
        .aximm_wready     (client_aximm_wready[h]),
        .aximm_wlast      (client_aximm_wlast[h]),
        .aximm_wdata      (client_aximm_wdata[h]),
        .aximm_wstrb      (client_aximm_wstrb[h]),
           
        .aximm_bvalid     (client_aximm_bvalid[h]),
        .aximm_bready     (client_aximm_bready[h]),
        .aximm_bid        (client_aximm_bid[h]),
        .aximm_bresp      (client_aximm_bresp[h]),
           
        .aximm_arvalid    (client_aximm_arvalid[h]),
        .aximm_arready    (client_aximm_arready[h]),
        .aximm_arid       (client_aximm_arid[h]),
        .aximm_araddr     (client_aximm_araddr[h]),
        .aximm_arlen      (client_aximm_arlen[h]),
        .aximm_arsize     (client_aximm_arsize[h]),
        .aximm_arburst    (client_aximm_arburst[h]),
        .aximm_arlock     (client_aximm_arlock[h]),
        .aximm_arcache    (client_aximm_arcache[h]),
        .aximm_arqos      (client_aximm_arqos[h]),
        .aximm_rvalid     (client_aximm_rvalid[h]),
        .aximm_rready     (client_aximm_rready[h]),
        .aximm_rid        (client_aximm_rid[h]),
        .aximm_rdata      (client_aximm_rdata[h]),
        .aximm_rresp      (client_aximm_rresp[h]),
        .aximm_rlast      (client_aximm_rlast[h])   
      );
      
    assign rd_rx_fifo  [h][14:5] = 'b0;
    assign wr_tx_fifo  [h][14:5] = 'b0;
    assign din_tx_fifo [h][14:5] = 'b0;

    assign axi_rq_tdata_client[h]  = 'b0;
    assign axi_rq_tkeep_client[h]  = 'b0;
    assign axi_rq_tlast_client[h]  = 'b0;
    assign axi_rq_tuser_client[h]  = 'b0;
    assign axi_rq_tvalid_client[h] = 'b0;
    assign axi_rc_tready_client[h] = 'b0;
    
    assign	direct_axis_rx_tready_comm_block_to_client[h]	= 'b0;
	assign	direct_axis_tx_tdata_client_to_comm_block[h]	= 'b0;
	assign	direct_axis_tx_tkeep_client_to_comm_block[h]	= 'b0;
	assign	direct_axis_tx_tlast_client_to_comm_block[h]	= 'b0;
	assign	direct_axis_tx_tvalid_client_to_comm_block[h]	= 'b0;
	assign	direct_axis_tx_tuser_client_to_comm_block[h]	= 'b0;
      
    end
  end // :CXL_CACHE_DEVICE
  endgenerate


  
  assign cxl_mem_master_clock  = user_clk;
  assign cxl_mem_master_rst_n = ~generic_chassis_rst;
    
  //generate instantiation for CXL MEM SLAVE
  genvar d;
  generate if (NUM_OF_CXL_MEM_SLAVE != 0) 
  begin: CXL_MEM_SLAVE
  
  for (d=START_OF_CXL_MEM_SLAVE; d<START_OF_UFI_1_FABRIC/*START_OF_CMI_REQ*/; d++)
    begin
    
    `ifdef FGC_CDC
     assign client_clk[d] = cxl_mem_master_clk[d-START_OF_CXL_MEM_SLAVE];
    `else
    assign client_clk[d] = user_clk;
    `endif
    assign s2m_drs_data = cxl_mem_cxl_s2m_drs_bus_in[0][383:128];    
    assign {s2m_drs_valid,s2m_drs_tag,s2m_drs_spare,s2m_drs_pre,s2m_drs_poison,s2m_drs_pcls,s2m_drs_opcode,s2m_drs_metavalue,s2m_drs_metafield,s2m_drs_eccvalid,s2m_drs_ecc,s2m_drs_data_parity} = cxl_mem_cxl_s2m_drs_bus_in[0][59:0];
    assign {s2m_ndr_valid,s2m_ndr_tag,s2m_ndr_spare,s2m_ndr_opcode,s2m_ndr_metavalue,s2m_ndr_metafield} = cxl_mem_cxl_s2m_ndr_bus_in;
    
      cxl_mem_slave_top # (
                             
                         .TRANSACTOR_TYPE(CXL_MEM_SLAVE_TYPE),
                         .TRANSACTOR_VERSION(CXL_MEM_VERSION)

                         )
      cxl_mem_slave_top_inst
      (
        `ifdef FGC_CDC
        .generic_chassis_clk 	(fgc_clk),
        `else
        .generic_chassis_clk 	(user_clk),
        `endif
        .generic_chassis_rst 	(generic_chassis_rst),
        .cxl_clk  				(cxl_mem_master_clk[d-START_OF_CXL_MEM_SLAVE]),
        .rstn     				(cxl_mem_master_rstn[d-START_OF_CXL_MEM_SLAVE]),

        .credit_m2s_req_out     (cxl_mem_credit_m2s_req_in   [d-START_OF_CXL_MEM_SLAVE]),
        .credit_m2s_rwd_out     (cxl_mem_credit_m2s_rwd_in   [d-START_OF_CXL_MEM_SLAVE]),
        .cxl_s2m_drs_bus_out    (cxl_mem_cxl_s2m_drs_bus_in  [d-START_OF_CXL_MEM_SLAVE]),
        .cxl_s2m_ndr_bus_out    (cxl_mem_cxl_s2m_ndr_bus_in  [d-START_OF_CXL_MEM_SLAVE]),
        .cxl_m2s_req_bus_in     (cxl_mem_cxl_m2s_req_bus_out [d-START_OF_CXL_MEM_SLAVE]),
        .cxl_m2s_rwd_bus_in     (cxl_mem_cxl_m2s_rwd_bus_out [d-START_OF_CXL_MEM_SLAVE]),
        .credit_s2m_drs_in      (cxl_mem_credit_s2m_drs_out  [d-START_OF_CXL_MEM_SLAVE]),
        .credit_s2m_ndr_in      (cxl_mem_credit_s2m_ndr_out  [d-START_OF_CXL_MEM_SLAVE]),
        
        .m2s_req_fifo_data_out  (din_tx_fifo  [d][0]), //fifo 0 on comm block j  
        .m2s_req_fifo_we_out    (wr_tx_fifo   [d][0]), //fifo 0 on comm block j
        .m2s_req_fifo_wait_in   (full_tx_fifo [d][0]), //fifo 0 on comm block j
        .m2s_rwd_fifo_data_out  (din_tx_fifo  [d][1]), //fifo 1 on comm block j
        .m2s_rwd_fifo_we_out    (wr_tx_fifo   [d][1]), //fifo 1 on comm block j
        .m2s_rwd_fifo_wait_in   (full_tx_fifo [d][1]), //fifo 1 on comm block j

        .s2m_drs_fifo_data_in   (dout_rx_fifo [d][0]), //fifo 0 on comm block j 
        .s2m_drs_fifo_re_out    (rd_rx_fifo   [d][0]), //fifo 0 on comm block j
        .s2m_drs_fifo_wait_in   (empty_rx_fifo[d][0]), //fifo 0 on comm block j
        .s2m_ndr_fifo_data_in   (dout_rx_fifo [d][1]), //fifo 1 on comm block j
        .s2m_ndr_fifo_re_out    (rd_rx_fifo   [d][1]), //fifo 1 on comm block j
        .s2m_ndr_fifo_wait_in   (empty_rx_fifo[d][1]), //fifo 1 on comm block j
               
        .aximm_awvalid    (client_aximm_awvalid[d]),
        .aximm_awready    (client_aximm_awready[d]),
        .aximm_awid       (client_aximm_awid[d]),
        .aximm_awaddr     (client_aximm_awaddr[d]),
        .aximm_awlen      (client_aximm_awlen[d]),
        .aximm_awsize     (client_aximm_awsize[d]),
        .aximm_awburst    (client_aximm_awburst[d]),
        .aximm_awlock     (client_aximm_awlock[d]),
        .aximm_awcache    (client_aximm_awcache[d]),
        .aximm_awqos      (client_aximm_awqos[d]),
                          
        .aximm_wvalid     (client_aximm_wvalid[d]),
        .aximm_wready     (client_aximm_wready[d]),
        .aximm_wlast      (client_aximm_wlast[d]),
        .aximm_wdata      (client_aximm_wdata[d]),
        .aximm_wstrb      (client_aximm_wstrb[d]),
           
        .aximm_bvalid     (client_aximm_bvalid[d]),
        .aximm_bready     (client_aximm_bready[d]),
        .aximm_bid        (client_aximm_bid[d]),
        .aximm_bresp      (client_aximm_bresp[d]),
           
        .aximm_arvalid    (client_aximm_arvalid[d]),
        .aximm_arready    (client_aximm_arready[d]),
        .aximm_arid       (client_aximm_arid[d]),
        .aximm_araddr     (client_aximm_araddr[d]),
        .aximm_arlen      (client_aximm_arlen[d]),
        .aximm_arsize     (client_aximm_arsize[d]),
        .aximm_arburst    (client_aximm_arburst[d]),
        .aximm_arlock     (client_aximm_arlock[d]),
        .aximm_arcache    (client_aximm_arcache[d]),
        .aximm_arqos      (client_aximm_arqos[d]),
        .aximm_rvalid     (client_aximm_rvalid[d]),
        .aximm_rready     (client_aximm_rready[d]),
        .aximm_rid        (client_aximm_rid[d]),
        .aximm_rdata      (client_aximm_rdata[d]),
        .aximm_rresp      (client_aximm_rresp[d]),
        .aximm_rlast      (client_aximm_rlast[d])    
      );

    assign axi_rq_tdata_client[d]  = 'b0;
    assign axi_rq_tkeep_client[d]  = 'b0;
    assign axi_rq_tlast_client[d]  = 'b0;
    assign axi_rq_tuser_client[d]  = 'b0;
    assign axi_rq_tvalid_client[d] = 'b0;
    assign axi_rc_tready_client[d] = 'b0;
    
    assign	direct_axis_rx_tready_comm_block_to_client[d]	= 'b0;
	assign	direct_axis_tx_tdata_client_to_comm_block[d]	= 'b0;
	assign	direct_axis_tx_tkeep_client_to_comm_block[d]	= 'b0;
	assign	direct_axis_tx_tlast_client_to_comm_block[d]	= 'b0;
	assign	direct_axis_tx_tvalid_client_to_comm_block[d]	= 'b0;
	assign	direct_axis_tx_tuser_client_to_comm_block[d]	= 'b0;

    end
  end // :CXL_MEM_SLAVE
  endgenerate

// UFI FABRIC transactor
//----------------------------------------------------------------------------

`include "UFI_wires.sv"

`ifdef GNR_PROJ
 `include "gnr_ufi_adaptation.sv"
 `ifdef GNR_LOOPBACK
   `include "gnr_ufi_lpbk.sv"
 `endif   
`endif  



  assign ufi_agent_clock_0  = user_clk;
  assign ufi_agent_rst_n_0  = ~generic_chassis_rst;
 assign ufi_agent_clock_1  = user_clk;
  assign ufi_agent_rst_n_1  = ~generic_chassis_rst;

  //generate instantiation for UFI Fabric
  genvar j;
  generate if (NUM_OF_UFI_1_FABRIC != 0) 
  begin: UFI_1_FABRIC
  
  for (j=START_OF_UFI_1_FABRIC; j<START_OF_UFI_1_FABRIC+NUM_OF_UFI_1_FABRIC; j++)
    begin


   `ifdef FGC_CDC
    assign client_clk[j] = ufi_agent_clock_0; 
   `else 
    assign client_clk[j] = user_clk;
  `endif
        
ufi_fabric_top   # (                            
                         .TRANSACTOR_TYPE		(UFI_1_FABRIC_TYPE),
                         .COUNT_MAX				(UFI_1_COUNT_MAX),
                         .NUM_OF_CREDIT_CH		(UFI_1_NUM_OF_CREDIT_CH),
                         .CREDIT_ID				(UFI_1_CREDIT_ID),
                        // .DEVICE_NUMBER			(cfg_device_number),
                         //.FUNCTION_NUMBER		(cfg_function_number),
                        // .BUS_NUMBER			(cfg_bus_number),
                         .TRANSACTOR_VERSION	(UFI_1_FABRIC_VERSION)
                         )
   ufi_fabric_top_inst(
   `ifdef FGC_CDC
     .fgc_clk 	(fgc_clk),
   `else
    .fgc_clk 	(user_clk),
  `endif						
    .generic_chassis_rst 	(generic_chassis_rst),
    .ufi_clk						  (ufi_fabric_clk[j-START_OF_UFI_1_FABRIC]),
    .rstn							    (ufi_fabric_rstn[j-START_OF_UFI_1_FABRIC]),

    .ufi_a2f_req_is_valid           (ufi_a2f_req_is_valid[j-START_OF_UFI_1_FABRIC]),    
    .ufi_a2f_req_protocol_id        (ufi_a2f_req_protocol_id[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_req_vc_id              (ufi_a2f_req_vc_id[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_req_header             (ufi_a2f_req_header[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_req_rxcrd              (ufi_a2f_req_rxcrd[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_req_rxcrd_protocol_id  (ufi_a2f_req_rxcrd_protocol_id[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_req_rxcrd_vc_id        (ufi_a2f_req_rxcrd_vc_id[j-START_OF_UFI_1_FABRIC]),
                                                                   
    .ufi_a2f_rsp_is_valid           (ufi_a2f_rsp_is_valid[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_rsp_protocol_id        (ufi_a2f_rsp_protocol_id[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_rsp_vc_id              (ufi_a2f_rsp_vc_id[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_rsp_header             (ufi_a2f_rsp_header[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_rsp_rxcrd              (ufi_a2f_rsp_rxcrd[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_rsp_rxcrd_protocol_id  (ufi_a2f_rsp_rxcrd_protocol_id[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_rsp_rxcrd_vc_id        (ufi_a2f_rsp_rxcrd_vc_id[j-START_OF_UFI_1_FABRIC]),
 
    .ufi_a2f_data_is_valid          (ufi_a2f_data_is_valid[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_data_protocol_id       (ufi_a2f_data_protocol_id[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_data_vc_id             (ufi_a2f_data_vc_id[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_data_header            (ufi_a2f_data_header[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_data_eop               (ufi_a2f_data_eop[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_data_payload           (ufi_a2f_data_payload[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_data_rxcrd             (ufi_a2f_data_rxcrd[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_data_rxcrd_protocol_id (ufi_a2f_data_rxcrd_protocol_id[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_data_rxcrd_vc_id       (ufi_a2f_data_rxcrd_vc_id[j-START_OF_UFI_1_FABRIC]),
                                                                    
    .ufi_f2a_req_is_valid           (ufi_f2a_req_is_valid[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_req_protocol_id        (ufi_f2a_req_protocol_id[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_req_vc_id              (ufi_f2a_req_vc_id[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_req_header             (ufi_f2a_req_header[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_req_rxcrd              (ufi_f2a_req_rxcrd[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_req_rxcrd_protocol_id  (ufi_f2a_req_rxcrd_protocol_id[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_req_rxcrd_vc_id        (ufi_f2a_req_rxcrd_vc_id[j-START_OF_UFI_1_FABRIC]),
                                                                     
    .ufi_f2a_rsp_is_valid           (ufi_f2a_rsp_is_valid[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_rsp_protocol_id        (ufi_f2a_rsp_protocol_id[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_rsp_vc_id              (ufi_f2a_rsp_vc_id[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_rsp_header             (ufi_f2a_rsp_header[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_rsp_rxcrd              (ufi_f2a_rsp_rxcrd[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_rsp_rxcrd_protocol_id  (ufi_f2a_rsp_rxcrd_protocol_id[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_rsp_rxcrd_vc_id        (ufi_f2a_rsp_rxcrd_vc_id[j-START_OF_UFI_1_FABRIC]),

                                                                     
    .ufi_f2a_data_is_valid          (ufi_f2a_data_is_valid[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_data_protocol_id       (ufi_f2a_data_protocol_id[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_data_vc_id             (ufi_f2a_data_vc_id[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_data_header            (ufi_f2a_data_header[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_data_eop               (ufi_f2a_data_eop[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_data_payload           (ufi_f2a_data_payload[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_data_rxcrd             (ufi_f2a_data_rxcrd[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_data_rxcrd_protocol_id (ufi_f2a_data_rxcrd_protocol_id[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_data_rxcrd_vc_id       (ufi_f2a_data_rxcrd_vc_id[j-START_OF_UFI_1_FABRIC]),

    .ufi_a2f_txcon_req              (ufi_a2f_txcon_req[j-START_OF_UFI_1_FABRIC]),                    
    .ufi_a2f_rx_ack                 (ufi_a2f_rx_ack[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_rx_empty               (ufi_a2f_rx_empty[j-START_OF_UFI_1_FABRIC]),
    .ufi_a2f_rxdiscon_nack          (ufi_a2f_rxdiscon_nack[j-START_OF_UFI_1_FABRIC]),
                                                               
    .ufi_f2a_txcon_req              (ufi_f2a_txcon_req[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_rx_ack                 (ufi_f2a_rx_ack[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_rx_empty               (ufi_f2a_rx_empty[j-START_OF_UFI_1_FABRIC]),
    .ufi_f2a_rxdiscon_nack      (ufi_f2a_rxdiscon_nack[j-START_OF_UFI_1_FABRIC]),

    .ufi_f2a_req_fifo_data_in   (dout_rx_fifo [j][0]),
    .ufi_f2a_req_fifo_re_out    (rd_rx_fifo   [j][0]),
    .ufi_f2a_req_fifo_empty_in  (empty_rx_fifo[j][0]), 

    .ufi_f2a_rsp_fifo_data_in   (dout_rx_fifo [j][1]),
    .ufi_f2a_rsp_fifo_re_out    (rd_rx_fifo   [j][1]),
    .ufi_f2a_rsp_fifo_empty_in  (empty_rx_fifo[j][1]), 

    .ufi_f2a_data_fifo_data_in  (dout_rx_fifo [j][2]),
    .ufi_f2a_data_fifo_re_out   (rd_rx_fifo   [j][2]),
    .ufi_f2a_data_fifo_empty_in (empty_rx_fifo[j][2]), 

    .ufi_a2f_req_fifo_data_out  (din_tx_fifo  [j][0]),
    .ufi_a2f_req_fifo_we_out    (wr_tx_fifo   [j][0]),
    .ufi_a2f_req_fifo_wait_in   (full_tx_fifo [j][0]),

    .ufi_a2f_rsp_fifo_data_out  (din_tx_fifo  [j][1]),
    .ufi_a2f_rsp_fifo_we_out    (wr_tx_fifo   [j][1]),
    .ufi_a2f_rsp_fifo_wait_in   (full_tx_fifo [j][1]),

    .ufi_a2f_data_fifo_data_out (din_tx_fifo  [j][2]),
    .ufi_a2f_data_fifo_we_out   (wr_tx_fifo   [j][2]),
    .ufi_a2f_data_fifo_wait_in  (full_tx_fifo [j][2]),
    
         .device_number			(cfg_device_number),
         .function_number		(cfg_function_number),
         .bus_number			(cfg_bus_number),
  
  .aximm_awvalid    (client_aximm_awvalid[j]),
  .aximm_awready    (client_aximm_awready[j]),
  .aximm_awid       (client_aximm_awid[j]),
  .aximm_awaddr     (client_aximm_awaddr[j]),
  .aximm_awlen      (client_aximm_awlen[j]),
  .aximm_awsize     (client_aximm_awsize[j]),
  .aximm_awburst    (client_aximm_awburst[j]),
  .aximm_awlock     (client_aximm_awlock[j]),
  .aximm_awcache    (client_aximm_awcache[j]),
  .aximm_awqos      (client_aximm_awqos[j]),
                    
  .aximm_wvalid     (client_aximm_wvalid[j]),
  .aximm_wready     (client_aximm_wready[j]),
  .aximm_wlast      (client_aximm_wlast[j]),
  .aximm_wdata      (client_aximm_wdata[j]),
  .aximm_wstrb      (client_aximm_wstrb[j]),
     
  .aximm_bvalid     (client_aximm_bvalid[j]),
  .aximm_bready     (client_aximm_bready[j]),
  .aximm_bid        (client_aximm_bid[j]),
  .aximm_bresp      (client_aximm_bresp[j]),
     
  .aximm_arvalid    (client_aximm_arvalid[j]),
  .aximm_arready    (client_aximm_arready[j]),
  .aximm_arid       (client_aximm_arid[j]),
  .aximm_araddr     (client_aximm_araddr[j]),
  .aximm_arlen      (client_aximm_arlen[j]),
  .aximm_arsize     (client_aximm_arsize[j]),
  .aximm_arburst    (client_aximm_arburst[j]),
  .aximm_arlock     (client_aximm_arlock[j]),
  .aximm_arcache    (client_aximm_arcache[j]),
  .aximm_arqos      (client_aximm_arqos[j]),
  
  .aximm_rvalid    (client_aximm_rvalid[j]),
  .aximm_rready    (client_aximm_rready[j]),
  .aximm_rid       (client_aximm_rid[j]),
  .aximm_rdata     (client_aximm_rdata[j]),
  .aximm_rresp     (client_aximm_rresp[j]),
  .aximm_rlast     (client_aximm_rlast[j]),

  .direct_axis_rx_tdata (axi_rc_tdata_client[j]),
  .direct_axis_rx_tkeep (axi_rc_tkeep_client[j]),
  .direct_axis_rx_tlast (axi_rc_tlast_client[j]),
  .direct_axis_rx_tvalid(axi_rc_tvalid_client[j]),
  .direct_axis_rx_tuser (axi_rc_tuser_client[j]),
  .direct_axis_rx_tready(axi_rc_tready_client[j]),
  .direct_axis_tx_tdata (axi_rq_tdata_client[j]),
  .direct_axis_tx_tkeep (axi_rq_tkeep_client[j]),
  .direct_axis_tx_tlast (axi_rq_tlast_client[j]),
  .direct_axis_tx_tvalid(axi_rq_tvalid_client[j]),
  .direct_axis_tx_tuser (axi_rq_tuser_client[j]),
  .direct_axis_tx_tready(axi_rq_tready_client[j]),  

  .ufi_fabric_aximm_debug_port_wire (ufi_fabric_aximm_debug_port_wire[j-START_OF_UFI_1_FABRIC]),
  .ufi_fabric_ufi_debug_port_wire   (ufi_fabric_ufi_debug_port_wire  [j-START_OF_UFI_1_FABRIC]) 
);
    
    
    assign rd_rx_fifo  [j][14:3] = 'b0;
	assign wr_tx_fifo  [j][14:3] = 'b0;
	assign din_tx_fifo [j][14:3] = 'b0;
		
	assign	direct_axis_rx_tready_comm_block_to_client[j]	= 'b0;
	assign	direct_axis_tx_tdata_client_to_comm_block[j]	= 'b0;
	assign	direct_axis_tx_tkeep_client_to_comm_block[j]	= 'b0;
	assign	direct_axis_tx_tlast_client_to_comm_block[j]	= 'b0;
	assign	direct_axis_tx_tvalid_client_to_comm_block[j]	= 'b0;
	assign	direct_axis_tx_tuser_client_to_comm_block[j]	= 'b0;
     
    end
  end // :UFI_1_FABRIC
  endgenerate
  // end of UFI FABRIC


  //generate instantiation for UFI Agent 0
//  genvar k;
  generate if (NUM_OF_UFI_1_AGENT != 0) 
  begin: UFI_1_AGENT_0
  
//  for (k=START_OF_UFI_1_AGENT; k<START_OF_UFI_1_AGENT+NUM_OF_UFI_1_AGENT; k++)
//    begin
   `ifdef FGC_CDC
    assign client_clk[START_OF_UFI_1_AGENT] = ufi_agent_clock_0; 
   `else 
    assign client_clk[START_OF_UFI_1_AGENT] = user_clk;
  `endif
    

ufi_agent_top # (                             
                         .TRANSACTOR_TYPE(UFI_1_AGENT_TYPE),
                         .COUNT_MAX(UFI_1_COUNT_MAX),
                         .NUM_OF_CREDIT_CH(UFI_1_NUM_OF_CREDIT_CH),
                         .CREDIT_ID(UFI_1_CREDIT_ID),
                         .TRANSACTOR_VERSION(UFI_1_AGENT_VERSION)
                         )
           ufi_agent_top_inst
(
    `ifdef FGC_CDC
     .fgc_clk 	(fgc_clk),
   `else
    .fgc_clk 	(user_clk),
  `endif	
    .generic_chassis_rst 			(generic_chassis_rst),
    .ufi_clk						(ufi_fabric_clk[0]),
    .rstn							(ufi_fabric_rstn[0]),

    .ufi_a2f_req_is_valid           (a2f_req_is_valid_0),    
    .ufi_a2f_req_protocol_id        (a2f_req_protocol_id_0),
    .ufi_a2f_req_vc_id              (a2f_req_vc_id_0),
    .ufi_a2f_req_header             (a2f_req_header_0),
    .ufi_a2f_req_rxcrd              (a2f_req_rxcrd_0),
    .ufi_a2f_req_rxcrd_protocol_id  (a2f_req_rxcrd_protocol_id_0),
    .ufi_a2f_req_rxcrd_vc_id        (a2f_req_rxcrd_vc_id_0),

                                                                   
    .ufi_a2f_rsp_is_valid           (a2f_rsp_is_valid_0),
    .ufi_a2f_rsp_protocol_id        (a2f_rsp_protocol_id_0),
    .ufi_a2f_rsp_vc_id              (a2f_rsp_vc_id_0),
    .ufi_a2f_rsp_header             (a2f_rsp_header_0),
    .ufi_a2f_rsp_rxcrd              (a2f_rsp_rxcrd_0),
    .ufi_a2f_rsp_rxcrd_protocol_id  (a2f_rsp_rxcrd_protocol_id_0),
    .ufi_a2f_rsp_rxcrd_vc_id        (a2f_rsp_rxcrd_vc_id_0),
 
    .ufi_a2f_data_is_valid          (a2f_data_is_valid_0),
    .ufi_a2f_data_protocol_id       (a2f_data_protocol_id_0),
    .ufi_a2f_data_vc_id             (a2f_data_vc_id_0),
    .ufi_a2f_data_header            (a2f_data_header_0),
    .ufi_a2f_data_eop               (a2f_data_eop_0),
    .ufi_a2f_data_payload           (a2f_data_payload_0),
    .ufi_a2f_data_rxcrd             (a2f_data_rxcrd_0),
    .ufi_a2f_data_rxcrd_protocol_id (a2f_data_rxcrd_protocol_id_0),
    .ufi_a2f_data_rxcrd_vc_id       (a2f_data_rxcrd_vc_id_0),
                                                                     
    .ufi_f2a_req_is_valid           (f2a_req_is_valid_0),
    .ufi_f2a_req_protocol_id        (f2a_req_protocol_id_0),
    .ufi_f2a_req_vc_id              (f2a_req_vc_id_0),
    .ufi_f2a_req_header             (f2a_req_header_0),
    .ufi_f2a_req_rxcrd              (f2a_req_rxcrd_0),
    .ufi_f2a_req_rxcrd_protocol_id  (f2a_req_rxcrd_protocol_id_0),
    .ufi_f2a_req_rxcrd_vc_id        (f2a_req_rxcrd_vc_id_0),
                                                                     
    .ufi_f2a_rsp_is_valid           (f2a_rsp_is_valid_0),
    .ufi_f2a_rsp_protocol_id        (f2a_rsp_protocol_id_0),
    .ufi_f2a_rsp_vc_id              (f2a_rsp_vc_id_0),
    .ufi_f2a_rsp_header             (f2a_rsp_header_0),
    .ufi_f2a_rsp_rxcrd              (f2a_rsp_rxcrd_0),
    .ufi_f2a_rsp_rxcrd_protocol_id  (f2a_rsp_rxcrd_protocol_id_0),
    .ufi_f2a_rsp_rxcrd_vc_id        (f2a_rsp_rxcrd_vc_id_0),

                                                                     
    .ufi_f2a_data_is_valid          (f2a_data_is_valid_0),
    .ufi_f2a_data_protocol_id       (f2a_data_protocol_id_0),
    .ufi_f2a_data_vc_id             (f2a_data_vc_id_0),
    .ufi_f2a_data_header            (f2a_data_header_0),
    .ufi_f2a_data_eop               (f2a_data_eop_0),
    .ufi_f2a_data_payload           (f2a_data_payload_0),
    .ufi_f2a_data_rxcrd             (f2a_data_rxcrd_0),
    .ufi_f2a_data_rxcrd_protocol_id (f2a_data_rxcrd_protocol_id_0),
    .ufi_f2a_data_rxcrd_vc_id       (f2a_data_rxcrd_vc_id_0),


    .ufi_a2f_txcon_req              (a2f_txcon_req_0),                    
    .ufi_a2f_rx_ack                 (a2f_rx_ack_0),
    .ufi_a2f_rx_empty               (a2f_rx_empty_0),
    .ufi_a2f_rxdiscon_nack          (a2f_rxdiscon_nack_0),
                                                               
    .ufi_f2a_txcon_req              (f2a_txcon_req_0),
    .ufi_f2a_rx_ack                 (f2a_rx_ack_0),
    .ufi_f2a_rx_empty               (f2a_rx_empty_0),
    .ufi_f2a_rxdiscon_nack          (f2a_rxdiscon_nack_0),

    .ufi_a2f_req_fifo_data_in   (dout_rx_fifo [START_OF_UFI_1_AGENT][0]),
    .ufi_a2f_req_fifo_re_out    (rd_rx_fifo   [START_OF_UFI_1_AGENT][0]),
    .ufi_a2f_req_fifo_empty_in  (empty_rx_fifo[START_OF_UFI_1_AGENT][0]), 

    .ufi_a2f_rsp_fifo_data_in   (dout_rx_fifo [START_OF_UFI_1_AGENT][1]),
    .ufi_a2f_rsp_fifo_re_out    (rd_rx_fifo   [START_OF_UFI_1_AGENT][1]),
    .ufi_a2f_rsp_fifo_empty_in  (empty_rx_fifo[START_OF_UFI_1_AGENT][1]), 

    .ufi_a2f_data_fifo_data_in  (dout_rx_fifo [START_OF_UFI_1_AGENT][2]),
    .ufi_a2f_data_fifo_re_out   (rd_rx_fifo   [START_OF_UFI_1_AGENT][2]),
    .ufi_a2f_data_fifo_empty_in (empty_rx_fifo[START_OF_UFI_1_AGENT][2]), 

    .ufi_f2a_req_fifo_data_out  (din_tx_fifo  [START_OF_UFI_1_AGENT][0]),
    .ufi_f2a_req_fifo_we_out    (wr_tx_fifo   [START_OF_UFI_1_AGENT][0]),
    .ufi_f2a_req_fifo_wait_in   (full_tx_fifo [START_OF_UFI_1_AGENT][0]),

    .ufi_f2a_rsp_fifo_data_out  (din_tx_fifo  [START_OF_UFI_1_AGENT][1]),
    .ufi_f2a_rsp_fifo_we_out    (wr_tx_fifo   [START_OF_UFI_1_AGENT][1]),
    .ufi_f2a_rsp_fifo_wait_in   (full_tx_fifo [START_OF_UFI_1_AGENT][1]),

    .ufi_f2a_data_fifo_data_out (din_tx_fifo  [START_OF_UFI_1_AGENT][2]),
    .ufi_f2a_data_fifo_we_out   (wr_tx_fifo   [START_OF_UFI_1_AGENT][2]),
    .ufi_f2a_data_fifo_wait_in  (full_tx_fifo [START_OF_UFI_1_AGENT][2]),
  
  .aximm_awvalid    (client_aximm_awvalid[START_OF_UFI_1_AGENT]),
  .aximm_awready    (client_aximm_awready[START_OF_UFI_1_AGENT]),
  .aximm_awid       (client_aximm_awid[START_OF_UFI_1_AGENT]),
  .aximm_awaddr     (client_aximm_awaddr[START_OF_UFI_1_AGENT]),
  .aximm_awlen      (client_aximm_awlen[START_OF_UFI_1_AGENT]),
  .aximm_awsize     (client_aximm_awsize[START_OF_UFI_1_AGENT]),
  .aximm_awburst    (client_aximm_awburst[START_OF_UFI_1_AGENT]),
  .aximm_awlock     (client_aximm_awlock[START_OF_UFI_1_AGENT]),
  .aximm_awcache    (client_aximm_awcache[START_OF_UFI_1_AGENT]),
  .aximm_awqos      (client_aximm_awqos[START_OF_UFI_1_AGENT]),
                    
  .aximm_wvalid     (client_aximm_wvalid[START_OF_UFI_1_AGENT]),
  .aximm_wready     (client_aximm_wready[START_OF_UFI_1_AGENT]),
  .aximm_wlast      (client_aximm_wlast[START_OF_UFI_1_AGENT]),
  .aximm_wdata      (client_aximm_wdata[START_OF_UFI_1_AGENT]),
  .aximm_wstrb      (client_aximm_wstrb[START_OF_UFI_1_AGENT]),
     
  .aximm_bvalid     (client_aximm_bvalid[START_OF_UFI_1_AGENT]),
  .aximm_bready     (client_aximm_bready[START_OF_UFI_1_AGENT]),
  .aximm_bid        (client_aximm_bid[START_OF_UFI_1_AGENT]),
  .aximm_bresp      (client_aximm_bresp[START_OF_UFI_1_AGENT]),
     
  .aximm_arvalid    (client_aximm_arvalid[START_OF_UFI_1_AGENT]),
  .aximm_arready    (client_aximm_arready[START_OF_UFI_1_AGENT]),
  .aximm_arid       (client_aximm_arid[START_OF_UFI_1_AGENT]),
  .aximm_araddr     (client_aximm_araddr[START_OF_UFI_1_AGENT]),
  .aximm_arlen      (client_aximm_arlen[START_OF_UFI_1_AGENT]),
  .aximm_arsize     (client_aximm_arsize[START_OF_UFI_1_AGENT]),
  .aximm_arburst    (client_aximm_arburst[START_OF_UFI_1_AGENT]),
  .aximm_arlock     (client_aximm_arlock[START_OF_UFI_1_AGENT]),
  .aximm_arcache    (client_aximm_arcache[START_OF_UFI_1_AGENT]),
  .aximm_arqos      (client_aximm_arqos[START_OF_UFI_1_AGENT]),
  
  .aximm_rvalid    (client_aximm_rvalid[START_OF_UFI_1_AGENT]),
  .aximm_rready    (client_aximm_rready[START_OF_UFI_1_AGENT]),
  .aximm_rid       (client_aximm_rid[START_OF_UFI_1_AGENT]),
  .aximm_rdata     (client_aximm_rdata[START_OF_UFI_1_AGENT]),
  .aximm_rresp     (client_aximm_rresp[START_OF_UFI_1_AGENT]),
  .aximm_rlast     (client_aximm_rlast[START_OF_UFI_1_AGENT])     
);
     
     
	assign rd_rx_fifo  [START_OF_UFI_1_AGENT][14:3] 		= 'b0;
	assign wr_tx_fifo  [START_OF_UFI_1_AGENT][14:3] 		= 'b0;
	assign din_tx_fifo [START_OF_UFI_1_AGENT][14:3] 		= 'b0;

    assign axi_rq_tdata_client[START_OF_UFI_1_AGENT]  		= 'b0;
    assign axi_rq_tkeep_client[START_OF_UFI_1_AGENT]  		= 'b0;
    assign axi_rq_tlast_client[START_OF_UFI_1_AGENT]  		= 'b0;
    assign axi_rq_tuser_client[START_OF_UFI_1_AGENT]  		= 'b0;
    assign axi_rq_tvalid_client[START_OF_UFI_1_AGENT] 		= 'b0;
    assign axi_rc_tready_client[START_OF_UFI_1_AGENT] 		= 'b0;
        
    assign	direct_axis_rx_tready_comm_block_to_client[START_OF_UFI_1_AGENT]	= 'b0;
	assign	direct_axis_tx_tdata_client_to_comm_block[START_OF_UFI_1_AGENT]		= 'b0;
	assign	direct_axis_tx_tkeep_client_to_comm_block[START_OF_UFI_1_AGENT]		= 'b0;
	assign	direct_axis_tx_tlast_client_to_comm_block[START_OF_UFI_1_AGENT]		= 'b0;
	assign	direct_axis_tx_tvalid_client_to_comm_block[START_OF_UFI_1_AGENT]	= 'b0;
	assign	direct_axis_tx_tuser_client_to_comm_block[START_OF_UFI_1_AGENT]		= 'b0;

  //  end
  end // :UFI_1_AGENT_0
  endgenerate
// End of UFI_1_AGENT



  //generate instantiation for UFI Agent 1
//  genvar k;
  generate if (NUM_OF_UFI_1_AGENT > 1) 
  begin: UFI_1_AGENT_1
  
//  for (k=START_OF_UFI_1_AGENT; k<START_OF_UFI_1_AGENT+NUM_OF_UFI_1_AGENT; k++)
//    begin

    `ifdef FGC_CDC
    assign  client_clk[START_OF_UFI_1_AGENT+1] = ufi_agent_clock_0; 
   `else 
    assign client_clk[START_OF_UFI_1_AGENT+1] = user_clk;
   `endif
    

ufi_agent_top # (                             
                         .TRANSACTOR_TYPE(UFI_1_AGENT_TYPE),
                         .COUNT_MAX(UFI_1_COUNT_MAX),
                         .NUM_OF_CREDIT_CH(UFI_1_NUM_OF_CREDIT_CH),
                         .CREDIT_ID(UFI_1_CREDIT_ID),
                         .TRANSACTOR_VERSION(UFI_1_AGENT_VERSION)
                         )
           ufi_agent_top_inst
(
   `ifdef FGC_CDC
     .fgc_clk 	(fgc_clk),
   `else
    .fgc_clk 	(user_clk),
  `endif	
    .generic_chassis_rst 			(generic_chassis_rst),
    .ufi_clk						(ufi_fabric_clk[1]),
    .rstn							(ufi_fabric_rstn[1]),

    .ufi_a2f_req_is_valid           (a2f_req_is_valid_1),    
    .ufi_a2f_req_protocol_id        (a2f_req_protocol_id_1),
    .ufi_a2f_req_vc_id              (a2f_req_vc_id_1),
    .ufi_a2f_req_header             (a2f_req_header_1),
    .ufi_a2f_req_rxcrd              (a2f_req_rxcrd_1),
    .ufi_a2f_req_rxcrd_protocol_id  (a2f_req_rxcrd_protocol_id_1),
    .ufi_a2f_req_rxcrd_vc_id        (a2f_req_rxcrd_vc_id_1),

                                                                   
    .ufi_a2f_rsp_is_valid           (a2f_rsp_is_valid_1),
    .ufi_a2f_rsp_protocol_id        (a2f_rsp_protocol_id_1),
    .ufi_a2f_rsp_vc_id              (a2f_rsp_vc_id_1),
    .ufi_a2f_rsp_header             (a2f_rsp_header_1),
    .ufi_a2f_rsp_rxcrd              (a2f_rsp_rxcrd_1),
    .ufi_a2f_rsp_rxcrd_protocol_id  (a2f_rsp_rxcrd_protocol_id_1),
    .ufi_a2f_rsp_rxcrd_vc_id        (a2f_rsp_rxcrd_vc_id_1),
 
    .ufi_a2f_data_is_valid          (a2f_data_is_valid_1),
    .ufi_a2f_data_protocol_id       (a2f_data_protocol_id_1),
    .ufi_a2f_data_vc_id             (a2f_data_vc_id_1),
    .ufi_a2f_data_header            (a2f_data_header_1),
    .ufi_a2f_data_eop               (a2f_data_eop_1),
    .ufi_a2f_data_payload           (a2f_data_payload_1),
    .ufi_a2f_data_rxcrd             (a2f_data_rxcrd_1),
    .ufi_a2f_data_rxcrd_protocol_id (a2f_data_rxcrd_protocol_id_1),
    .ufi_a2f_data_rxcrd_vc_id       (a2f_data_rxcrd_vc_id_1),
                                                                     
    .ufi_f2a_req_is_valid           (f2a_req_is_valid_1),
    .ufi_f2a_req_protocol_id        (f2a_req_protocol_id_1),
    .ufi_f2a_req_vc_id              (f2a_req_vc_id_1),
    .ufi_f2a_req_header             (f2a_req_header_1),
    .ufi_f2a_req_rxcrd              (f2a_req_rxcrd_1),
    .ufi_f2a_req_rxcrd_protocol_id  (f2a_req_rxcrd_protocol_id_1),
    .ufi_f2a_req_rxcrd_vc_id        (f2a_req_rxcrd_vc_id_1),
                                                                     
    .ufi_f2a_rsp_is_valid           (f2a_rsp_is_valid_1),
    .ufi_f2a_rsp_protocol_id        (f2a_rsp_protocol_id_1),
    .ufi_f2a_rsp_vc_id              (f2a_rsp_vc_id_1),
    .ufi_f2a_rsp_header             (f2a_rsp_header_1),
    .ufi_f2a_rsp_rxcrd              (f2a_rsp_rxcrd_1),
    .ufi_f2a_rsp_rxcrd_protocol_id  (f2a_rsp_rxcrd_protocol_id_1),
    .ufi_f2a_rsp_rxcrd_vc_id        (f2a_rsp_rxcrd_vc_id_1),

                                                                     
    .ufi_f2a_data_is_valid          (f2a_data_is_valid_1),
    .ufi_f2a_data_protocol_id       (f2a_data_protocol_id_1),
    .ufi_f2a_data_vc_id             (f2a_data_vc_id_1),
    .ufi_f2a_data_header            (f2a_data_header_1),
    .ufi_f2a_data_eop               (f2a_data_eop_1),
    .ufi_f2a_data_payload           (f2a_data_payload_1),
    .ufi_f2a_data_rxcrd             (f2a_data_rxcrd_1),
    .ufi_f2a_data_rxcrd_protocol_id (f2a_data_rxcrd_protocol_id_1),
    .ufi_f2a_data_rxcrd_vc_id       (f2a_data_rxcrd_vc_id_1),


    .ufi_a2f_txcon_req              (a2f_txcon_req_1),                    
    .ufi_a2f_rx_ack                 (a2f_rx_ack_1),
    .ufi_a2f_rx_empty               (a2f_rx_empty_1),
    .ufi_a2f_rxdiscon_nack          (a2f_rxdiscon_nack_1),
                                                               
    .ufi_f2a_txcon_req              (f2a_txcon_req_1),
    .ufi_f2a_rx_ack                 (f2a_rx_ack_1),
    .ufi_f2a_rx_empty               (f2a_rx_empty_1),
    .ufi_f2a_rxdiscon_nack          (f2a_rxdiscon_nack_1),

    .ufi_a2f_req_fifo_data_in   (dout_rx_fifo [START_OF_UFI_1_AGENT+1][0]),
    .ufi_a2f_req_fifo_re_out    (rd_rx_fifo   [START_OF_UFI_1_AGENT+1][0]),
    .ufi_a2f_req_fifo_empty_in  (empty_rx_fifo[START_OF_UFI_1_AGENT+1][0]), 

    .ufi_a2f_rsp_fifo_data_in   (dout_rx_fifo [START_OF_UFI_1_AGENT+1][1]),
    .ufi_a2f_rsp_fifo_re_out    (rd_rx_fifo   [START_OF_UFI_1_AGENT+1][1]),
    .ufi_a2f_rsp_fifo_empty_in  (empty_rx_fifo[START_OF_UFI_1_AGENT+1][1]), 

    .ufi_a2f_data_fifo_data_in  (dout_rx_fifo [START_OF_UFI_1_AGENT+1][2]),
    .ufi_a2f_data_fifo_re_out   (rd_rx_fifo   [START_OF_UFI_1_AGENT+1][2]),
    .ufi_a2f_data_fifo_empty_in (empty_rx_fifo[START_OF_UFI_1_AGENT+1][2]), 

    .ufi_f2a_req_fifo_data_out  (din_tx_fifo  [START_OF_UFI_1_AGENT+1][0]),
    .ufi_f2a_req_fifo_we_out    (wr_tx_fifo   [START_OF_UFI_1_AGENT+1][0]),
    .ufi_f2a_req_fifo_wait_in   (full_tx_fifo [START_OF_UFI_1_AGENT+1][0]),

    .ufi_f2a_rsp_fifo_data_out  (din_tx_fifo  [START_OF_UFI_1_AGENT+1][1]),
    .ufi_f2a_rsp_fifo_we_out    (wr_tx_fifo   [START_OF_UFI_1_AGENT+1][1]),
    .ufi_f2a_rsp_fifo_wait_in   (full_tx_fifo [START_OF_UFI_1_AGENT+1][1]),

    .ufi_f2a_data_fifo_data_out (din_tx_fifo  [START_OF_UFI_1_AGENT+1][2]),
    .ufi_f2a_data_fifo_we_out   (wr_tx_fifo   [START_OF_UFI_1_AGENT+1][2]),
    .ufi_f2a_data_fifo_wait_in  (full_tx_fifo [START_OF_UFI_1_AGENT+1][2]),
  
  .aximm_awvalid    (client_aximm_awvalid[START_OF_UFI_1_AGENT+1]),
  .aximm_awready    (client_aximm_awready[START_OF_UFI_1_AGENT+1]),
  .aximm_awid       (client_aximm_awid[START_OF_UFI_1_AGENT+1]),
  .aximm_awaddr     (client_aximm_awaddr[START_OF_UFI_1_AGENT+1]),
  .aximm_awlen      (client_aximm_awlen[START_OF_UFI_1_AGENT+1]),
  .aximm_awsize     (client_aximm_awsize[START_OF_UFI_1_AGENT+1]),
  .aximm_awburst    (client_aximm_awburst[START_OF_UFI_1_AGENT+1]),
  .aximm_awlock     (client_aximm_awlock[START_OF_UFI_1_AGENT+1]),
  .aximm_awcache    (client_aximm_awcache[START_OF_UFI_1_AGENT+1]),
  .aximm_awqos      (client_aximm_awqos[START_OF_UFI_1_AGENT+1]),
                    
  .aximm_wvalid     (client_aximm_wvalid[START_OF_UFI_1_AGENT+1]),
  .aximm_wready     (client_aximm_wready[START_OF_UFI_1_AGENT+1]),
  .aximm_wlast      (client_aximm_wlast[START_OF_UFI_1_AGENT+1]),
  .aximm_wdata      (client_aximm_wdata[START_OF_UFI_1_AGENT+1]),
  .aximm_wstrb      (client_aximm_wstrb[START_OF_UFI_1_AGENT+1]),
     
  .aximm_bvalid     (client_aximm_bvalid[START_OF_UFI_1_AGENT+1]),
  .aximm_bready     (client_aximm_bready[START_OF_UFI_1_AGENT+1]),
  .aximm_bid        (client_aximm_bid[START_OF_UFI_1_AGENT+1]),
  .aximm_bresp      (client_aximm_bresp[START_OF_UFI_1_AGENT+1]),
     
  .aximm_arvalid    (client_aximm_arvalid[START_OF_UFI_1_AGENT+1]),
  .aximm_arready    (client_aximm_arready[START_OF_UFI_1_AGENT+1]),
  .aximm_arid       (client_aximm_arid[START_OF_UFI_1_AGENT+1]),
  .aximm_araddr     (client_aximm_araddr[START_OF_UFI_1_AGENT+1]),
  .aximm_arlen      (client_aximm_arlen[START_OF_UFI_1_AGENT+1]),
  .aximm_arsize     (client_aximm_arsize[START_OF_UFI_1_AGENT+1]),
  .aximm_arburst    (client_aximm_arburst[START_OF_UFI_1_AGENT+1]),
  .aximm_arlock     (client_aximm_arlock[START_OF_UFI_1_AGENT+1]),
  .aximm_arcache    (client_aximm_arcache[START_OF_UFI_1_AGENT+1]),
  .aximm_arqos      (client_aximm_arqos[START_OF_UFI_1_AGENT+1]),
  
  .aximm_rvalid    (client_aximm_rvalid[START_OF_UFI_1_AGENT+1]),
  .aximm_rready    (client_aximm_rready[START_OF_UFI_1_AGENT+1]),
  .aximm_rid       (client_aximm_rid[START_OF_UFI_1_AGENT+1]),
  .aximm_rdata     (client_aximm_rdata[START_OF_UFI_1_AGENT+1]),
  .aximm_rresp     (client_aximm_rresp[START_OF_UFI_1_AGENT+1]),
  .aximm_rlast     (client_aximm_rlast[START_OF_UFI_1_AGENT+1])     
);
     
     
		assign rd_rx_fifo  [START_OF_UFI_1_AGENT+1][14:3] = 'b0;
		assign wr_tx_fifo  [START_OF_UFI_1_AGENT+1][14:3] = 'b0;
		assign din_tx_fifo [START_OF_UFI_1_AGENT+1][14:3] = 'b0;

        assign axi_rq_tdata_client[START_OF_UFI_1_AGENT+1]  = 'b0;
        assign axi_rq_tkeep_client[START_OF_UFI_1_AGENT+1]  = 'b0;
        assign axi_rq_tlast_client[START_OF_UFI_1_AGENT+1]  = 'b0;
        assign axi_rq_tuser_client[START_OF_UFI_1_AGENT+1]  = 'b0;
        assign axi_rq_tvalid_client[START_OF_UFI_1_AGENT+1] = 'b0;
        assign axi_rc_tready_client[START_OF_UFI_1_AGENT+1] = 'b0;
        
        assign	direct_axis_rx_tready_comm_block_to_client[START_OF_UFI_1_AGENT+1]	= 'b0;
		assign	direct_axis_tx_tdata_client_to_comm_block[START_OF_UFI_1_AGENT+1]	= 'b0;
		assign	direct_axis_tx_tkeep_client_to_comm_block[START_OF_UFI_1_AGENT+1]	= 'b0;
		assign	direct_axis_tx_tlast_client_to_comm_block[START_OF_UFI_1_AGENT+1]	= 'b0;
		assign	direct_axis_tx_tvalid_client_to_comm_block[START_OF_UFI_1_AGENT+1]	= 'b0;
		assign	direct_axis_tx_tuser_client_to_comm_block[START_OF_UFI_1_AGENT+1]	= 'b0;

  //  end
  end // :UFI_AGENT_1
  endgenerate
// End of UFI_1_AGENT



//ICXL transactor - HOST

`include "ICXL_wires.sv"
		
//generate instantiation for ICXL HOST
  genvar l;
  generate if (NUM_OF_ICXL_HOST != 0) 
  begin: ICXL_HOST
  
   for (l=START_OF_ICXL_HOST; l<START_OF_ICXL_HOST+NUM_OF_ICXL_HOST; l++)
    begin
    
    assign client_clk[l] = ICXL_host_clk[l-START_OF_ICXL_HOST];
   
   ICXL_HOST_Transactor_top  # (
                            .TRANSACTOR_TYPE(ICXL_HOST_TYPE),
                            .TRANSACTOR_VERSION(ICXL_HOST_VERSION)
)
	ICXL_HOST_Transactor_top_inst
        (
        `ifdef FGC_CDC
         .generic_chassis_clk 	(fgc_clk),
        `else
         .generic_chassis_clk 	(user_clk),
       `endif	
        .generic_chassis_rst 	(generic_chassis_rst),
        
        .ICXL_clk  	     	 	(ICXL_host_clk[l-START_OF_ICXL_HOST]),
        .ICXL_rst_n     	 	(ICXL_host_rstn[l-START_OF_ICXL_HOST]),
        
        .dout_rx_fifo   		(dout_rx_fifo [l][3:0]), 
        .rd_rx_fifo     		(rd_rx_fifo   [l][3:0]), 
        .empty_rx_fifo  		(empty_rx_fifo[l][3:0]),

        .wr_tx_fifo     		(wr_tx_fifo   [l][3:0]),
        .din_tx_fifo   			(din_tx_fifo  [l][3:0]),
        .full_tx_fifo   		(full_tx_fifo [l][3:0]),

		.HOST_CONNECT_REQ      				(ICXL_HOST_CONNECT_REQ      			[l-START_OF_ICXL_HOST]),
		.HOST_CONNECT_ACK      				(ICXL_HOST_CONNECT_ACK      			[l-START_OF_ICXL_HOST]),
		.DEVICE_CONNECT_REQ      			(ICXL_DEVICE_CONNECT_REQ      			[l-START_OF_ICXL_HOST]),
		.DEVICE_CONNECT_ACK      			(ICXL_DEVICE_CONNECT_ACK      			[l-START_OF_ICXL_HOST]),
		//.D2H_CREDIT_RETURN_PROTOCOL_ID  	(ICXL_D2H_CREDIT_RETURN_PROTOCOL_ID     [l-START_OF_ICXL_HOST]),
		//.H2D_CREDIT_RETURN_PROTOCOL_ID  	(ICXL_H2D_CREDIT_RETURN_PROTOCOL_ID     [l-START_OF_ICXL_HOST]),
		.D2H_REQ_CREDIT_RETURN_PROTOCOL_ID 	(ICXL_D2H_REQ_CREDIT_RETURN_PROTOCOL_ID [l-START_OF_ICXL_HOST]),
		.D2H_DATA_CREDIT_RETURN_PROTOCOL_ID (ICXL_D2H_DATA_CREDIT_RETURN_PROTOCOL_ID[l-START_OF_ICXL_HOST]),
		.D2H_RSP_CREDIT_RETURN_PROTOCOL_ID 	(ICXL_D2H_RSP_CREDIT_RETURN_PROTOCOL_ID [l-START_OF_ICXL_HOST]),
		.H2D_REQ_CREDIT_RETURN_PROTOCOL_ID  (ICXL_H2D_REQ_CREDIT_RETURN_PROTOCOL_ID [l-START_OF_ICXL_HOST]),
		.H2D_DATA_CREDIT_RETURN_PROTOCOL_ID (ICXL_H2D_DATA_CREDIT_RETURN_PROTOCOL_ID[l-START_OF_ICXL_HOST]),
		.H2D_RSP_CREDIT_RETURN_PROTOCOL_ID  (ICXL_H2D_RSP_CREDIT_RETURN_PROTOCOL_ID [l-START_OF_ICXL_HOST]),
		.D2H_REQ_CREDIT_RETURN_VALID    	(ICXL_D2H_REQ_CREDIT_RETURN_VALID      	[l-START_OF_ICXL_HOST]),
		.D2H_REQ_PROT_CHID_CREDIT_RETURN    (ICXL_D2H_REQ_PROT_CHID_CREDIT_RETURN   [l-START_OF_ICXL_HOST]),
		.D2H_REQ_PROT1_RTYPE      			(ICXL_D2H_REQ_PROT1_RTYPE      			[l-START_OF_ICXL_HOST]),
		.D2H_DATA_CREDIT_RETURN_VALID      	(ICXL_D2H_DATA_CREDIT_RETURN_VALID      [l-START_OF_ICXL_HOST]),
		.D2H_DATA_PROT_CHID_CREDIT_RETURN   (ICXL_D2H_DATA_PROT_CHID_CREDIT_RETURN  [l-START_OF_ICXL_HOST]),
		.D2H_DATA_PROT1_RTYPE      			(ICXL_D2H_DATA_PROT1_RTYPE      		[l-START_OF_ICXL_HOST]),
		.D2H_RSP_CREDIT_RETURN_VALID      	(ICXL_D2H_RSP_CREDIT_RETURN_VALID      	[l-START_OF_ICXL_HOST]),
		.H2D_REQ_CREDIT_RETURN_VALID      	(ICXL_H2D_REQ_CREDIT_RETURN_VALID      	[l-START_OF_ICXL_HOST]),
		.H2D_REQ_PROT_CHID_CREDIT_RETURN    (ICXL_H2D_REQ_PROT_CHID_CREDIT_RETURN   [l-START_OF_ICXL_HOST]),
		.H2D_REQ_PROT1_RTYPE      			(ICXL_H2D_REQ_PROT1_RTYPE      			[l-START_OF_ICXL_HOST]),
		.H2D_DATA_CREDIT_RETURN_VALID      	(ICXL_H2D_DATA_CREDIT_RETURN_VALID      [l-START_OF_ICXL_HOST]),
		.H2D_DATA_PROT_CHID_CREDIT_RETURN   (ICXL_H2D_DATA_PROT_CHID_CREDIT_RETURN  [l-START_OF_ICXL_HOST]),
		.H2D_DATA_PROT1_RTYPE      			(ICXL_H2D_DATA_PROT1_RTYPE      		[l-START_OF_ICXL_HOST]),
		.H2D_RSP_CREDIT_RETURN_VALID      	(ICXL_H2D_RSP_CREDIT_RETURN_VALID      	[l-START_OF_ICXL_HOST]),

        .H2D_DATA_CHUNKVALID         (ICXL_H2D_DATA_CHUNKVALID         [l-START_OF_ICXL_HOST]),
        .H2D_DATA_CQID               (ICXL_H2D_DATA_CQID               [l-START_OF_ICXL_HOST]),
        .H2D_DATA_DATA               (ICXL_H2D_DATA_DATA               [l-START_OF_ICXL_HOST]),
        .H2D_DATA_PROTOCOL           (ICXL_H2D_DATA_PROTOCOL                [l-START_OF_ICXL_HOST]),
        .H2D_DATA_GOERR              (ICXL_H2D_DATA_GOERR             [l-START_OF_ICXL_HOST]),
        .H2D_DATA_PARITY             (ICXL_H2D_DATA_PARITY             [l-START_OF_ICXL_HOST]),
        .H2D_DATA_POISON             (ICXL_H2D_DATA_POISON             [l-START_OF_ICXL_HOST]),
        .H2D_DATA_HALFLINEONLY       (ICXL_H2D_DATA_HALFLINEONLY              [l-START_OF_ICXL_HOST]),
        .H2D_DATA_VALID              (ICXL_H2D_DATA_VALID              [l-START_OF_ICXL_HOST]),
        .H2D_REQ_ADDRESS             (ICXL_H2D_REQ_ADDRESS             [l-START_OF_ICXL_HOST]),
        .H2D_REQ_PROTOCOL            (ICXL_H2D_REQ_PROTOCOL             [l-START_OF_ICXL_HOST]),
        .H2D_REQ_SAI             	 (ICXL_H2D_REQ_SAI             [l-START_OF_ICXL_HOST]),
        .H2D_REQ_LENGTH              (ICXL_H2D_REQ_LENGTH             [l-START_OF_ICXL_HOST]),
        .H2D_REQ_PCIE_HEADER         (ICXL_H2D_REQ_PCIE_HEADER             [l-START_OF_ICXL_HOST]),
        .H2D_REQ_CHID             	 (ICXL_H2D_REQ_CHID             [l-START_OF_ICXL_HOST]),
        .H2D_REQ_UQID                (ICXL_H2D_REQ_UQID                [l-START_OF_ICXL_HOST]),
        .H2D_REQ_ADDR_PARITY         (ICXL_H2D_REQ_ADDR_PARITY          [l-START_OF_ICXL_HOST]),
        .H2D_REQ_PARITY         	 (ICXL_H2D_REQ_PARITY          [l-START_OF_ICXL_HOST]),
        .H2D_REQ_OPCODE              (ICXL_H2D_REQ_OPCODE              [l-START_OF_ICXL_HOST]),
        .H2D_REQ_VALID               (ICXL_H2D_REQ_VALID               [l-START_OF_ICXL_HOST]),
        .H2D_RSP_CQID                (ICXL_H2D_RSP_CQID                [l-START_OF_ICXL_HOST]),
        .H2D_RSP_OPCODE              (ICXL_H2D_RSP_OPCODE              [l-START_OF_ICXL_HOST]),
        .H2D_RSP_RSP_PRE             (ICXL_H2D_RSP_RSP_PRE                 [l-START_OF_ICXL_HOST]),
        .H2D_RSP_RSPDATA             (ICXL_H2D_RSP_RSPDATA             [l-START_OF_ICXL_HOST]),
        .H2D_RSP_PROTOCOL            (ICXL_H2D_RSP_PROTOCOL               [l-START_OF_ICXL_HOST]),
        .H2D_RSP_VALID               (ICXL_H2D_RSP_VALID               [l-START_OF_ICXL_HOST]),
        .D2H_DATA_BOGUS              (ICXL_D2H_DATA_BOGUS              [l-START_OF_ICXL_HOST]),
        .D2H_DATA_BE		         (ICXL_D2H_DATA_BE		        [l-START_OF_ICXL_HOST]),
        .D2H_DATA_PROTOCOL			 (ICXL_D2H_DATA_PROTOCOL		 [l-START_OF_ICXL_HOST]),
        .D2H_DATA_CHUNKVALID         (ICXL_D2H_DATA_CHUNKVALID         [l-START_OF_ICXL_HOST]),
        .D2H_DATA_DATA               (ICXL_D2H_DATA_DATA               [l-START_OF_ICXL_HOST]),
        .D2H_DATA_CHID               (ICXL_D2H_DATA_CHID                [l-START_OF_ICXL_HOST]),
        .D2H_DATA_PARITY             (ICXL_D2H_DATA_PARITY             [l-START_OF_ICXL_HOST]),
        .D2H_DATA_POISON             (ICXL_D2H_DATA_POISON             [l-START_OF_ICXL_HOST]),
        .D2H_DATA_UQID               (ICXL_D2H_DATA_UQID               [l-START_OF_ICXL_HOST]),
        .D2H_DATA_VALID              (ICXL_D2H_DATA_VALID              [l-START_OF_ICXL_HOST]),
        .D2H_REQ_ADDRESS             (ICXL_D2H_REQ_ADDRESS             [l-START_OF_ICXL_HOST]),
        .D2H_REQ_ADDR_PARITY         (ICXL_D2H_REQ_ADDR_PARITY          [l-START_OF_ICXL_HOST]),
        .D2H_REQ_PARITY         	 (ICXL_D2H_REQ_PARITY          [l-START_OF_ICXL_HOST]),
        .D2H_REQ_PROTOCOL        	 (ICXL_D2H_REQ_PROTOCOL		        [l-START_OF_ICXL_HOST]),
        .D2H_REQ_CQID                (ICXL_D2H_REQ_CQID                [l-START_OF_ICXL_HOST]),
        .D2H_REQ_NT                  (ICXL_D2H_REQ_NT                  [l-START_OF_ICXL_HOST]),
        .D2H_REQ_PCIE_HEADER         (ICXL_D2H_REQ_PCIE_HEADER                [l-START_OF_ICXL_HOST]),
        .D2H_REQ_LENGTH              (ICXL_D2H_REQ_LENGTH              [l-START_OF_ICXL_HOST]),
        .D2H_REQ_CHID	             (ICXL_D2H_REQ_CHID              [l-START_OF_ICXL_HOST]),
        .D2H_REQ_OPCODE              (ICXL_D2H_REQ_OPCODE              [l-START_OF_ICXL_HOST]),
        .D2H_REQ_SAI                 (ICXL_D2H_REQ_SAI                 [l-START_OF_ICXL_HOST]),
        .D2H_REQ_VALID               (ICXL_D2H_REQ_VALID               [l-START_OF_ICXL_HOST]),
        .D2H_RSP_PROTOCOL            (ICXL_D2H_RSP_PROTOCOL            [l-START_OF_ICXL_HOST]),
        .D2H_RSP_OPCODE              (ICXL_D2H_RSP_OPCODE              [l-START_OF_ICXL_HOST]),
        .D2H_RSP_UQID                (ICXL_D2H_RSP_UQID                [l-START_OF_ICXL_HOST]),
        .D2H_RSP_VALID               (ICXL_D2H_RSP_VALID               [l-START_OF_ICXL_HOST]),
    
        //aximm interface with the client
        .aximm_awvalid    (client_aximm_awvalid[l]),
        .aximm_awready    (client_aximm_awready[l]),
        .aximm_awid       (client_aximm_awid[l]),
        .aximm_awaddr     (client_aximm_awaddr[l]),
        .aximm_awlen      (client_aximm_awlen[l]),
        .aximm_awsize     (client_aximm_awsize[l]),
        .aximm_awburst    (client_aximm_awburst[l]),
        .aximm_awlock     (client_aximm_awlock[l]),
        .aximm_awcache    (client_aximm_awcache[l]),
        .aximm_awqos      (client_aximm_awqos[l]),
                          
        .aximm_wvalid     (client_aximm_wvalid[l]),
        .aximm_wready     (client_aximm_wready[l]),
        .aximm_wlast      (client_aximm_wlast[l]),
        .aximm_wdata      (client_aximm_wdata[l]),
        .aximm_wstrb      (client_aximm_wstrb[l]),
           
        .aximm_bvalid     (client_aximm_bvalid[l]),
        .aximm_bready     (client_aximm_bready[l]),
        .aximm_bid        (client_aximm_bid[l]),
        .aximm_bresp      (client_aximm_bresp[l]),
           
        .aximm_arvalid    (client_aximm_arvalid[l]),
        .aximm_arready    (client_aximm_arready[l]),
        .aximm_arid       (client_aximm_arid[l]),
        .aximm_araddr     (client_aximm_araddr[l]),
        .aximm_arlen      (client_aximm_arlen[l]),
        .aximm_arsize     (client_aximm_arsize[l]),
        .aximm_arburst    (client_aximm_arburst[l]),
        .aximm_arlock     (client_aximm_arlock[l]),
        .aximm_arcache    (client_aximm_arcache[l]),
        .aximm_arqos      (client_aximm_arqos[l]),
        .aximm_rvalid     (client_aximm_rvalid[l]),
        .aximm_rready     (client_aximm_rready[l]),
        .aximm_rid        (client_aximm_rid[l]),
        .aximm_rdata      (client_aximm_rdata[l]),
        .aximm_rresp      (client_aximm_rresp[l]),
        .aximm_rlast      (client_aximm_rlast[l])  
       );   
       
       
		assign rd_rx_fifo  [l][14:4] = 'b0;
		assign wr_tx_fifo  [l][14:4] = 'b0;
		assign din_tx_fifo [l][14:4] = 'b0; 

		assign axi_rq_tdata_client[l]  = 'b0;
		assign axi_rq_tkeep_client[l]  = 'b0;
		assign axi_rq_tlast_client[l]  = 'b0;
		assign axi_rq_tuser_client[l]  = 'b0;
		assign axi_rq_tvalid_client[l] = 'b0;
		assign axi_rc_tready_client[l] = 'b0;  
     
		assign	direct_axis_rx_tready_comm_block_to_client[l]	= 'b0;
		assign	direct_axis_tx_tdata_client_to_comm_block[l]	= 'b0;
		assign	direct_axis_tx_tkeep_client_to_comm_block[l]	= 'b0;
		assign	direct_axis_tx_tlast_client_to_comm_block[l]	= 'b0;
		assign	direct_axis_tx_tvalid_client_to_comm_block[l]	= 'b0;
		assign	direct_axis_tx_tuser_client_to_comm_block[l]	= 'b0;

     
    end
  end // :ICXL HOST
  endgenerate


  assign ICXL_device_clk_0  = user_clk;
  assign ICXL_device_rstn_0 = ~generic_chassis_rst;

//generate instantiation for ICXL DEVICE
 // genvar m;
  generate if (NUM_OF_ICXL_DEVICE != 0) 
  begin: ICXL_DEVICE_0
  
   //for (m=START_OF_ICXL_DEVICE; m<START_OF_ICXL_DEVICE+NUM_OF_ICXL_DEVICE; m++)
   // begin
    
    assign client_clk[START_OF_ICXL_DEVICE] = ICXL_host_clk[0];
   
   ICXL_DEVICE_Transactor_top  # (
                            .TRANSACTOR_TYPE(ICXL_DEVICE_TYPE),
                            .TRANSACTOR_VERSION(ICXL_DEVICE_VERSION)
)
	ICXL_DEVICE_Transactor_top_inst
        (
        `ifdef FGC_CDC
         .generic_chassis_clk 	(fgc_clk),
        `else
         .generic_chassis_clk 	(user_clk),
       `endif	
        .generic_chassis_rst 		(generic_chassis_rst),
        
        .ICXL_clk  	     	 		(ICXL_host_clk[0]),
        .ICXL_rst_n     	 		(ICXL_host_rstn[0]),
        
        .dout_rx_fifo   			(dout_rx_fifo [START_OF_ICXL_DEVICE][3:0]), 
        .rd_rx_fifo     			(rd_rx_fifo   [START_OF_ICXL_DEVICE][3:0]), 
        .empty_rx_fifo  			(empty_rx_fifo[START_OF_ICXL_DEVICE][3:0]),

        .wr_tx_fifo     			(wr_tx_fifo   [START_OF_ICXL_DEVICE][3:0]),
        .din_tx_fifo    			(din_tx_fifo  [START_OF_ICXL_DEVICE][3:0]),
        .full_tx_fifo   			(full_tx_fifo [START_OF_ICXL_DEVICE][3:0]),

		.HOST_CONNECT_REQ      				(icxl_HOST_CONNECT_REQ_0      				),
		.HOST_CONNECT_ACK      				(icxl_HOST_CONNECT_ACK_0      				),
		.DEVICE_CONNECT_REQ      			(icxl_DEVICE_CONNECT_REQ_0     				),
		.DEVICE_CONNECT_ACK      			(icxl_DEVICE_CONNECT_ACK_0     				),
		//.D2H_CREDIT_RETURN_PROTOCOL_ID  	(icxl_D2H_CREDIT_RETURN_PROTOCOL_ID_0   	),
		//.H2D_CREDIT_RETURN_PROTOCOL_ID  	(icxl_H2D_CREDIT_RETURN_PROTOCOL_ID_0   	),
		.D2H_REQ_CREDIT_RETURN_PROTOCOL_ID  (icxl_D2H_REQ_CREDIT_RETURN_PROTOCOL_ID_0  	),
		.D2H_DATA_CREDIT_RETURN_PROTOCOL_ID (icxl_D2H_DATA_CREDIT_RETURN_PROTOCOL_ID_0 	),
		.D2H_RSP_CREDIT_RETURN_PROTOCOL_ID  (icxl_D2H_RSP_CREDIT_RETURN_PROTOCOL_ID_0  	),
		.H2D_REQ_CREDIT_RETURN_PROTOCOL_ID  (icxl_H2D_REQ_CREDIT_RETURN_PROTOCOL_ID_0  	),
		.H2D_DATA_CREDIT_RETURN_PROTOCOL_ID (icxl_H2D_DATA_CREDIT_RETURN_PROTOCOL_ID_0 	),
		.H2D_RSP_CREDIT_RETURN_PROTOCOL_ID  (icxl_H2D_RSP_CREDIT_RETURN_PROTOCOL_ID_0  	),
		.D2H_REQ_CREDIT_RETURN_VALID    	(icxl_D2H_REQ_CREDIT_RETURN_VALID_0    		),
		.D2H_REQ_PROT_CHID_CREDIT_RETURN    (icxl_D2H_REQ_PROT_CHID_CREDIT_RETURN_0 	),
		.D2H_REQ_PROT1_RTYPE      			(icxl_D2H_REQ_PROT1_RTYPE_0    				),
		.D2H_DATA_CREDIT_RETURN_VALID      	(icxl_D2H_DATA_CREDIT_RETURN_VALID_0    	),
		.D2H_DATA_PROT_CHID_CREDIT_RETURN   (icxl_D2H_DATA_PROT_CHID_CREDIT_RETURN_0	),
		.D2H_DATA_PROT1_RTYPE      			(icxl_D2H_DATA_PROT1_RTYPE_0      			),
		.D2H_RSP_CREDIT_RETURN_VALID      	(icxl_D2H_RSP_CREDIT_RETURN_VALID_0    		),
		.H2D_REQ_CREDIT_RETURN_VALID      	(icxl_H2D_REQ_CREDIT_RETURN_VALID_0    		),
		.H2D_REQ_PROT_CHID_CREDIT_RETURN    (icxl_H2D_REQ_PROT_CHID_CREDIT_RETURN_0 	),
		.H2D_REQ_PROT1_RTYPE      			(icxl_H2D_REQ_PROT1_RTYPE_0    				),
		.H2D_DATA_CREDIT_RETURN_VALID      	(icxl_H2D_DATA_CREDIT_RETURN_VALID_0    	),
		.H2D_DATA_PROT_CHID_CREDIT_RETURN   (icxl_H2D_DATA_PROT_CHID_CREDIT_RETURN_0	),
		.H2D_DATA_PROT1_RTYPE      			(icxl_H2D_DATA_PROT1_RTYPE_0     			),
		.H2D_RSP_CREDIT_RETURN_VALID      	(icxl_H2D_RSP_CREDIT_RETURN_VALID_0    		),

        .H2D_DATA_CHUNKVALID         		(icxl_H2D_DATA_CHUNKVALID_0         		),
        .H2D_DATA_CQID               		(icxl_H2D_DATA_CQID_0               		),
        .H2D_DATA_DATA               		(icxl_H2D_DATA_DATA_0               		),
        .H2D_DATA_PROTOCOL           		(icxl_H2D_DATA_PROTOCOL_0                	),
        .H2D_DATA_GOERR              		(icxl_H2D_DATA_GOERR_0             			),
        .H2D_DATA_PARITY             		(icxl_H2D_DATA_PARITY_0             		),
        .H2D_DATA_POISON             		(icxl_H2D_DATA_POISON_0             		),
        .H2D_DATA_HALFLINEONLY       		(icxl_H2D_DATA_HALFLINEONLY_0              	),
        .H2D_DATA_VALID              		(icxl_H2D_DATA_VALID_0              		),
        .H2D_REQ_ADDRESS             		(icxl_H2D_REQ_ADDRESS_0             		),
        .H2D_REQ_PROTOCOL            		(icxl_H2D_REQ_PROTOCOL_0            	 	),
        .H2D_REQ_SAI             		 	(icxl_H2D_REQ_SAI_0             			),
        .H2D_REQ_LENGTH             		(icxl_H2D_REQ_LENGTH_0             			),
        .H2D_REQ_PCIE_HEADER        	 	(icxl_H2D_REQ_PCIE_HEADER_0             	),
        .H2D_REQ_CHID             			(icxl_H2D_REQ_CHID_0             			),
        .H2D_REQ_UQID               		(icxl_H2D_REQ_UQID_0                		),
        .H2D_REQ_ADDR_PARITY        		(icxl_H2D_REQ_ADDR_PARITY_0          		),
        .H2D_REQ_PARITY         	 		(icxl_H2D_REQ_PARITY_0          			),
        .H2D_REQ_OPCODE              		(icxl_H2D_REQ_OPCODE_0              		),
        .H2D_REQ_VALID               		(icxl_H2D_REQ_VALID_0               		),
        .H2D_RSP_CQID                		(icxl_H2D_RSP_CQID_0                		),
        .H2D_RSP_OPCODE              		(icxl_H2D_RSP_OPCODE_0              		),
        .H2D_RSP_RSP_PRE             		(icxl_H2D_RSP_RSP_PRE_0                 	),
        .H2D_RSP_RSPDATA             		(icxl_H2D_RSP_RSPDATA_0             		),
        .H2D_RSP_PROTOCOL            		(icxl_H2D_RSP_PROTOCOL_0               		),
        .H2D_RSP_VALID               		(icxl_H2D_RSP_VALID_0               		),
        .D2H_DATA_BOGUS              		(icxl_D2H_DATA_BOGUS_0              		),
        .D2H_DATA_BE		         		(icxl_D2H_DATA_BE_0		        			),
        .D2H_DATA_PROTOCOL			 		(icxl_D2H_DATA_PROTOCOL_0		 			),
        .D2H_DATA_CHUNKVALID         		(icxl_D2H_DATA_CHUNKVALID_0         		),
        .D2H_DATA_DATA               		(icxl_D2H_DATA_DATA_0               		),
        .D2H_DATA_CHID               		(icxl_D2H_DATA_CHID_0                		),
        .D2H_DATA_PARITY             		(icxl_D2H_DATA_PARITY_0             		),
        .D2H_DATA_POISON             		(icxl_D2H_DATA_POISON_0             		),
        .D2H_DATA_UQID               		(icxl_D2H_DATA_UQID_0               		),
        .D2H_DATA_VALID              		(icxl_D2H_DATA_VALID_0              		),
        .D2H_REQ_ADDRESS             		(icxl_D2H_REQ_ADDRESS_0             		),
        .D2H_REQ_ADDR_PARITY         		(icxl_D2H_REQ_ADDR_PARITY_0          		),
        .D2H_REQ_PARITY         	 		(icxl_D2H_REQ_PARITY_0          			),
        .D2H_REQ_PROTOCOL        	 		(icxl_D2H_REQ_PROTOCOL_0		        	),
        .D2H_REQ_CQID                		(icxl_D2H_REQ_CQID_0                		),
        .D2H_REQ_NT                  		(icxl_D2H_REQ_NT_0                  		),
        .D2H_REQ_PCIE_HEADER         		(icxl_D2H_REQ_PCIE_HEADER_0                	),
        .D2H_REQ_LENGTH              		(icxl_D2H_REQ_LENGTH_0              		),
        .D2H_REQ_CHID	             		(icxl_D2H_REQ_CHID_0              			),
        .D2H_REQ_OPCODE              		(icxl_D2H_REQ_OPCODE_0              		),
        .D2H_REQ_SAI                 		(icxl_D2H_REQ_SAI_0                 		),
        .D2H_REQ_VALID               		(icxl_D2H_REQ_VALID_0               		),
        .D2H_RSP_PROTOCOL            		(icxl_D2H_RSP_PROTOCOL_0            		),
        .D2H_RSP_OPCODE              		(icxl_D2H_RSP_OPCODE_0              		),
        .D2H_RSP_UQID                		(icxl_D2H_RSP_UQID_0                		),
        .D2H_RSP_VALID               		(icxl_D2H_RSP_VALID_0               		),
    
        //aximm interface with the client
        .aximm_awvalid    (client_aximm_awvalid[START_OF_ICXL_DEVICE]),
        .aximm_awready    (client_aximm_awready[START_OF_ICXL_DEVICE]),
        .aximm_awid       (client_aximm_awid[START_OF_ICXL_DEVICE]),
        .aximm_awaddr     (client_aximm_awaddr[START_OF_ICXL_DEVICE]),
        .aximm_awlen      (client_aximm_awlen[START_OF_ICXL_DEVICE]),
        .aximm_awsize     (client_aximm_awsize[START_OF_ICXL_DEVICE]),
        .aximm_awburst    (client_aximm_awburst[START_OF_ICXL_DEVICE]),
        .aximm_awlock     (client_aximm_awlock[START_OF_ICXL_DEVICE]),
        .aximm_awcache    (client_aximm_awcache[START_OF_ICXL_DEVICE]),
        .aximm_awqos      (client_aximm_awqos[START_OF_ICXL_DEVICE]),
                          
        .aximm_wvalid     (client_aximm_wvalid[START_OF_ICXL_DEVICE]),
        .aximm_wready     (client_aximm_wready[START_OF_ICXL_DEVICE]),
        .aximm_wlast      (client_aximm_wlast[START_OF_ICXL_DEVICE]),
        .aximm_wdata      (client_aximm_wdata[START_OF_ICXL_DEVICE]),
        .aximm_wstrb      (client_aximm_wstrb[START_OF_ICXL_DEVICE]),
           
        .aximm_bvalid     (client_aximm_bvalid[START_OF_ICXL_DEVICE]),
        .aximm_bready     (client_aximm_bready[START_OF_ICXL_DEVICE]),
        .aximm_bid        (client_aximm_bid[START_OF_ICXL_DEVICE]),
        .aximm_bresp      (client_aximm_bresp[START_OF_ICXL_DEVICE]),
           
        .aximm_arvalid    (client_aximm_arvalid[START_OF_ICXL_DEVICE]),
        .aximm_arready    (client_aximm_arready[START_OF_ICXL_DEVICE]),
        .aximm_arid       (client_aximm_arid[START_OF_ICXL_DEVICE]),
        .aximm_araddr     (client_aximm_araddr[START_OF_ICXL_DEVICE]),
        .aximm_arlen      (client_aximm_arlen[START_OF_ICXL_DEVICE]),
        .aximm_arsize     (client_aximm_arsize[START_OF_ICXL_DEVICE]),
        .aximm_arburst    (client_aximm_arburst[START_OF_ICXL_DEVICE]),
        .aximm_arlock     (client_aximm_arlock[START_OF_ICXL_DEVICE]),
        .aximm_arcache    (client_aximm_arcache[START_OF_ICXL_DEVICE]),
        .aximm_arqos      (client_aximm_arqos[START_OF_ICXL_DEVICE]),
        .aximm_rvalid     (client_aximm_rvalid[START_OF_ICXL_DEVICE]),
        .aximm_rready    (client_aximm_rready[START_OF_ICXL_DEVICE]),
        .aximm_rid        (client_aximm_rid[START_OF_ICXL_DEVICE]),
        .aximm_rdata      (client_aximm_rdata[START_OF_ICXL_DEVICE]),
        .aximm_rresp      (client_aximm_rresp[START_OF_ICXL_DEVICE]),
        .aximm_rlast      (client_aximm_rlast[START_OF_ICXL_DEVICE])  
       );    
             
    assign rd_rx_fifo  [START_OF_ICXL_DEVICE][14:4] = 'b0;
    assign wr_tx_fifo  [START_OF_ICXL_DEVICE][14:4] = 'b0;
    assign din_tx_fifo [START_OF_ICXL_DEVICE][14:4] = 'b0;

    assign axi_rq_tdata_client[START_OF_ICXL_DEVICE]  = 'b0;
    assign axi_rq_tkeep_client[START_OF_ICXL_DEVICE]  = 'b0;
    assign axi_rq_tlast_client[START_OF_ICXL_DEVICE]  = 'b0;
    assign axi_rq_tuser_client[START_OF_ICXL_DEVICE]  = 'b0;
    assign axi_rq_tvalid_client[START_OF_ICXL_DEVICE] = 'b0;
    assign axi_rc_tready_client[START_OF_ICXL_DEVICE] = 'b0;
    
    assign	direct_axis_rx_tready_comm_block_to_client[START_OF_ICXL_DEVICE]	= 'b0;
	assign	direct_axis_tx_tdata_client_to_comm_block[START_OF_ICXL_DEVICE]	= 'b0;
	assign	direct_axis_tx_tkeep_client_to_comm_block[START_OF_ICXL_DEVICE]	= 'b0;
	assign	direct_axis_tx_tlast_client_to_comm_block[START_OF_ICXL_DEVICE]	= 'b0;
	assign	direct_axis_tx_tvalid_client_to_comm_block[START_OF_ICXL_DEVICE]	= 'b0;
	assign	direct_axis_tx_tuser_client_to_comm_block[START_OF_ICXL_DEVICE]	= 'b0;
                      
   // end
  end // :ICXL DEVICE
  endgenerate
  
   assign ICXL_device_clk_1  = user_clk;
  assign ICXL_device_rstn_1 = ~generic_chassis_rst;

//generate instantiation for ICXL DEVICE
 // genvar n;
  generate if (NUM_OF_ICXL_DEVICE > 1) 
  begin: ICXL_DEVICE_1
  
   //for (m=START_OF_ICXL_DEVICE; m<START_OF_ICXL_DEVICE+NUM_OF_ICXL_DEVICE; m++)
   // begin
    
    assign client_clk[START_OF_ICXL_DEVICE+1] = ICXL_host_clk[0];
   
   ICXL_DEVICE_Transactor_top  # (
                            .TRANSACTOR_TYPE(ICXL_DEVICE_TYPE),
                            .TRANSACTOR_VERSION(ICXL_DEVICE_VERSION)
)
	ICXL_DEVICE_Transactor_top_inst
        (
        `ifdef FGC_CDC
         .generic_chassis_clk 	(fgc_clk),
        `else
         .generic_chassis_clk 	(user_clk),
       `endif	
        .generic_chassis_rst 		(generic_chassis_rst),
        
        .ICXL_clk  	     	 		(ICXL_host_clk[0]),
        .ICXL_rst_n     	 		(ICXL_host_rstn[0]),
        
        .dout_rx_fifo   			(dout_rx_fifo [START_OF_ICXL_DEVICE+1][3:0]), 
        .rd_rx_fifo     			(rd_rx_fifo   [START_OF_ICXL_DEVICE+1][3:0]), 
        .empty_rx_fifo  			(empty_rx_fifo[START_OF_ICXL_DEVICE+1][3:0]),

        .wr_tx_fifo     			(wr_tx_fifo   [START_OF_ICXL_DEVICE+1][3:0]),
        .din_tx_fifo    			(din_tx_fifo  [START_OF_ICXL_DEVICE+1][3:0]),
        .full_tx_fifo   			(full_tx_fifo [START_OF_ICXL_DEVICE+1][3:0]),

		.HOST_CONNECT_REQ      				(icxl_HOST_CONNECT_REQ_1      				),
		.HOST_CONNECT_ACK      				(icxl_HOST_CONNECT_ACK_1      				),
		.DEVICE_CONNECT_REQ      			(icxl_DEVICE_CONNECT_REQ_1     				),
		.DEVICE_CONNECT_ACK      			(icxl_DEVICE_CONNECT_ACK_1     				),
		//.D2H_CREDIT_RETURN_PROTOCOL_ID  	(icxl_D2H_CREDIT_RETURN_PROTOCOL_ID_1   	),
		.D2H_REQ_CREDIT_RETURN_PROTOCOL_ID  	(icxl_D2H_REQ_CREDIT_RETURN_PROTOCOL_ID_1   	),
		.D2H_DATA_CREDIT_RETURN_PROTOCOL_ID  	(icxl_D2H_DATA_CREDIT_RETURN_PROTOCOL_ID_1   	),
		.D2H_RSP_CREDIT_RETURN_PROTOCOL_ID  	(icxl_D2H_RSP_CREDIT_RETURN_PROTOCOL_ID_1   	),		
		//.H2D_CREDIT_RETURN_PROTOCOL_ID  	(icxl_H2D_CREDIT_RETURN_PROTOCOL_ID_1   	),
		.H2D_REQ_CREDIT_RETURN_PROTOCOL_ID  	(icxl_H2D_REQ_CREDIT_RETURN_PROTOCOL_ID_1   	),
		.H2D_DATA_CREDIT_RETURN_PROTOCOL_ID  	(icxl_H2D_DATA_CREDIT_RETURN_PROTOCOL_ID_1   	),
		.H2D_RSP_CREDIT_RETURN_PROTOCOL_ID  	(icxl_H2D_RSP_CREDIT_RETURN_PROTOCOL_ID_1   	),
		.D2H_REQ_CREDIT_RETURN_VALID    	(icxl_D2H_REQ_CREDIT_RETURN_VALID_1    		),
		.D2H_REQ_PROT_CHID_CREDIT_RETURN    (icxl_D2H_REQ_PROT_CHID_CREDIT_RETURN_1 	),
		.D2H_REQ_PROT1_RTYPE      			(icxl_D2H_REQ_PROT1_RTYPE_1    				),
		.D2H_DATA_CREDIT_RETURN_VALID      	(icxl_D2H_DATA_CREDIT_RETURN_VALID_1    	),
		.D2H_DATA_PROT_CHID_CREDIT_RETURN   (icxl_D2H_DATA_PROT_CHID_CREDIT_RETURN_1	),
		.D2H_DATA_PROT1_RTYPE      			(icxl_D2H_DATA_PROT1_RTYPE_1      			),
		.D2H_RSP_CREDIT_RETURN_VALID      	(icxl_D2H_RSP_CREDIT_RETURN_VALID_1    		),
		.H2D_REQ_CREDIT_RETURN_VALID      	(icxl_H2D_REQ_CREDIT_RETURN_VALID_1    		),
		.H2D_REQ_PROT_CHID_CREDIT_RETURN    (icxl_H2D_REQ_PROT_CHID_CREDIT_RETURN_1 	),
		.H2D_REQ_PROT1_RTYPE      			(icxl_H2D_REQ_PROT1_RTYPE_1    				),
		.H2D_DATA_CREDIT_RETURN_VALID      	(icxl_H2D_DATA_CREDIT_RETURN_VALID_1    	),
		.H2D_DATA_PROT_CHID_CREDIT_RETURN   (icxl_H2D_DATA_PROT_CHID_CREDIT_RETURN_1	),
		.H2D_DATA_PROT1_RTYPE      			(icxl_H2D_DATA_PROT1_RTYPE_1     			),
		.H2D_RSP_CREDIT_RETURN_VALID      	(icxl_H2D_RSP_CREDIT_RETURN_VALID_1    		),

        .H2D_DATA_CHUNKVALID         		(icxl_H2D_DATA_CHUNKVALID_1         		),
        .H2D_DATA_CQID               		(icxl_H2D_DATA_CQID_1               		),
        .H2D_DATA_DATA               		(icxl_H2D_DATA_DATA_1               		),
        .H2D_DATA_PROTOCOL           		(icxl_H2D_DATA_PROTOCOL_1                	),
        .H2D_DATA_GOERR              		(icxl_H2D_DATA_GOERR_1             			),
        .H2D_DATA_PARITY             		(icxl_H2D_DATA_PARITY_1             		),
        .H2D_DATA_POISON             		(icxl_H2D_DATA_POISON_1             		),
        .H2D_DATA_HALFLINEONLY       		(icxl_H2D_DATA_HALFLINEONLY_1              	),
        .H2D_DATA_VALID              		(icxl_H2D_DATA_VALID_1              		),
        .H2D_REQ_ADDRESS             		(icxl_H2D_REQ_ADDRESS_1             		),
        .H2D_REQ_PROTOCOL            		(icxl_H2D_REQ_PROTOCOL_1            	 	),
        .H2D_REQ_SAI             		 	(icxl_H2D_REQ_SAI_1             			),
        .H2D_REQ_LENGTH             		(icxl_H2D_REQ_LENGTH_1             			),
        .H2D_REQ_PCIE_HEADER        	 	(icxl_H2D_REQ_PCIE_HEADER_1             	),
        .H2D_REQ_CHID             			(icxl_H2D_REQ_CHID_1             			),
        .H2D_REQ_UQID               		(icxl_H2D_REQ_UQID_1                		),
        .H2D_REQ_ADDR_PARITY        		(icxl_H2D_REQ_ADDR_PARITY_1          		),
        .H2D_REQ_PARITY         	 		(icxl_H2D_REQ_PARITY_1          			),
        .H2D_REQ_OPCODE              		(icxl_H2D_REQ_OPCODE_1              		),
        .H2D_REQ_VALID               		(icxl_H2D_REQ_VALID_1               		),
        .H2D_RSP_CQID                		(icxl_H2D_RSP_CQID_1                		),
        .H2D_RSP_OPCODE              		(icxl_H2D_RSP_OPCODE_1              		),
        .H2D_RSP_RSP_PRE             		(icxl_H2D_RSP_RSP_PRE_1                 	),
        .H2D_RSP_RSPDATA             		(icxl_H2D_RSP_RSPDATA_1             		),
        .H2D_RSP_PROTOCOL            		(icxl_H2D_RSP_PROTOCOL_1               		),
        .H2D_RSP_VALID               		(icxl_H2D_RSP_VALID_1               		),
        .D2H_DATA_BOGUS              		(icxl_D2H_DATA_BOGUS_1              		),
        .D2H_DATA_BE		         		(icxl_D2H_DATA_BE_1		        			),
        .D2H_DATA_PROTOCOL			 		(icxl_D2H_DATA_PROTOCOL_1		 			),
        .D2H_DATA_CHUNKVALID         		(icxl_D2H_DATA_CHUNKVALID_1         		),
        .D2H_DATA_DATA               		(icxl_D2H_DATA_DATA_1               		),
        .D2H_DATA_CHID               		(icxl_D2H_DATA_CHID_1                		),
        .D2H_DATA_PARITY             		(icxl_D2H_DATA_PARITY_1             		),
        .D2H_DATA_POISON             		(icxl_D2H_DATA_POISON_1             		),
        .D2H_DATA_UQID               		(icxl_D2H_DATA_UQID_1               		),
        .D2H_DATA_VALID              		(icxl_D2H_DATA_VALID_1              		),
        .D2H_REQ_ADDRESS             		(icxl_D2H_REQ_ADDRESS_1             		),
        .D2H_REQ_ADDR_PARITY         		(icxl_D2H_REQ_ADDR_PARITY_1          		),
        .D2H_REQ_PARITY         	 		(icxl_D2H_REQ_PARITY_1          			),
        .D2H_REQ_PROTOCOL        	 		(icxl_D2H_REQ_PROTOCOL_1		        	),
        .D2H_REQ_CQID                		(icxl_D2H_REQ_CQID_1                		),
        .D2H_REQ_NT                  		(icxl_D2H_REQ_NT_1                  		),
        .D2H_REQ_PCIE_HEADER         		(icxl_D2H_REQ_PCIE_HEADER_1                	),
        .D2H_REQ_LENGTH              		(icxl_D2H_REQ_LENGTH_1              		),
        .D2H_REQ_CHID	             		(icxl_D2H_REQ_CHID_1              			),
        .D2H_REQ_OPCODE              		(icxl_D2H_REQ_OPCODE_1              		),
        .D2H_REQ_SAI                 		(icxl_D2H_REQ_SAI_1                 		),
        .D2H_REQ_VALID               		(icxl_D2H_REQ_VALID_1               		),
        .D2H_RSP_PROTOCOL            		(icxl_D2H_RSP_PROTOCOL_1            		),
        .D2H_RSP_OPCODE              		(icxl_D2H_RSP_OPCODE_1              		),
        .D2H_RSP_UQID                		(icxl_D2H_RSP_UQID_1                		),
        .D2H_RSP_VALID               		(icxl_D2H_RSP_VALID_1               		),
    
        //aximm interface with the client
        .aximm_awvalid    (client_aximm_awvalid[START_OF_ICXL_DEVICE+1]),
        .aximm_awready    (client_aximm_awready[START_OF_ICXL_DEVICE+1]),
        .aximm_awid       (client_aximm_awid[START_OF_ICXL_DEVICE+1]),
        .aximm_awaddr     (client_aximm_awaddr[START_OF_ICXL_DEVICE+1]),
        .aximm_awlen      (client_aximm_awlen[START_OF_ICXL_DEVICE+1]),
        .aximm_awsize     (client_aximm_awsize[START_OF_ICXL_DEVICE+1]),
        .aximm_awburst    (client_aximm_awburst[START_OF_ICXL_DEVICE+1]),
        .aximm_awlock     (client_aximm_awlock[START_OF_ICXL_DEVICE+1]),
        .aximm_awcache    (client_aximm_awcache[START_OF_ICXL_DEVICE+1]),
        .aximm_awqos      (client_aximm_awqos[START_OF_ICXL_DEVICE+1]),
                          
        .aximm_wvalid     (client_aximm_wvalid[START_OF_ICXL_DEVICE+1]),
        .aximm_wready     (client_aximm_wready[START_OF_ICXL_DEVICE+1]),
        .aximm_wlast      (client_aximm_wlast[START_OF_ICXL_DEVICE+1]),
        .aximm_wdata      (client_aximm_wdata[START_OF_ICXL_DEVICE+1]),
        .aximm_wstrb      (client_aximm_wstrb[START_OF_ICXL_DEVICE+1]),
           
        .aximm_bvalid     (client_aximm_bvalid[START_OF_ICXL_DEVICE+1]),
        .aximm_bready     (client_aximm_bready[START_OF_ICXL_DEVICE+1]),
        .aximm_bid        (client_aximm_bid[START_OF_ICXL_DEVICE+1]),
        .aximm_bresp      (client_aximm_bresp[START_OF_ICXL_DEVICE+1]),
           
        .aximm_arvalid    (client_aximm_arvalid[START_OF_ICXL_DEVICE+1]),
        .aximm_arready    (client_aximm_arready[START_OF_ICXL_DEVICE+1]),
        .aximm_arid       (client_aximm_arid[START_OF_ICXL_DEVICE+1]),
        .aximm_araddr     (client_aximm_araddr[START_OF_ICXL_DEVICE+1]),
        .aximm_arlen      (client_aximm_arlen[START_OF_ICXL_DEVICE+1]),
        .aximm_arsize     (client_aximm_arsize[START_OF_ICXL_DEVICE+1]),
        .aximm_arburst    (client_aximm_arburst[START_OF_ICXL_DEVICE+1]),
        .aximm_arlock     (client_aximm_arlock[START_OF_ICXL_DEVICE+1]),
        .aximm_arcache    (client_aximm_arcache[START_OF_ICXL_DEVICE+1]),
        .aximm_arqos      (client_aximm_arqos[START_OF_ICXL_DEVICE+1]),
        .aximm_rvalid     (client_aximm_rvalid[START_OF_ICXL_DEVICE+1]),
        .aximm_rready    (client_aximm_rready[START_OF_ICXL_DEVICE+1]),
        .aximm_rid        (client_aximm_rid[START_OF_ICXL_DEVICE+1]),
        .aximm_rdata      (client_aximm_rdata[START_OF_ICXL_DEVICE+1]),
        .aximm_rresp      (client_aximm_rresp[START_OF_ICXL_DEVICE+1]),
        .aximm_rlast      (client_aximm_rlast[START_OF_ICXL_DEVICE+1])  
       );    
             
    assign rd_rx_fifo  [START_OF_ICXL_DEVICE+1][14:4] = 'b0;
    assign wr_tx_fifo  [START_OF_ICXL_DEVICE+1][14:4] = 'b0;
    assign din_tx_fifo [START_OF_ICXL_DEVICE+1][14:4] = 'b0;

    assign axi_rq_tdata_client[START_OF_ICXL_DEVICE+1]  = 'b0;
    assign axi_rq_tkeep_client[START_OF_ICXL_DEVICE+1]  = 'b0;
    assign axi_rq_tlast_client[START_OF_ICXL_DEVICE+1]  = 'b0;
    assign axi_rq_tuser_client[START_OF_ICXL_DEVICE+1]  = 'b0;
    assign axi_rq_tvalid_client[START_OF_ICXL_DEVICE+1] = 'b0;
    assign axi_rc_tready_client[START_OF_ICXL_DEVICE+1] = 'b0;
    
    assign	direct_axis_rx_tready_comm_block_to_client[START_OF_ICXL_DEVICE+1]	= 'b0;
	assign	direct_axis_tx_tdata_client_to_comm_block[START_OF_ICXL_DEVICE+1]	= 'b0;
	assign	direct_axis_tx_tkeep_client_to_comm_block[START_OF_ICXL_DEVICE+1]	= 'b0;
	assign	direct_axis_tx_tlast_client_to_comm_block[START_OF_ICXL_DEVICE+1]	= 'b0;
	assign	direct_axis_tx_tvalid_client_to_comm_block[START_OF_ICXL_DEVICE+1]	= 'b0;
	assign	direct_axis_tx_tuser_client_to_comm_block[START_OF_ICXL_DEVICE+1]	= 'b0;
                      
   // end
  end // :ICXL DEVICE
  endgenerate
  
  
  
  
//rgoura

`include "SB_wires.sv"

   
  assign sb_agent_clock   = user_clk;
  assign reset_sb_agent_n = ~generic_chassis_rst;
    
   
//generate instantiation for SB AGENT TRANSACTOR
  genvar n;
  generate if (NUM_OF_SB_AGENT_TRANSACTOR != 0) 
  begin: SB_AGENT_TRANSACTOR
  
   for (n=START_OF_SB_AGENT_TRANSACTOR; n<START_OF_SB_AGENT_TRANSACTOR+NUM_OF_SB_AGENT_TRANSACTOR; n++)
    begin
    
    assign client_clk[n] = sb_agent_clk[n-START_OF_SB_AGENT_TRANSACTOR];
   
   
   SB_Transactor_top  # (
                            .MAXPLDBIT				(SB_AGENT_MAXPLDBIT[n-START_OF_SB_AGENT_TRANSACTOR]),
                            .SB_TRANSACTOR_IS_AGENT (1),
                            .TRANSACTOR_TYPE		(SB_AGENT_TYPE),
                            .SUPPORT_HSB_AND_SSB    (SB_AGENT_SUPPORT_HSB_AND_SSB[n-START_OF_SB_AGENT_TRANSACTOR]),
                            .TRANSACTOR_VERSION (SB_AGENT_TRANSACTOR_VERSION)
)
	SB_AGENT_Transactor_top_inst 
(
        `ifdef FGC_CDC
         .generic_chassis_clk 	(fgc_clk),
        `else
         .generic_chassis_clk 	(user_clk),
       `endif	
        .generic_chassis_rst 		(generic_chassis_rst),
        
        //.ICXL_clk  	     	 		(ICXL_host_clk[0]),
        //.ICXL_rst_n     	 		(ICXL_host_rstn[0]),
        .clk_sb (sb_agent_clk[n-START_OF_SB_AGENT_TRANSACTOR] ),
       // .rst_local_n (rst_local_n[n]),
        .rst_sb_n (rst_sb_agent_n[n-START_OF_SB_AGENT_TRANSACTOR]),
        .gt_sb_en (),
        .dout_rx_fifo   			(dout_rx_fifo [n][0]), 
        .rd_rx_fifo     			(rd_rx_fifo   [n][0]), 
        .empty_rx_fifo  			(empty_rx_fifo[n][0]),

        .wr_tx_fifo     			(wr_tx_fifo   [n][0]),
        .din_tx_fifo    			(din_tx_fifo  [n][0]),
        .full_tx_fifo   			(full_tx_fifo [n][0]),
        .mpccup                                  (mpccup [n-START_OF_SB_AGENT_TRANSACTOR]), 
        .mnpcup                                  (mnpcup [n-START_OF_SB_AGENT_TRANSACTOR]), 
        .mpcput                                  (mpcput [n-START_OF_SB_AGENT_TRANSACTOR]),
        .mnpput                                  (mnpput [n-START_OF_SB_AGENT_TRANSACTOR]),
        .meom                                    (meom  [n-START_OF_SB_AGENT_TRANSACTOR]),
        .mpayload                                (mpayload [n-START_OF_SB_AGENT_TRANSACTOR][(SB_AGENT_MAXPLDBIT[n-START_OF_SB_AGENT_TRANSACTOR]):0]),

        .tpccup                                  (tpccup [n-START_OF_SB_AGENT_TRANSACTOR]),
        .tnpcup                                  (tnpcup [n-START_OF_SB_AGENT_TRANSACTOR]),
        .tnpput                                  (tnpput [n-START_OF_SB_AGENT_TRANSACTOR]),
        .tpcput                                  (tpcput [n-START_OF_SB_AGENT_TRANSACTOR]),
        .teom                                    (teom [n-START_OF_SB_AGENT_TRANSACTOR]),
        .tpayload                                (tpayload [n-START_OF_SB_AGENT_TRANSACTOR][(SB_AGENT_MAXPLDBIT[n-START_OF_SB_AGENT_TRANSACTOR]):0]),

        .side_ism_fabric                         (side_ism_fabric [n-START_OF_SB_AGENT_TRANSACTOR]),
        .side_ism_agent                          (side_ism_agent [n-START_OF_SB_AGENT_TRANSACTOR]),
        .side_clkreq                             (side_clkreq [n-START_OF_SB_AGENT_TRANSACTOR]),
        .side_clkack                             (side_clkack [n-START_OF_SB_AGENT_TRANSACTOR]),
        .sb_mailbox_out_interrupt                (),//sb_mailbox_out_interrupt [n-START_OF_SB_TRANSACTOR]),
        
        //aximm interface with the client
        .aximm_awvalid    (client_aximm_awvalid[n]),
        .aximm_awready    (client_aximm_awready[n]),
        .aximm_awid       (client_aximm_awid[n]),
        .aximm_awaddr     (client_aximm_awaddr[n]),
        .aximm_awlen      (client_aximm_awlen[n]),
        .aximm_awsize     (client_aximm_awsize[n]),
        .aximm_awburst    (client_aximm_awburst[n]),
        .aximm_awlock     (client_aximm_awlock[n]),
        .aximm_awcache    (client_aximm_awcache[n]),
        .aximm_awqos      (client_aximm_awqos[n]),
                          
        .aximm_wvalid     (client_aximm_wvalid[n]),
        .aximm_wready     (client_aximm_wready[n]),
        .aximm_wlast      (client_aximm_wlast[n]),
        .aximm_wdata      (client_aximm_wdata[n]),
        .aximm_wstrb      (client_aximm_wstrb[n]),
           
        .aximm_bvalid     (client_aximm_bvalid[n]),
        .aximm_bready     (client_aximm_bready[n]),
        .aximm_bid        (client_aximm_bid[n]),
        .aximm_bresp      (client_aximm_bresp[n]),
           
        .aximm_arvalid    (client_aximm_arvalid[n]),
        .aximm_arready    (client_aximm_arready[n]),
        .aximm_arid       (client_aximm_arid[n]),
        .aximm_araddr     (client_aximm_araddr[n]),
        .aximm_arlen      (client_aximm_arlen[n]),
        .aximm_arsize     (client_aximm_arsize[n]),
        .aximm_arburst    (client_aximm_arburst[n]),
        .aximm_arlock     (client_aximm_arlock[n]),
        .aximm_arcache    (client_aximm_arcache[n]),
        .aximm_arqos      (client_aximm_arqos[n]),
        .aximm_rvalid     (client_aximm_rvalid[n]),
        .aximm_rready     (client_aximm_rready[n]),
        .aximm_rid        (client_aximm_rid[n]),
        .aximm_rdata      (client_aximm_rdata[n]),
        .aximm_rresp      (client_aximm_rresp[n]),
        .aximm_rlast      (client_aximm_rlast[n])  
      );


    assign rd_rx_fifo  [n][14:1] = 'b0;
    assign wr_tx_fifo  [n][14:1] = 'b0;
    assign din_tx_fifo [n][14:1] = 'b0;

    assign axi_rq_tdata_client[n]  = 'b0;
    assign axi_rq_tkeep_client[n]  = 'b0;
    assign axi_rq_tlast_client[n]  = 'b0;
    assign axi_rq_tuser_client[n]  = 'b0;
    assign axi_rq_tvalid_client[n] = 'b0;
    assign axi_rc_tready_client[n] = 'b0;
    
    assign	direct_axis_rx_tready_comm_block_to_client[n]	= 'b0;
	assign	direct_axis_tx_tdata_client_to_comm_block[n]	= 'b0;
	assign	direct_axis_tx_tkeep_client_to_comm_block[n]	= 'b0;
	assign	direct_axis_tx_tlast_client_to_comm_block[n]	= 'b0;
	assign	direct_axis_tx_tvalid_client_to_comm_block[n]	= 'b0;
	assign	direct_axis_tx_tuser_client_to_comm_block[n]	= 'b0;



   end
   end
   endgenerate 

  assign sb_fabric_clock   = user_clk;
  assign reset_sb_fabric_n = ~generic_chassis_rst;


//generate instantiation for SB FABRIC TRANSACTOR
  genvar o;
  generate if (NUM_OF_SB_FABRIC_TRANSACTOR != 0) 
  begin: SB_FABRIC_TRANSACTOR
  
   for (o=START_OF_SB_FABRIC_TRANSACTOR; o<START_OF_SB_FABRIC_TRANSACTOR+NUM_OF_SB_FABRIC_TRANSACTOR; o++)
    begin
    
    assign client_clk[o] = sb_fabric_clk[o-START_OF_SB_FABRIC_TRANSACTOR];
   
  
   
   SB_Transactor_top  # (
                            .MAXPLDBIT				(SB_FABRIC_MAXPLDBIT[o-START_OF_SB_FABRIC_TRANSACTOR]),
                            .SB_TRANSACTOR_IS_AGENT (0),
                            .SUPPORT_HSB_AND_SSB    (SB_FABRIC_SUPPORT_HSB_AND_SSB[o-START_OF_SB_FABRIC_TRANSACTOR]),
                            .TRANSACTOR_TYPE		(SB_FABRIC_TYPE),
                            .TRANSACTOR_VERSION (SB_FABRIC_TRANSACTOR_VERSION)
)
	SB_FABRIC_Transactor_top_inst 
(
        `ifdef FGC_CDC
         .generic_chassis_clk 	(fgc_clk),
        `else
         .generic_chassis_clk 	(user_clk),
       `endif	
        .generic_chassis_rst 		(generic_chassis_rst),
        
        //.ICXL_clk  	     	 		(ICXL_host_clk[0]),
        //.ICXL_rst_n     	 		(ICXL_host_rstn[0]),
        .clk_sb (sb_fabric_clk[o-START_OF_SB_FABRIC_TRANSACTOR] ),
       // .rst_local_n (rst_local_n[o]),
        .rst_sb_n (rst_sb_fabric_n[o-START_OF_SB_FABRIC_TRANSACTOR]),
        .gt_sb_en (),
        .dout_rx_fifo   			(dout_rx_fifo [o][0]), 
        .rd_rx_fifo     			(rd_rx_fifo   [o][0]), 
        .empty_rx_fifo  			(empty_rx_fifo[o][0]),

        .wr_tx_fifo     			(wr_tx_fifo   [o][0]),
        .din_tx_fifo    			(din_tx_fifo  [o][0]),
        .full_tx_fifo   			(full_tx_fifo [o][0]),
        .mpccup                                  (fabric_tpccup   [o-START_OF_SB_FABRIC_TRANSACTOR]), 
        .mnpcup                                  (fabric_tnpcup   [o-START_OF_SB_FABRIC_TRANSACTOR]), 
        .mpcput                                  (fabric_tpcput   [o-START_OF_SB_FABRIC_TRANSACTOR]),
        .mnpput                                  (fabric_tnpput   [o-START_OF_SB_FABRIC_TRANSACTOR]),
        .meom                                    (fabric_teom     [o-START_OF_SB_FABRIC_TRANSACTOR]),
        .mpayload                                (fabric_tpayload [o-START_OF_SB_FABRIC_TRANSACTOR][(SB_FABRIC_MAXPLDBIT[o-START_OF_SB_FABRIC_TRANSACTOR]):0]),

        .tpccup                                  (fabric_mpccup   [o-START_OF_SB_FABRIC_TRANSACTOR]),
        .tnpcup                                  (fabric_mnpcup   [o-START_OF_SB_FABRIC_TRANSACTOR]),
        .tnpput                                  (fabric_mnpput   [o-START_OF_SB_FABRIC_TRANSACTOR]),
        .tpcput                                  (fabric_mpcput   [o-START_OF_SB_FABRIC_TRANSACTOR]),
        .teom                                    (fabric_meom     [o-START_OF_SB_FABRIC_TRANSACTOR]),
        .tpayload                                (fabric_mpayload [o-START_OF_SB_FABRIC_TRANSACTOR][(SB_FABRIC_MAXPLDBIT[o-START_OF_SB_FABRIC_TRANSACTOR]):0]),

        .side_ism_fabric                         (fabric_side_ism_agent [o-START_OF_SB_FABRIC_TRANSACTOR]),
        .side_ism_agent                          (fabric_side_ism_fabric [o-START_OF_SB_FABRIC_TRANSACTOR]),
        .side_clkreq                             (/*fabric_side_clkreq [o-START_OF_SB_FABRIC_TRANSACTOR]*/),
        .side_clkack                             (1'b1/*fabric_side_clkack [o-START_OF_SB_FABRIC_TRANSACTOR]*/),
        .sb_mailbox_out_interrupt                (),//sb_mailbox_out_interrupt [o-START_OF_SB_TRANSACTOR]),
        .sb_rst_b                                (sb_rst_b [o-START_OF_SB_FABRIC_TRANSACTOR]),
        .sb_pok                                  (sb_pok [o-START_OF_SB_FABRIC_TRANSACTOR]),
        //aximm interface with the client
        .aximm_awvalid    (client_aximm_awvalid[o]),
        .aximm_awready    (client_aximm_awready[o]),
        .aximm_awid       (client_aximm_awid[o]),
        .aximm_awaddr     (client_aximm_awaddr[o]),
        .aximm_awlen      (client_aximm_awlen[o]),
        .aximm_awsize     (client_aximm_awsize[o]),
        .aximm_awburst    (client_aximm_awburst[o]),
        .aximm_awlock     (client_aximm_awlock[o]),
        .aximm_awcache    (client_aximm_awcache[o]),
        .aximm_awqos      (client_aximm_awqos[o]),
                          
        .aximm_wvalid     (client_aximm_wvalid[o]),
        .aximm_wready     (client_aximm_wready[o]),
        .aximm_wlast      (client_aximm_wlast[o]),
        .aximm_wdata      (client_aximm_wdata[o]),
        .aximm_wstrb      (client_aximm_wstrb[o]),
           
        .aximm_bvalid     (client_aximm_bvalid[o]),
        .aximm_bready     (client_aximm_bready[o]),
        .aximm_bid        (client_aximm_bid[o]),
        .aximm_bresp      (client_aximm_bresp[o]),
           
        .aximm_arvalid    (client_aximm_arvalid[o]),
        .aximm_arready    (client_aximm_arready[o]),
        .aximm_arid       (client_aximm_arid[o]),
        .aximm_araddr     (client_aximm_araddr[o]),
        .aximm_arlen      (client_aximm_arlen[o]),
        .aximm_arsize     (client_aximm_arsize[o]),
        .aximm_arburst    (client_aximm_arburst[o]),
        .aximm_arlock     (client_aximm_arlock[o]),
        .aximm_arcache    (client_aximm_arcache[o]),
        .aximm_arqos      (client_aximm_arqos[o]),
        .aximm_rvalid     (client_aximm_rvalid[o]),
        .aximm_rready     (client_aximm_rready[o]),
        .aximm_rid        (client_aximm_rid[o]),
        .aximm_rdata      (client_aximm_rdata[o]),
        .aximm_rresp      (client_aximm_rresp[o]),
        .aximm_rlast      (client_aximm_rlast[o])  
      );


    assign 	rd_rx_fifo  [o][14:1] 							= 'b0;
    assign 	wr_tx_fifo  [o][14:1] 							= 'b0;
    assign 	din_tx_fifo [o][14:1] 							= 'b0;

    assign 	axi_rq_tdata_client[o]  						= 'b0;
    assign 	axi_rq_tkeep_client[o]  						= 'b0;
    assign 	axi_rq_tlast_client[o] 	 						= 'b0;
    assign 	axi_rq_tuser_client[o]  						= 'b0;
    assign 	axi_rq_tvalid_client[o] 						= 'b0;
    assign 	axi_rc_tready_client[o] 						= 'b0;

	assign	direct_axis_rx_tready_comm_block_to_client[o]	= 'b0;
	assign	direct_axis_tx_tdata_client_to_comm_block[o]	= 'b0;
	assign	direct_axis_tx_tkeep_client_to_comm_block[o]	= 'b0;
	assign	direct_axis_tx_tlast_client_to_comm_block[o]	= 'b0;
	assign	direct_axis_tx_tvalid_client_to_comm_block[o]	= 'b0;
	assign	direct_axis_tx_tuser_client_to_comm_block[o]	= 'b0;

   end
   end
   endgenerate
   
  /////////////   SFI Transactor 

`include "SFI_wires.sv"

   generate if (SFI_LOOPBACK != 0)
 begin    
   
   `include "SFI_lpbk.sv"
     assign 	sfi_clk_0 		= user_clk;
	 assign 	rst_sfi_n_0 	= !generic_chassis_rst;
	 assign 	sfi_clk_1 		= user_clk;
	 assign 	rst_sfi_n_1 	= !generic_chassis_rst;
	 assign 	sfi_clk_2 		= user_clk;
	 assign 	rst_sfi_n_2 	= !generic_chassis_rst;
	 assign 	sfi_clk_3 		= user_clk;
	 assign 	rst_sfi_n_3 	= !generic_chassis_rst;
 end 
endgenerate
    
   
//generate instantiation for SFI TRANSACTOR
  genvar v;
  generate if (NUM_OF_SFI_TRANSACTOR != 0) 
  begin: SFI_TRANSACTOR
  
   for (v=START_OF_SFI_TRANSACTOR; v<START_OF_SFI_TRANSACTOR+NUM_OF_SFI_TRANSACTOR; v++)
    begin
    
   // `ifdef FGC_CDC
  assign client_clk[v] = sfi_clk[v-START_OF_SFI_TRANSACTOR];
 //`else
 // assign client_clk[v] = user_clk;
 //`endif
   
   SFI_Transactor_top  # (
							.TRANSACTOR_TYPE 		(SFI_TYPE),
							.TRANSACTOR_VERSION 	(SFI_TRANSACTOR_VERSION),
							.C_DATA_WIDTH			(C_DATA_WIDTH),
							.HPARITY				(HPARITY),
							.M					 	(M),
							.H						(H),
							.D						(SFI_D[v-START_OF_SFI_TRANSACTOR]),
							.DS						(DS),
							.NDCRD					(NDCRD),
							.NHCRD 					(NHCRD)
)
	SFI_Transactor_top_inst 
(
        `ifdef FGC_CDC
         .generic_chassis_clk 			(fgc_clk),
        `else
         .generic_chassis_clk 			(user_clk),
       `endif	
        .generic_chassis_rst 			(generic_chassis_rst),
        
        .SFI_clk 						(sfi_clk[v-START_OF_SFI_TRANSACTOR] ),
        .SFI_rst_n						(rst_sfi_n[v-START_OF_SFI_TRANSACTOR]),

        .dout_rx_fifo   				(dout_rx_fifo [v][3:0]), 
        .rd_rx_fifo     				(rd_rx_fifo   [v][3:0]), 
        .empty_rx_fifo  				(empty_rx_fifo[v][3:0]),

        .wr_tx_fifo     				(wr_tx_fifo   [v][3:0]),
        .din_tx_fifo    				(din_tx_fifo  [v][3:0]),
        .full_tx_fifo   				(full_tx_fifo [v][3:0]),
      
       `ifdef PCIE_BRIDGE  
         //DESC inerface
     //direct wires. DS direct  - desc interface
   
		.direct_desc_rx_ack				(direct_desc_rx_ack[v]),
		.direct_desc_rx_ws				(direct_desc_rx_ws[v]),
		.direct_desc_rx_eof				(direct_desc_rx_eof[v]), 
		.direct_desc_rx_req				(direct_desc_rx_req[v]),
		.direct_desc_rx_desc			(direct_desc_rx_desc[v]),
		.direct_desc_rx_dfr				(direct_desc_rx_dfr[v]),
		.direct_desc_rx_dv				(direct_desc_rx_dv[v]),
		.direct_desc_rx_be				(direct_desc_rx_be[v]),
		.direct_desc_rx_data			(direct_desc_rx_data[v]),  

	//direct wires. US direct  - desc interface
		.direct_desc_tx_cmd_desc		(direct_desc_tx_desc[v]),
		.direct_desc_tx_data_desc		(direct_desc_tx_data[v]),
		.direct_desc_tx_req				(direct_desc_tx_req[v]),
		.direct_desc_tx_dfr				(direct_desc_tx_dfr[v]),
		.direct_desc_tx_ack				(direct_desc_tx_ack[v]),
		.direct_desc_tx_ws				(direct_desc_tx_ws[v]),	
		.direct_desc_tx_req_arbiter		(direct_desc_tx_req_arbiter[v]),
		.direct_desc_tx_ack_arbiter		(direct_desc_tx_ack_arbiter[v]),
	`endif
	
       /* //direct wires. DS direct (cq and cc)
		.direct_axis_cq_tvalid			(direct_axis_rx_tvalid_comm_block_to_client[v]),
		.direct_axis_cq_tlast			(direct_axis_rx_tlast_comm_block_to_client[v]),
		.direct_axis_cq_tuser			(direct_axis_rx_tuser_comm_block_to_client[v]),
		.direct_axis_cq_tkeep			(direct_axis_rx_tkeep_comm_block_to_client[v]),
		.direct_axis_cq_tdata			(direct_axis_rx_tdata_comm_block_to_client[v]),
		.direct_axis_cq_tready			(direct_axis_rx_tready_comm_block_to_client[v]),
//  .direct_completer_id	(),

		.direct_axis_cc_tdata			(direct_axis_tx_tdata_client_to_comm_block[v]),
		.direct_axis_cc_tkeep			(direct_axis_tx_tkeep_client_to_comm_block[v]),
		.direct_axis_cc_tlast			(direct_axis_tx_tlast_client_to_comm_block[v]),
		.direct_axis_cc_tvalid			(direct_axis_tx_tvalid_client_to_comm_block[v]),
		.direct_axis_cc_tuser			(direct_axis_tx_tuser_client_to_comm_block[v]),
		.direct_axis_cc_tready			(direct_axis_tx_tready_client_to_comm_block[v]),*/
        
          
   //global channel - RX

        .sfi_rx_txcon_req				(sfi_rx_txcon_req[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_rxcon_ack				(sfi_rx_rxcon_ack[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_rxdiscon_nack			(sfi_rx_rxdiscon_nack[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_rx_empty				(sfi_rx_rx_empty[v-START_OF_SFI_TRANSACTOR]),
	
   //global channel - TX
		.sfi_tx_txcon_req				(sfi_tx_txcon_req[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_rxcon_ack				(sfi_tx_rxcon_ack[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_rxdiscon_nack			(sfi_tx_rxdiscon_nack[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_rx_empty				(sfi_tx_rx_empty[v-START_OF_SFI_TRANSACTOR]),
	
   //header channel - RX
		.sfi_rx_hdr_valid				(sfi_rx_hdr_valid[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_hdr_early_valid			(sfi_rx_hdr_early_valid[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_hdr_block				(sfi_rx_hdr_block[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_header					(sfi_rx_header[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_hdr_info_bytes			(sfi_rx_hdr_info_bytes[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_hdr_crd_rtn_valid		(sfi_rx_hdr_crd_rtn_valid[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_hdr_crd_rtn_ded			(sfi_rx_hdr_crd_rtn_ded[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_hdr_crd_rtn_fc_id		(sfi_rx_hdr_crd_rtn_fc_id[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_hdr_crd_rtn_vc_id		(sfi_rx_hdr_crd_rtn_vc_id[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_hdr_crd_rtn_value		(sfi_rx_hdr_crd_rtn_value[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_hdr_crd_rtn_block		(sfi_rx_hdr_crd_rtn_block[v-START_OF_SFI_TRANSACTOR]),
	
   //data channel - RX
		.sfi_rx_data_valid				(sfi_rx_data_valid[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_data_early_valid		(sfi_rx_data_early_valid[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_data_block				(sfi_rx_data_block[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_data					(sfi_rx_data[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_data_parity				(sfi_rx_data_parity[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_data_start				(sfi_rx_data_start[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_data_info_byte			(sfi_rx_data_info_byte[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_data_end				(sfi_rx_data_end[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_data_poison				(sfi_rx_data_poison[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_data_edb				(sfi_rx_data_edb[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_data_aux_parity			(sfi_rx_data_aux_parity[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_data_crd_rtn_valid		(sfi_rx_data_crd_rtn_valid[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_data_crd_rtn_ded		(sfi_rx_data_crd_rtn_ded[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_data_crd_rtn_fc_id		(sfi_rx_data_crd_rtn_fc_id[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_data_crd_rtn_vc_id		(sfi_rx_data_crd_rtn_vc_id[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_data_crd_rtn_value		(sfi_rx_data_crd_rtn_value[v-START_OF_SFI_TRANSACTOR]),
		.sfi_rx_data_crd_rtn_block		(sfi_rx_data_crd_rtn_block[v-START_OF_SFI_TRANSACTOR]),

   //header channel - TX
		.sfi_tx_hdr_valid				(sfi_tx_hdr_valid[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_hdr_early_valid			(sfi_tx_hdr_early_valid[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_hdr_block				(sfi_tx_hdr_block[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_header					(sfi_tx_header[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_hdr_info_bytes			(sfi_tx_hdr_info_bytes[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_hdr_crd_rtn_valid		(sfi_tx_hdr_crd_rtn_valid[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_hdr_crd_rtn_ded			(sfi_tx_hdr_crd_rtn_ded[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_hdr_crd_rtn_fc_id		(sfi_tx_hdr_crd_rtn_fc_id[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_hdr_crd_rtn_vc_id		(sfi_tx_hdr_crd_rtn_vc_id[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_hdr_crd_rtn_value		(sfi_tx_hdr_crd_rtn_value[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_hdr_crd_rtn_block		(sfi_tx_hdr_crd_rtn_block[v-START_OF_SFI_TRANSACTOR]),
	
   //data channel - TX
		.sfi_tx_data_valid				(sfi_tx_data_valid[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_data_early_valid		(sfi_tx_data_early_valid[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_data_block				(sfi_tx_data_block[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_data					(sfi_tx_data[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_data_parity				(sfi_tx_data_parity[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_data_start				(sfi_tx_data_start[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_data_info_byte			(sfi_tx_data_info_byte[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_data_end				(sfi_tx_data_end[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_data_poison				(sfi_tx_data_poison[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_data_edb				(sfi_tx_data_edb[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_data_aux_parity			(sfi_tx_data_aux_parity[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_data_crd_rtn_valid		(sfi_tx_data_crd_rtn_valid[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_data_crd_rtn_ded		(sfi_tx_data_crd_rtn_ded[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_data_crd_rtn_fc_id		(sfi_tx_data_crd_rtn_fc_id[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_data_crd_rtn_vc_id		(sfi_tx_data_crd_rtn_vc_id[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_data_crd_rtn_value		(sfi_tx_data_crd_rtn_value[v-START_OF_SFI_TRANSACTOR]),
		.sfi_tx_data_crd_rtn_block		(sfi_tx_data_crd_rtn_block[v-START_OF_SFI_TRANSACTOR]),

        //aximm interface with the client
        .aximm_awvalid    (client_aximm_awvalid[v]),
        .aximm_awready    (client_aximm_awready[v]),
        .aximm_awid       (client_aximm_awid[v]),
        .aximm_awaddr     (client_aximm_awaddr[v]),
        .aximm_awlen      (client_aximm_awlen[v]),
        .aximm_awsize     (client_aximm_awsize[v]),
        .aximm_awburst    (client_aximm_awburst[v]),
        .aximm_awlock     (client_aximm_awlock[v]),
        .aximm_awcache    (client_aximm_awcache[v]),
        .aximm_awqos      (client_aximm_awqos[v]),
                          
        .aximm_wvalid     (client_aximm_wvalid[v]),
        .aximm_wready     (client_aximm_wready[v]),
        .aximm_wlast      (client_aximm_wlast[v]),
        .aximm_wdata      (client_aximm_wdata[v]),
        .aximm_wstrb      (client_aximm_wstrb[v]),
           
        .aximm_bvalid     (client_aximm_bvalid[v]),
        .aximm_bready     (client_aximm_bready[v]),
        .aximm_bid        (client_aximm_bid[v]),
        .aximm_bresp      (client_aximm_bresp[v]),
           
        .aximm_arvalid    (client_aximm_arvalid[v]),
        .aximm_arready    (client_aximm_arready[v]),
        .aximm_arid       (client_aximm_arid[v]),
        .aximm_araddr     (client_aximm_araddr[v]),
        .aximm_arlen      (client_aximm_arlen[v]),
        .aximm_arsize     (client_aximm_arsize[v]),
        .aximm_arburst    (client_aximm_arburst[v]),
        .aximm_arlock     (client_aximm_arlock[v]),
        .aximm_arcache    (client_aximm_arcache[v]),
        .aximm_arqos      (client_aximm_arqos[v]),
        .aximm_rvalid     (client_aximm_rvalid[v]),
        .aximm_rready     (client_aximm_rready[v]),
        .aximm_rid        (client_aximm_rid[v]),
        .aximm_rdata      (client_aximm_rdata[v]),
        .aximm_rresp      (client_aximm_rresp[v]),
        .aximm_rlast      (client_aximm_rlast[v])  
      );


    assign rd_rx_fifo  [v][14:4] = 'b0;
    assign wr_tx_fifo  [v][14:4] = 'b0;
    assign din_tx_fifo [v][14:4] = 'b0;

    assign axi_rq_tdata_client[v]  = 'b0;
    assign axi_rq_tkeep_client[v]  = 'b0;
    assign axi_rq_tlast_client[v]  = 'b0;
    assign axi_rq_tuser_client[v]  = 'b0;
    assign axi_rq_tvalid_client[v] = 'b0;
    assign axi_rc_tready_client[v] = 'b0;

`ifndef PCIE_BRIDGE   
    assign direct_desc_rx_ack[v]  = 'b0; 
    assign direct_desc_rx_ws[v]   = 'b0;
    assign direct_desc_rx_eof[v]  = 'b0;
    assign direct_desc_tx_req[v]  = 'b0;
    assign direct_desc_tx_desc[v] = 'b0;
    assign direct_desc_tx_data[v] = 'b0;
    assign direct_desc_tx_dfr[v]  = 'b0;
  `endif  

   end
   end
   endgenerate 

    
//Template Transactor

	`include "Template_Transactor_wires.sv"	
		
		
//generate instantiation for Template Transactor

  genvar p;
  generate if (NUM_OF_TEMPLATE_TRANSACTOR != 0) 
  begin: TEMPLATE_TRANSACTOR
  
   for (p=START_OF_TEMPLATE_TRANSACTOR; p<START_OF_TEMPLATE_TRANSACTOR+NUM_OF_TEMPLATE_TRANSACTOR; p++)
    begin
    
    assign client_clk[p] = Template_Transactor_clk[p-START_OF_TEMPLATE_TRANSACTOR];
   
   Template_Transactor_top  # (
                            .TRANSACTOR_TYPE			(TEMPLATE_TYPE),
                            .TRANSACTOR_VERSION			(TEMPLATE_TRANSACTOR_VERSION),
                            .TEMPLATE_OUTPUT_PORT_WIDTH	(TEMPLATE_OUTPUT_PORT_WIDTH[p-START_OF_TEMPLATE_TRANSACTOR]),
                            .TEMPLATE_INPUT_PORT_WIDTH	(TEMPLATE_INPUT_PORT_WIDTH[p-START_OF_TEMPLATE_TRANSACTOR]),
                            .TEMPLATE_NUM_OF_TX_FIFO	(NUM_OF_RX_FIFO[p]),
                            .TEMPLATE_NUM_OF_RX_FIFO	(NUM_OF_RX_FIFO[p])	
)
	Template_Transactor_top_inst
        (
        `ifdef FGC_CDC
         .generic_chassis_clk 	(fgc_clk),
        `else
         .generic_chassis_clk 	(user_clk),
       `endif
        .generic_chassis_rst 	(generic_chassis_rst),
        
        .Template_clk  	  	 	(Template_Transactor_clk[p-START_OF_TEMPLATE_TRANSACTOR]),
        .Template_rst_n    		(Template_Transactor_rstn[p-START_OF_TEMPLATE_TRANSACTOR]),
        
        .dout_rx_fifo   		(dout_rx_fifo [p][(NUM_OF_RX_FIFO[p]-1):0]), 
        .rd_rx_fifo     		(rd_rx_fifo   [p][(NUM_OF_RX_FIFO[p]-1):0]), 
        .empty_rx_fifo  		(empty_rx_fifo[p][(NUM_OF_RX_FIFO[p]-1):0]),

        .wr_tx_fifo     		(wr_tx_fifo   [p][(NUM_OF_TX_FIFO[p]-1):0]),
        .din_tx_fifo   			(din_tx_fifo  [p][(NUM_OF_TX_FIFO[p]-1):0]),
        .full_tx_fifo   		(full_tx_fifo [p][(NUM_OF_TX_FIFO[p]-1):0]),

		.Template_output_port   (Template_Transactor_output_port[p-START_OF_TEMPLATE_TRANSACTOR]),
		.Template_input_port   	(Template_Transactor_input_port[p-START_OF_TEMPLATE_TRANSACTOR]),
    
        //aximm interface with the client
        .aximm_awvalid    (client_aximm_awvalid[p]),
        .aximm_awready    (client_aximm_awready[p]),
        .aximm_awid       (client_aximm_awid[p]),
        .aximm_awaddr     (client_aximm_awaddr[p]),
        .aximm_awlen      (client_aximm_awlen[p]),
        .aximm_awsize     (client_aximm_awsize[p]),
        .aximm_awburst    (client_aximm_awburst[p]),
        .aximm_awlock     (client_aximm_awlock[p]),
        .aximm_awcache    (client_aximm_awcache[p]),
        .aximm_awqos      (client_aximm_awqos[p]),
                          
        .aximm_wvalid     (client_aximm_wvalid[p]),
        .aximm_wready     (client_aximm_wready[p]),
        .aximm_wlast      (client_aximm_wlast[p]),
        .aximm_wdata      (client_aximm_wdata[p]),
        .aximm_wstrb      (client_aximm_wstrb[p]),
           
        .aximm_bvalid     (client_aximm_bvalid[p]),
        .aximm_bready     (client_aximm_bready[p]),
        .aximm_bid        (client_aximm_bid[p]),
        .aximm_bresp      (client_aximm_bresp[p]),
           
        .aximm_arvalid    (client_aximm_arvalid[p]),
        .aximm_arready    (client_aximm_arready[p]),
        .aximm_arid       (client_aximm_arid[p]),
        .aximm_araddr     (client_aximm_araddr[p]),
        .aximm_arlen      (client_aximm_arlen[p]),
        .aximm_arsize     (client_aximm_arsize[p]),
        .aximm_arburst    (client_aximm_arburst[p]),
        .aximm_arlock     (client_aximm_arlock[p]),
        .aximm_arcache    (client_aximm_arcache[p]),
        .aximm_arqos      (client_aximm_arqos[p]),
        .aximm_rvalid     (client_aximm_rvalid[p]),
        .aximm_rready     (client_aximm_rready[p]),
        .aximm_rid        (client_aximm_rid[p]),
        .aximm_rdata      (client_aximm_rdata[p]),
        .aximm_rresp      (client_aximm_rresp[p]),
        .aximm_rlast      (client_aximm_rlast[p])  
       );   
         
        if (NUM_OF_TX_FIFO[p] != 15) begin
        assign wr_tx_fifo  [p][14:(NUM_OF_TX_FIFO[p])] = 'b0;
		assign din_tx_fifo [p][14:(NUM_OF_TX_FIFO[p])] = 'b0;
        end
         
        if (NUM_OF_RX_FIFO[p] != 15) begin
        assign rd_rx_fifo  [p][14:(NUM_OF_RX_FIFO[p])] = 'b0;
		end
         
        assign axi_rq_tdata_client[p]  = 'b0;
		assign axi_rq_tkeep_client[p]  = 'b0;
		assign axi_rq_tlast_client[p]  = 'b0;
		assign axi_rq_tuser_client[p]  = 'b0;
		assign axi_rq_tvalid_client[p] = 'b0;
		assign axi_rc_tready_client[p] = 'b0;  
		
		assign	direct_axis_rx_tready_comm_block_to_client[p]	= 'b0;
		assign	direct_axis_tx_tdata_client_to_comm_block[p]	= 'b0;
		assign	direct_axis_tx_tkeep_client_to_comm_block[p]	= 'b0;
		assign	direct_axis_tx_tlast_client_to_comm_block[p]	= 'b0;
		assign	direct_axis_tx_tvalid_client_to_comm_block[p]	= 'b0;
		assign	direct_axis_tx_tuser_client_to_comm_block[p]	= 'b0;
     
    end
  end // :Template Transactor
  endgenerate
  

//----------------------------------------------------------------------------
`include "axim_slave_width_decl.svh" 
`include "AXIM_slave_wires.sv"
`include "axim_master_width_decl.svh" 
`include "AXIM_master_wires.sv"


//`ifdef AXIM_LOOPBACK
generate if (AXIM_LOOPBACK != 0)
 begin    
   //`include "AXIM_lpbk.sv"
   `include "AXIM_lpbk_0.sv"
   `include "AXIM_lpbk_1.sv"
   `include "AXIM_lpbk_2.sv"
   `include "AXIM_lpbk_3.sv"
   assign s_clock_0 = user_clk;
   assign s_rstn_0 = !generic_chassis_rst;
   assign s_clock_1 = user_clk;
   assign s_rstn_1 = !generic_chassis_rst;
   assign s_clock_2 = user_clk;
   assign s_rstn_2 = !generic_chassis_rst;
   assign s_clock_3 = user_clk;
   assign s_rstn_3 = !generic_chassis_rst;
 end 
endgenerate
//`endif


  //generate instantiation AXIM Slave Xtor
  genvar q;
  generate if (NUM_OF_AXIM_SLAVE_TRANSACTOR != 0) 
  begin: AXIM_SLAVE
  
  for (q=START_OF_AXIM_SLAVE_TRANSACTOR; q<START_OF_AXIM_SLAVE_TRANSACTOR+NUM_OF_AXIM_SLAVE_TRANSACTOR; q++)
  begin
 `ifdef FGC_CDC
  assign client_clk[q] = s_clk[q-START_OF_AXIM_SLAVE_TRANSACTOR];
 `else
  assign client_clk[q] = user_clk;
 `endif
    axim_slave_xtor #(     
                         `include "axim_slave_param_inst.svh"
                         .AXIM_ADDR_COMMAND_WIDTH(AXIM_SLAVE_ADDR_COMMAND_WIDTH[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
                         .DATA_128_512(AXI_SLAVE_DATA_WIDTH[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
                         .TRANSACTOR_TYPE(AXIM_SLAVE_TYPE),
                         .TRANSACTOR_VERSION(AXIM_SLAVE_TRANSACTOR_VERSION)                         
                         )
   axim_slave_xtor_inst(
     `ifdef FGC_CDC
     .fgc_clk 	(fgc_clk),
     `else
     .fgc_clk 	(user_clk),
     `endif	
    .rstn             	(~generic_chassis_rst),
    .s_clk		        	(s_clk[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_rst_n		        (s_rst_n[q-START_OF_AXIM_SLAVE_TRANSACTOR]),

    .s_awvalid(s_awvalid[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_awready(s_awready[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_awid(s_awid[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_awaddr(s_awaddr[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_awlen(s_awlen[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_awsize(s_awsize[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_awburst(s_awburst[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_awlock(s_awlock[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_awcache(s_awcache[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_awprot(s_awprot[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_awqos(s_awqos[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_awregion(s_awregion[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_awuser(s_awuser[q-START_OF_AXIM_SLAVE_TRANSACTOR]),

    .s_wvalid(s_wvalid[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_wready(s_wready[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_wid(s_wid[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_wdata(s_wdata[(((q-START_OF_AXIM_SLAVE_TRANSACTOR+1)*1024)-1):(1024*(q-START_OF_AXIM_SLAVE_TRANSACTOR))]),
    .s_wstrb(s_wstrb[(((q-START_OF_AXIM_SLAVE_TRANSACTOR+1)*128)-1):(128*(q-START_OF_AXIM_SLAVE_TRANSACTOR))]),
    .s_wlast(s_wlast[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_wuser(s_wuser[q-START_OF_AXIM_SLAVE_TRANSACTOR]),

    .s_arvalid(s_arvalid[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_arready(s_arready[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_arid(s_arid[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_araddr(s_araddr[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_arlen(s_arlen[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_arsize(s_arsize[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_arburst(s_arburst[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_arlock(s_arlock[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_arcache(s_arcache[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_arprot(s_arprot[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_arqos(s_arqos[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_arregion(s_arregion[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_aruser(s_aruser[q-START_OF_AXIM_SLAVE_TRANSACTOR]),

    .s_rvalid(s_rvalid[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_rready(s_rready[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_rid(s_rid[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_rdata(s_rdata[(((q-START_OF_AXIM_SLAVE_TRANSACTOR+1)*1024)-1):(1024*(q-START_OF_AXIM_SLAVE_TRANSACTOR))]),
    .s_rresp(s_rresp[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_rlast(s_rlast[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_ruser(s_ruser[q-START_OF_AXIM_SLAVE_TRANSACTOR]),

    .s_bvalid(s_bvalid[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_bready(s_bready[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_bid(s_bid[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_bresp(s_bresp[q-START_OF_AXIM_SLAVE_TRANSACTOR]),
    .s_buser(s_buser[q-START_OF_AXIM_SLAVE_TRANSACTOR]),

    .fifo_b_data_in (dout_rx_fifo[q][0]),
    .fifo_b_re_out  (rd_rx_fifo[q][0]),
    .fifo_b_empty_in(empty_rx_fifo[q][0]),

    .fifo_r_data_in (dout_rx_fifo[q][1]),
    .fifo_r_re_out  (rd_rx_fifo[q][1]),
    .fifo_r_empty_in(empty_rx_fifo[q][1]),

    .fifo_r_c_data_in (dout_rx_fifo[q][2]),
    .fifo_r_c_re_out  (rd_rx_fifo[q][2]),
    .fifo_r_c_empty_in(empty_rx_fifo[q][2]),

    .fifo_aw_data_out(din_tx_fifo  [q][0]),
    .fifo_aw_we_out  (wr_tx_fifo   [q][0]),
    .fifo_aw_wait_in (full_tx_fifo [q][0]),

    .fifo_w_data_out(din_tx_fifo  [q][1]),
    .fifo_w_we_out  (wr_tx_fifo   [q][1]),
    .fifo_w_wait_in (full_tx_fifo [q][1]),

    .fifo_w_c_data_out(din_tx_fifo  [q][2]),
    .fifo_w_c_we_out  (wr_tx_fifo   [q][2]),
    .fifo_w_c_wait_in (full_tx_fifo [q][2]),

    .fifo_ar_data_out(din_tx_fifo  [q][3]),
    .fifo_ar_we_out (wr_tx_fifo   [q][3]),
    .fifo_ar_wait_in(full_tx_fifo [q][3]),

    .device_number		(cfg_device_number),
    .function_number  (cfg_function_number),
    .bus_number			  (cfg_bus_number),

    .aximm_awvalid    (client_aximm_awvalid[q]),
    .aximm_awready    (client_aximm_awready[q]),
    .aximm_awid       (client_aximm_awid[q]),
    .aximm_awaddr     (client_aximm_awaddr[q]),
    .aximm_awlen      (client_aximm_awlen[q]),
    .aximm_awsize     (client_aximm_awsize[q]),
    .aximm_awburst    (client_aximm_awburst[q]),
    .aximm_awlock     (client_aximm_awlock[q]),
    .aximm_awcache    (client_aximm_awcache[q]),
    .aximm_awqos      (client_aximm_awqos[q]),
                    
    .aximm_wvalid     (client_aximm_wvalid[q]),
    .aximm_wready     (client_aximm_wready[q]),
    .aximm_wlast      (client_aximm_wlast[q]),
    .aximm_wdata      (client_aximm_wdata[q]),
    .aximm_wstrb      (client_aximm_wstrb[q]),
     
    .aximm_bvalid     (client_aximm_bvalid[q]),
    .aximm_bready     (client_aximm_bready[q]),
    .aximm_bid        (client_aximm_bid[q]),
    .aximm_bresp      (client_aximm_bresp[q]),
     
    .aximm_arvalid    (client_aximm_arvalid[q]),
    .aximm_arready    (client_aximm_arready[q]),
    .aximm_arid       (client_aximm_arid[q]),
    .aximm_araddr     (client_aximm_araddr[q]),
    .aximm_arlen      (client_aximm_arlen[q]),
    .aximm_arsize     (client_aximm_arsize[q]),
    .aximm_arburst    (client_aximm_arburst[q]),
    .aximm_arlock     (client_aximm_arlock[q]),
    .aximm_arcache    (client_aximm_arcache[q]),
    .aximm_arqos      (client_aximm_arqos[q]),
  
    .aximm_rvalid    (client_aximm_rvalid[q]),
    .aximm_rready    (client_aximm_rready[q]),
    .aximm_rid       (client_aximm_rid[q]),
    .aximm_rdata     (client_aximm_rdata[q]),
    .aximm_rresp     (client_aximm_rresp[q]),
    .aximm_rlast     (client_aximm_rlast[q]),


    .direct_axis_rx_tdata (axi_rc_tdata_client[q]),
   	.direct_axis_rx_tkeep (axi_rc_tkeep_client[q]),
    .direct_axis_rx_tlast (axi_rc_tlast_client[q]),
    .direct_axis_rx_tvalid(axi_rc_tvalid_client[q]),
    .direct_axis_rx_tuser (axi_rc_tuser_client[q]),
    .direct_axis_rx_tready(axi_rc_tready_client[q]),
    .direct_axis_tx_tdata (axi_rq_tdata_client[q]),
    .direct_axis_tx_tkeep (axi_rq_tkeep_client[q]),
    .direct_axis_tx_tlast (axi_rq_tlast_client[q]),
    .direct_axis_tx_tvalid(axi_rq_tvalid_client[q]),
    .direct_axis_tx_tuser (axi_rq_tuser_client[q]),
    .direct_axis_tx_tready(axi_rq_tready_client[q])  

);
    
    assign rd_rx_fifo  [q][14:3] = 'b0;
    assign wr_tx_fifo  [q][14:4] = 'b0;
    assign din_tx_fifo [q][14:4] = 'b0;
    
    assign	direct_axis_rx_tready_comm_block_to_client[q]	= 'b0;
	assign	direct_axis_tx_tdata_client_to_comm_block[q]	= 'b0;
	assign	direct_axis_tx_tkeep_client_to_comm_block[q]	= 'b0;
	assign	direct_axis_tx_tlast_client_to_comm_block[q]	= 'b0;
	assign	direct_axis_tx_tvalid_client_to_comm_block[q]	= 'b0;
	assign	direct_axis_tx_tuser_client_to_comm_block[q]	= 'b0;

     
    end
  end // :AXIM_SLAVE_XTOR
  endgenerate
  // end of AXIM_SLAVE_XTOR

//----------------------------------------------------------------------------
//`ifdef AXIM_LOOPBACK
generate if (AXIM_LOOPBACK != 0)
 begin    
  assign m_clock_0 = user_clk;
  assign m_rstn_0 = !generic_chassis_rst;
  assign m_clock_1 = user_clk;
  assign m_rstn_1 = !generic_chassis_rst;
  assign m_clock_2 = user_clk;
  assign m_rstn_2 = !generic_chassis_rst;
  assign m_clock_3 = user_clk;
  assign m_rstn_3 = !generic_chassis_rst;
 end 
endgenerate  
//`endif

  //generate instantiation AXIM MASTER Xtor
  genvar r;
  generate if (NUM_OF_AXIM_MASTER_TRANSACTOR != 0) 
  begin: AXIM_MASTER
  
  for (r=START_OF_AXIM_MASTER_TRANSACTOR; r<START_OF_AXIM_MASTER_TRANSACTOR+NUM_OF_AXIM_MASTER_TRANSACTOR; r++)
    begin
`ifdef FGC_CDC
  assign client_clk[r] = m_clk[r-START_OF_AXIM_MASTER_TRANSACTOR];
 `else
  assign client_clk[r] = user_clk;
 `endif

    axim_master_xtor #(  
                         `include "axim_master_param_inst.svh"
                         .AXIM_ADDR_COMMAND_WIDTH(AXIM_MASTER_ADDR_COMMAND_WIDTH[r-START_OF_AXIM_MASTER_TRANSACTOR]),
                         .DATA_128_512(AXI_MASTER_DATA_WIDTH[r-START_OF_AXIM_MASTER_TRANSACTOR]),
                         .TRANSACTOR_TYPE(AXIM_MASTER_TYPE),
                         .TRANSACTOR_VERSION(AXIM_MASTER_TRANSACTOR_VERSION)                         
                         )
   axim_master_xtor_inst(
    `ifdef FGC_CDC
     .fgc_clk 	(fgc_clk),
     `else
     .fgc_clk 	(user_clk),
   `endif
    .rstn             	(~generic_chassis_rst),
    .m_clk		        	(m_clk[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_rst_n		        (m_rst_n[r-START_OF_AXIM_MASTER_TRANSACTOR]),

    .m_awvalid(m_awvalid[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_awready(m_awready[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_awid(m_awid[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_awaddr(m_awaddr[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_awlen(m_awlen[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_awsize(m_awsize[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_awburst(m_awburst[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_awlock(m_awlock[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_awcache(m_awcache[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_awprot(m_awprot[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_awqos(m_awqos[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_awregion(m_awregion[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_awuser(m_awuser[r-START_OF_AXIM_MASTER_TRANSACTOR]),

    .m_wvalid(m_wvalid[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_wready(m_wready[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_wid(m_wid[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_wdata(m_wdata[(((r-START_OF_AXIM_MASTER_TRANSACTOR+1)*1024)-1):(1024*(r-START_OF_AXIM_MASTER_TRANSACTOR))]),
    .m_wstrb(m_wstrb[(((r-START_OF_AXIM_MASTER_TRANSACTOR+1)*128)-1):(128*(r-START_OF_AXIM_MASTER_TRANSACTOR))]),
    .m_wlast(m_wlast[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_wuser(m_wuser[r-START_OF_AXIM_MASTER_TRANSACTOR]),

    .m_arvalid(m_arvalid[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_arready(m_arready[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_arid(m_arid[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_araddr(m_araddr[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_arlen(m_arlen[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_arsize(m_arsize[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_arburst(m_arburst[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_arlock(m_arlock[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_arcache(m_arcache[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_arprot(m_arprot[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_arqos(m_arqos[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_arregion(m_arregion[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_aruser(m_aruser[r-START_OF_AXIM_MASTER_TRANSACTOR]),

    .m_rvalid(m_rvalid[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_rready(m_rready[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_rid(m_rid[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_rdata(m_rdata[(((r-START_OF_AXIM_MASTER_TRANSACTOR+1)*1024)-1):(1024*(r-START_OF_AXIM_MASTER_TRANSACTOR))]),
    .m_rresp(m_rresp[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_rlast(m_rlast[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_ruser(m_ruser[r-START_OF_AXIM_MASTER_TRANSACTOR]),

    .m_bvalid(m_bvalid[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_bready(m_bready[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_bid(m_bid[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_bresp(m_bresp[r-START_OF_AXIM_MASTER_TRANSACTOR]),
    .m_buser(m_buser[r-START_OF_AXIM_MASTER_TRANSACTOR]),

    .fifo_aw_data_in (dout_rx_fifo  [r][0]),
    .fifo_aw_re_out  (rd_rx_fifo   [r][0]),
    .fifo_aw_empty_in (empty_rx_fifo [r][0]),

    .fifo_w_data_in (dout_rx_fifo  [r][1]),
    .fifo_w_re_out  (rd_rx_fifo   [r][1]),
    .fifo_w_empty_in (empty_rx_fifo [r][1]),

    .fifo_w_c_data_in (dout_rx_fifo  [r][2]),
    .fifo_w_c_re_out  (rd_rx_fifo   [r][2]),
    .fifo_w_c_empty_in(empty_rx_fifo [r][2]),

    .fifo_ar_data_in (dout_rx_fifo  [r][3]),
    .fifo_ar_re_out  (rd_rx_fifo   [r][3]),
    .fifo_ar_empty_in(empty_rx_fifo [r][3]),

    .fifo_b_data_out (din_tx_fifo[r][0]),
    .fifo_b_we_out  (wr_tx_fifo[r][0]),
    .fifo_b_wait_in(full_tx_fifo[r][0]),

    .fifo_r_data_out (din_tx_fifo[r][1]),
    .fifo_r_we_out  (wr_tx_fifo[r][1]),
    .fifo_r_wait_in(full_tx_fifo[r][1]),

    .fifo_r_c_data_out (din_tx_fifo[r][2]),
    .fifo_r_c_we_out  (wr_tx_fifo[r][2]),
    .fifo_r_c_wait_in(full_tx_fifo[r][2]),
 
    .aximm_awvalid    (client_aximm_awvalid[r]),
    .aximm_awready    (client_aximm_awready[r]),
    .aximm_awid       (client_aximm_awid[r]),
    .aximm_awaddr     (client_aximm_awaddr[r]),
    .aximm_awlen      (client_aximm_awlen[r]),
    .aximm_awsize     (client_aximm_awsize[r]),
    .aximm_awburst    (client_aximm_awburst[r]),
    .aximm_awlock     (client_aximm_awlock[r]),
    .aximm_awcache    (client_aximm_awcache[r]),
    .aximm_awqos      (client_aximm_awqos[r]),
                    
    .aximm_wvalid     (client_aximm_wvalid[r]),
    .aximm_wready     (client_aximm_wready[r]),
    .aximm_wlast      (client_aximm_wlast[r]),
    .aximm_wdata      (client_aximm_wdata[r]),
    .aximm_wstrb      (client_aximm_wstrb[r]),
     
    .aximm_bvalid     (client_aximm_bvalid[r]),
    .aximm_bready     (client_aximm_bready[r]),
    .aximm_bid        (client_aximm_bid[r]),
    .aximm_bresp      (client_aximm_bresp[r]),
     
    .aximm_arvalid    (client_aximm_arvalid[r]),
    .aximm_arready    (client_aximm_arready[r]),
    .aximm_arid       (client_aximm_arid[r]),
    .aximm_araddr     (client_aximm_araddr[r]),
    .aximm_arlen      (client_aximm_arlen[r]),
    .aximm_arsize     (client_aximm_arsize[r]),
    .aximm_arburst    (client_aximm_arburst[r]),
    .aximm_arlock     (client_aximm_arlock[r]),
    .aximm_arcache    (client_aximm_arcache[r]),
    .aximm_arqos      (client_aximm_arqos[r]),
  
    .aximm_rvalid    (client_aximm_rvalid[r]),
    .aximm_rready    (client_aximm_rready[r]),
    .aximm_rid       (client_aximm_rid[r]),
    .aximm_rdata     (client_aximm_rdata[r]),
    .aximm_rresp     (client_aximm_rresp[r]),
    .aximm_rlast     (client_aximm_rlast[r])

);
    
    assign rd_rx_fifo  [r][14:4] = 'b0;
    assign wr_tx_fifo  [r][14:4] = 'b0;
    assign din_tx_fifo [r][14:4] = 'b0;

    assign axi_rq_tdata_client[r]  = 'b0;
    assign axi_rq_tkeep_client[r]  = 'b0;
    assign axi_rq_tlast_client[r]  = 'b0;
    assign axi_rq_tuser_client[r]  = 'b0;
    assign axi_rq_tvalid_client[r] = 'b0;
    assign axi_rc_tready_client[r] = 'b0;
    
    assign	direct_axis_rx_tready_comm_block_to_client[r]	= 'b0;
	assign	direct_axis_tx_tdata_client_to_comm_block[r]	= 'b0;
	assign	direct_axis_tx_tkeep_client_to_comm_block[r]	= 'b0;
	assign	direct_axis_tx_tlast_client_to_comm_block[r]	= 'b0;
	assign	direct_axis_tx_tvalid_client_to_comm_block[r]	= 'b0;
	assign	direct_axis_tx_tuser_client_to_comm_block[r]	= 'b0;
     
    end
  end // :AXIM_MASTER_XTOR
  endgenerate
  // end of AXIM_MASTER_XTOR

// GPIO transactor

`include "GPIO_wires.sv"

//`ifdef GPIO_LOOPBACK
generate if (GPIO_LOOPBACK != 0)
 begin    
   `include "GPIO_lpbk.sv"
   assign gp_clock_0  = user_clk;
   assign gp_rstn_0  = !generic_chassis_rst;
   assign gp_clock_1  = user_clk;
   assign gp_rstn_1  = !generic_chassis_rst;
 end //
endgenerate
//`endif


  //generate instantiation GPIO Xtor
  genvar u;
  generate if (NUM_OF_GPIO_TRANSACTOR != 0) 
  begin: GPIO
  
  for (u=START_OF_GPIO_TRANSACTOR; u<START_OF_GPIO_TRANSACTOR+NUM_OF_GPIO_TRANSACTOR; u++)
  begin
 `ifdef FGC_CDC
  assign client_clk[u] = fgc_clk; //gp_clk[u-START_OF_GPIO_TRANSACTOR];
 `else
  assign client_clk[u] = user_clk;
 `endif
    gpio_xtor #(      
                         .NUM_OF_GPIO_IN(NUM_OF_GPIO_IN[u-START_OF_GPIO_TRANSACTOR]),
                         .NUM_OF_GPIO_OUT(NUM_OF_GPIO_OUT[u-START_OF_GPIO_TRANSACTOR]),
                         .RESET_VALUE_GPIO(RESET_VALUE_GPIO[u-START_OF_GPIO_TRANSACTOR]),
                         .TRANSACTOR_TYPE(GPIO_TYPE),
                         .TRANSACTOR_VERSION(GPIO_TRANSACTOR_VERSION)                         
                   )
   gpio_xtor_inst(
     `ifdef FGC_CDC
     .fgc_clk 	(fgc_clk),
     `else
     .fgc_clk 	(user_clk),
     `endif	
    .rstn             	(~generic_chassis_rst),
    .gp_clk		        	(gp_clk[u-START_OF_GPIO_TRANSACTOR]),
    .gp_rst_n		        (gp_rst_n[u-START_OF_GPIO_TRANSACTOR]),

    .gpio_in(gpio_in_bus[u-START_OF_GPIO_TRANSACTOR]),
    .gpio_out(gpio_out_bus[u-START_OF_GPIO_TRANSACTOR]),

    .fifo_data_in (dout_rx_fifo[u][0]),
    .fifo_re_out  (rd_rx_fifo[u][0]),
    .fifo_empty_in(empty_rx_fifo[u][0]),

    .fifo_data_out(din_tx_fifo  [u][0]),
    .fifo_we_out  (wr_tx_fifo   [u][0]),
    .fifo_wait_in (full_tx_fifo [u][0]),

    .aximm_awvalid    (client_aximm_awvalid[u]),
    .aximm_awready    (client_aximm_awready[u]),
    .aximm_awid       (client_aximm_awid[u]),
    .aximm_awaddr     (client_aximm_awaddr[u]),
    .aximm_awlen      (client_aximm_awlen[u]),
    .aximm_awsize     (client_aximm_awsize[u]),
    .aximm_awburst    (client_aximm_awburst[u]),
    .aximm_awlock     (client_aximm_awlock[u]),
    .aximm_awcache    (client_aximm_awcache[u]),
    .aximm_awqos      (client_aximm_awqos[u]),
                    
    .aximm_wvalid     (client_aximm_wvalid[u]),
    .aximm_wready     (client_aximm_wready[u]),
    .aximm_wlast      (client_aximm_wlast[u]),
    .aximm_wdata      (client_aximm_wdata[u]),
    .aximm_wstrb      (client_aximm_wstrb[u]),
     
    .aximm_bvalid     (client_aximm_bvalid[u]),
    .aximm_bready     (client_aximm_bready[u]),
    .aximm_bid        (client_aximm_bid[u]),
    .aximm_bresp      (client_aximm_bresp[u]),
     
    .aximm_arvalid    (client_aximm_arvalid[u]),
    .aximm_arready    (client_aximm_arready[u]),
    .aximm_arid       (client_aximm_arid[u]),
    .aximm_araddr     (client_aximm_araddr[u]),
    .aximm_arlen      (client_aximm_arlen[u]),
    .aximm_arsize     (client_aximm_arsize[u]),
    .aximm_arburst    (client_aximm_arburst[u]),
    .aximm_arlock     (client_aximm_arlock[u]),
    .aximm_arcache    (client_aximm_arcache[u]),
    .aximm_arqos      (client_aximm_arqos[u]),
  
    .aximm_rvalid    (client_aximm_rvalid[u]),
    .aximm_rready    (client_aximm_rready[u]),
    .aximm_rid       (client_aximm_rid[u]),
    .aximm_rdata     (client_aximm_rdata[u]),
    .aximm_rresp     (client_aximm_rresp[u]),
    .aximm_rlast     (client_aximm_rlast[u])

);
    
    assign rd_rx_fifo  [u][14:1] = 'b0;
    assign wr_tx_fifo  [u][14:1] = 'b0;
    assign din_tx_fifo [u][14:1] = 'b0;
    
    assign	direct_axis_rx_tready_comm_block_to_client[u]	= 'b0;
	assign	direct_axis_tx_tdata_client_to_comm_block[u]	= 'b0;
	assign	direct_axis_tx_tkeep_client_to_comm_block[u]	= 'b0;
	assign	direct_axis_tx_tlast_client_to_comm_block[u]	= 'b0;
	assign	direct_axis_tx_tvalid_client_to_comm_block[u]	= 'b0;
	assign	direct_axis_tx_tuser_client_to_comm_block[u]	= 'b0;

     
    end
  end // :GPIO_XTOR
  endgenerate
  // end of GPIO_XTOR
 //---------------------------------DDR TRANSACTOR------------------------------------------
//-------------------------generate instantiation DDR Xtor--------------------------
wire [NUM_OF_AUX_TRANSACTOR -1:0]           aux_tx_data; 
wire [NUM_OF_AUX_TRANSACTOR -1:0]           aux_tx_en;   
wire [NUM_OF_AUX_TRANSACTOR -1:0]           aux_rx_data;
wire [NUM_OF_AUX_TRANSACTOR -1:0]           select;
wire [NUM_OF_AUX_TRANSACTOR -1:0]           aux_clk; 
wire                                        identify_clk;

//assign aux_clk[0] = user_clk;
//assign aux_rx_data = aux_tx_data;
genvar w;
  generate if (NUM_OF_AUX_TRANSACTOR != 0) 
  begin: AUX
  
  for (w=START_OF_AUX_TRANSACTOR; w<START_OF_AUX_TRANSACTOR+NUM_OF_AUX_TRANSACTOR; w++)
  begin
 `ifdef FGC_CDC
  assign client_clk[w] = aux_clk [w-START_OF_AUX_TRANSACTOR];
 `else
  assign client_clk[w] = aux_clk [w-START_OF_AUX_TRANSACTOR];
 `endif
    aux_requester  #(
                         .TRANSACTOR_TYPE(AUX_TYPE),
                         .TRANSACTOR_VERSION(AUX_TRANSACTOR_VERSION)            
                         )
   aux_requester_inst(
     `ifdef FGC_CDC
     .fgc_clk 	(fgc_clk),
     `else
     .fgc_clk 	(user_clk),
     `endif	
    .rst_n(~generic_chassis_rst),
    .aux_clk		      (aux_clk [w-START_OF_AUX_TRANSACTOR]),
   
    .aximm_awid          (client_aximm_awid[w]), 
    .aximm_awaddr        (client_aximm_awaddr[w]),
    .aximm_awlen         (client_aximm_awlen[w]),
    .aximm_awsize        (client_aximm_awsize[w]),
    .aximm_awburst       (),
    .aximm_awlock        (client_aximm_awlock[w]),
    .aximm_awcache       (client_aximm_awcache[w]),
    .aximm_awqos         (client_aximm_awqos[w]),
    .aximm_awvalid       (client_aximm_awvalid[w]),
    .aximm_awready       (client_aximm_awready[w]),
                                         
                                         
    .aximm_wdata         (client_aximm_wdata[w]),
    .aximm_wstrb         (client_aximm_wstrb[w]),
    .aximm_wlast         (client_aximm_wlast[w]),
    .aximm_wvalid        (client_aximm_wvalid[w]),
    .aximm_wready        (client_aximm_wready[w]),
                                         
      
    .aximm_bid           (client_aximm_bid[w]),
    .aximm_bresp         (client_aximm_bresp[w]),
    .aximm_bvalid        (client_aximm_bvalid[w]),   
    .aximm_bready        (client_aximm_bready[w]),
                                         
                                         
  
    .aximm_arid          (client_aximm_arid[w]),
    .aximm_araddr        (client_aximm_araddr[w]),
    .aximm_arlen         (client_aximm_arlen[w]),
    .aximm_arsize        (client_aximm_arsize[w]),
    .aximm_arburst       (client_aximm_arburst[w]),
    .aximm_arlock        (client_aximm_arlock[w]),
    .aximm_arcache       (client_aximm_arcache[w]),
    .aximm_arqos         (client_aximm_arqos[w]),
    .aximm_arvalid       (client_aximm_arvalid[w]),
    .aximm_arready       (client_aximm_arready[w]),
                                         
    
    .aximm_rid           (client_aximm_rid[w]),
    .aximm_rdata         (client_aximm_rdata[w]),
    .aximm_rresp         (client_aximm_rresp[w]),
    .aximm_rlast         (client_aximm_rlast[w]),
    .aximm_rvalid        (client_aximm_rvalid[w]),
    .aximm_rready        (client_aximm_rready[w]),
    
    .fifo_data_in(dout_rx_fifo[w][0]), 
    .fifo_re_out(rd_rx_fifo[w][0]  ),
    .fifo_empty_in(empty_rx_fifo[w][0]),
                  
                  
    .fifo_data_out(din_tx_fifo  [w][0]),
    .fifo_we_out  (wr_tx_fifo   [w][0]),
    .fifo_wait_in (full_tx_fifo [w][0]),

                                         
    .aux_tx_data        (aux_tx_data [w - START_OF_AUX_TRANSACTOR] ),
    .aux_tx_en          (aux_tx_en   [w - START_OF_AUX_TRANSACTOR]        ),
    .aux_rx_data        (aux_rx_data [w -  START_OF_AUX_TRANSACTOR ]     ) ,
     /* .aux_tx_data        (aux_tx_data ),
      .aux_tx_en          (aux_tx_en          ),               
      .aux_rx_data        (aux_rx_data     ), */
    .select              (select[w -  START_OF_AUX_TRANSACTOR ] ));  


	assign rd_rx_fifo  [w][14:1] = 'b0;
    assign wr_tx_fifo  [w][14:1] = 'b0;
    assign din_tx_fifo [w][14:1] = 'b0;

   end
  end 
endgenerate


 generate if (NUM_OF_AUX_TRANSACTOR != 0) 
  begin:mmcm
   `ifdef HAPS100 
       mmcm_125Mhz_2_100Mhz_7mhz 
   `else
       mmcm_125MHz_2_100MHz
   `endif
       mmcm_125MHz_2_100MHz_inst(
          .clk_out1(aux_clk[0]),
          .clk_out2(identify_clk),
          .reset(1'b0),
          .locked(),
          .clk_in1(user_clk)

  );

  end 
  endgenerate

/*generate if (NUM_OF_AUX_TRANSACTOR != 0) 
  begin:buffer

  // IOBUFDS: Differential Input/Output Buffer
// UltraScale
// Xilinx HDL Language Template, version 2020.2
IOBUFDS IOBUFDS_inst (
 .O(aux_rx_data[0]), // 1-bit output: Buffer output
 .I(aux_tx_data[0]), // 1-bit input: Buffer input
 .IO(diff_p), // 1-bit inout: Diff_p inout (connect directly to top-level port)
 .IOB(diff_n), // 1-bit inout: Diff_n inout (connect directly to top-level port)
 .T(!aux_tx_en[0]) // 1-bit input: 3-state enable input
);
end 
endgenerate*/
// End of IOBUFDS_inst instantiation
//---------------------------------APB TRANSACTOR------------------------------------------
//-------------------------generate instantiation APB Master Xtor--------------------------
    parameter  int APB_DATA_BITS         = 5;
    parameter  int APB_ADDRESS_BITS      = 5;
    parameter  int APB_FIFO_DEPTH        = 128;
    parameter      APB_FIFO_MEM_TYPE     = "BRAM";
  `include "apb_master_wires.sv"

generate if (APB_LOOPBACK != 0)
 begin      
   assign m_pclk_0  = user_clk;
   assign m_prstn_0 = !generic_chassis_rst;
 end // :Template Transactor
endgenerate
//`endif


  genvar s;
  generate if (NUM_OF_APB_MASTER_TRANSACTOR != 0) 
  begin: APB_MASTER
  
  for (s=START_OF_APB_MASTER_TRANSACTOR; s<START_OF_APB_MASTER_TRANSACTOR+NUM_OF_APB_MASTER_TRANSACTOR; s++)
  begin
 `ifdef FGC_CDC
  assign client_clk[s] = m_pclk[s-START_OF_APB_MASTER_TRANSACTOR];
 `else
  assign client_clk[s] = user_clk;
 `endif
    apb_master_xtor #(     
                         .TRANSACTOR_TYPE(APB_MASTER_TYPE),
                         .TRANSACTOR_VERSION(APB_MASTER_TRANSACTOR_VERSION),
                         .APB_DATA_BITS(APB_DATA_BITS),   
                         .APB_ADDRESS_BITS(APB_ADDRESS_BITS),
                         .FIFO_DEPTH(APB_FIFO_DEPTH),   
                         .FIFO_MEM_TYPE(APB_FIFO_MEM_TYPE)
                         )
   apb_master_xtor_inst(
     //clks and rsts
     `ifdef FGC_CDC
     .fgc_clk 	(fgc_clk),
     `else
     .fgc_clk 	(user_clk),
     `endif	
    .fgc_rst_n         	(~generic_chassis_rst),
    //APB interface
    .p_clk		        	(m_pclk[s-START_OF_APB_MASTER_TRANSACTOR]),
    .p_rst_n		        (m_prst_n[s-START_OF_APB_MASTER_TRANSACTOR]),
    .m_psel(m_psel[s-START_OF_APB_MASTER_TRANSACTOR]),
    .m_penable(m_penable[s-START_OF_APB_MASTER_TRANSACTOR]),
    .m_pwrite(m_pwrite[s-START_OF_APB_MASTER_TRANSACTOR]),
    .m_pready(m_pready[s-START_OF_APB_MASTER_TRANSACTOR]),
    .m_paddr(m_paddr[s-START_OF_APB_MASTER_TRANSACTOR]),
    .m_pwdata(m_pwdata[s-START_OF_APB_MASTER_TRANSACTOR]),
    .m_prdata(m_prdata[s-START_OF_APB_MASTER_TRANSACTOR]),
    //FIFO out interface
    .fifo_out_data_in    (dout_rx_fifo[s][0]),
    .fifo_out_rd_en_out  (rd_rx_fifo[s][0]),
    .fifo_out_empty_in   (empty_rx_fifo[s][0]),
    //FIFO in interface
    .fifo_in_data_out   (din_tx_fifo[s][0]),
    .fifo_in_wr_en_out  (wr_tx_fifo[s][0]),
    .fifo_in_full_in    (full_tx_fifo[s][0]),
    //AXIMEM bus 
    .aximm_awvalid    (client_aximm_awvalid[s]),
    .aximm_awready    (client_aximm_awready[s]),
    .aximm_awid       (client_aximm_awid[s]),
    .aximm_awaddr     (client_aximm_awaddr[s]),
    .aximm_awlen      (client_aximm_awlen[s]),
    .aximm_awsize     (client_aximm_awsize[s]),
    .aximm_awburst    (client_aximm_awburst[s]),
    .aximm_awlock     (client_aximm_awlock[s]),
    .aximm_awcache    (client_aximm_awcache[s]),
    .aximm_awqos      (client_aximm_awqos[s]),
                    
    .aximm_wvalid     (client_aximm_wvalid[s]),
    .aximm_wready     (client_aximm_wready[s]),
    .aximm_wlast      (client_aximm_wlast[s]),
    .aximm_wdata      (client_aximm_wdata[s]),
    .aximm_wstrb      (client_aximm_wstrb[s]),
     
    .aximm_bvalid     (client_aximm_bvalid[s]),
    .aximm_bready     (client_aximm_bready[s]),
    .aximm_bid        (client_aximm_bid[s]),
    .aximm_bresp      (client_aximm_bresp[s]),
     
    .aximm_arvalid    (client_aximm_arvalid[s]),
    .aximm_arready    (client_aximm_arready[s]),
    .aximm_arid       (client_aximm_arid[s]),
    .aximm_araddr     (client_aximm_araddr[s]),
    .aximm_arlen      (client_aximm_arlen[s]),
    .aximm_arsize     (client_aximm_arsize[s]),
    .aximm_arburst    (client_aximm_arburst[s]),
    .aximm_arlock     (client_aximm_arlock[s]),
    .aximm_arcache    (client_aximm_arcache[s]),
    .aximm_arqos      (client_aximm_arqos[s]),
  
    .aximm_rvalid    (client_aximm_rvalid[s]),
    .aximm_rready    (client_aximm_rready[s]),
    .aximm_rid       (client_aximm_rid[s]),
    .aximm_rdata     (client_aximm_rdata[s]),
    .aximm_rresp     (client_aximm_rresp[s]),
    .aximm_rlast     (client_aximm_rlast[s]) 

);
    
    assign rd_rx_fifo  [s][14:1] = 'b0;
    assign wr_tx_fifo  [s][14:1] = 'b0;
    assign din_tx_fifo [s][14:1] = 'b0;

     
    end
  end 
  endgenerate
//---------------------------------END OF APB MASTER XTOR----------------------------------
//-------------------------generate instantiation APB SLAVE Xtor---------------------------


   
  `include "apb_slave_wires.sv"        
 generate if (APB_LOOPBACK != 0)
 begin
    `include "APB_lpbk.sv"
   assign s_pclk_0  = user_clk;
   assign s_prstn_0 = !generic_chassis_rst;
 end // :Template Transactor
endgenerate

  genvar t;
  generate if (NUM_OF_APB_SLAVE_TRANSACTOR != 0) 
  begin: APB_SLAVE
  
  for (t=START_OF_APB_SLAVE_TRANSACTOR; t<START_OF_APB_SLAVE_TRANSACTOR+NUM_OF_APB_SLAVE_TRANSACTOR; t++)
  begin
 `ifdef FGC_CDC
  assign client_clk[t] = s_pclk[t-START_OF_APB_SLAVE_TRANSACTOR];
 `else
  assign client_clk[t] = user_clk;
 `endif
    apb_slave_xtor #(     
                         .TRANSACTOR_TYPE(APB_SLAVE_TYPE),
                         .TRANSACTOR_VERSION(APB_SLAVE_TRANSACTOR_VERSION),
                         .APB_DATA_BITS(APB_DATA_BITS),   
                         .APB_ADDRESS_BITS(APB_ADDRESS_BITS),
                         .FIFO_DEPTH(APB_FIFO_DEPTH),   
                         .FIFO_MEM_TYPE(APB_FIFO_MEM_TYPE)
                         )
   apb_slave_xtor_inst(
     //clks and rsts
     `ifdef FGC_CDC
     .fgc_clk 	(fgc_clk),
     `else
     .fgc_clk 	(user_clk),
     `endif	
    .fgc_rst_n         	(~generic_chassis_rst),
    //APB interface
    .p_clk		        	(s_pclk[t-START_OF_APB_SLAVE_TRANSACTOR]),
    .p_rst_n		        (s_prst_n[t-START_OF_APB_SLAVE_TRANSACTOR]),
    .s_psel(s_psel[t-START_OF_APB_SLAVE_TRANSACTOR]),
    .s_penable(s_penable[t-START_OF_APB_SLAVE_TRANSACTOR]),
    .s_pwrite(s_pwrite[t-START_OF_APB_SLAVE_TRANSACTOR]),
    .s_pready(s_pready[t-START_OF_APB_SLAVE_TRANSACTOR]),
    .s_paddr(s_paddr[t-START_OF_APB_SLAVE_TRANSACTOR]),
    .s_pwdata(s_pwdata[t-START_OF_APB_SLAVE_TRANSACTOR]),
    .s_prdata(s_prdata[t-START_OF_APB_SLAVE_TRANSACTOR]),
    //FIFO out interface
    .fifo_out_data_in    (dout_rx_fifo[t][0]),
    .fifo_out_rd_en_out  (rd_rx_fifo[t][0]),
    .fifo_out_empty_in   (empty_rx_fifo[t][0]),
    //FIFO in interface
    .fifo_in_data_out   (din_tx_fifo[t][0]),
    .fifo_in_wr_en_out  (wr_tx_fifo[t][0]),
    .fifo_in_full_in    (full_tx_fifo[t][0]),
    //AXIMEM bus 
    .aximm_awvalid    (client_aximm_awvalid[t]),
    .aximm_awready    (client_aximm_awready[t]),
    .aximm_awid       (client_aximm_awid[t]),
    .aximm_awaddr     (client_aximm_awaddr[t]),
    .aximm_awlen      (client_aximm_awlen[t]),
    .aximm_awsize     (client_aximm_awsize[t]),
    .aximm_awburst    (client_aximm_awburst[t]),
    .aximm_awlock     (client_aximm_awlock[t]),
    .aximm_awcache    (client_aximm_awcache[t]),
    .aximm_awqos      (client_aximm_awqos[t]),
                    
    .aximm_wvalid     (client_aximm_wvalid[t]),
    .aximm_wready     (client_aximm_wready[t]),
    .aximm_wlast      (client_aximm_wlast[t]),
    .aximm_wdata      (client_aximm_wdata[t]),
    .aximm_wstrb      (client_aximm_wstrb[t]),
     
    .aximm_bvalid     (client_aximm_bvalid[t]),
    .aximm_bready     (client_aximm_bready[t]),
    .aximm_bid        (client_aximm_bid[t]),
    .aximm_bresp      (client_aximm_bresp[t]),
     
    .aximm_arvalid    (client_aximm_arvalid[t]),
    .aximm_arready    (client_aximm_arready[t]),
    .aximm_arid       (client_aximm_arid[t]),
    .aximm_araddr     (client_aximm_araddr[t]),
    .aximm_arlen      (client_aximm_arlen[t]),
    .aximm_arsize     (client_aximm_arsize[t]),
    .aximm_arburst    (client_aximm_arburst[t]),
    .aximm_arlock     (client_aximm_arlock[t]),
    .aximm_arcache    (client_aximm_arcache[t]),
    .aximm_arqos      (client_aximm_arqos[t]),
  
    .aximm_rvalid    (client_aximm_rvalid[t]),
    .aximm_rready    (client_aximm_rready[t]),
    .aximm_rid       (client_aximm_rid[t]),
    .aximm_rdata     (client_aximm_rdata[t]),
    .aximm_rresp     (client_aximm_rresp[t]),
    .aximm_rlast     (client_aximm_rlast[t]) 

);
    
    assign rd_rx_fifo  [t][14:1] = 'b0;
    assign wr_tx_fifo  [t][14:1] = 'b0;
    assign din_tx_fifo [t][14:1] = 'b0;

     
    end
  end 
  endgenerate
//---------------------------------END OF APB TRANSACTOR-----------------------------------
  

//---------------------------------DDR TRANSACTOR------------------------------------------
//-------------------------generate instantiation DDR Xtor--------------------------

wire [NUM_OF_DDR_BACKDOOR_TRANSACTOR -1:0]           avalon_clk;
wire [NUM_OF_DDR_BACKDOOR_TRANSACTOR -1:0]           avalon_rst_n; 
wire [NUM_OF_DDR_BACKDOOR_TRANSACTOR -1:0]           avalon_waitrequest;
wire [NUM_OF_DDR_BACKDOOR_TRANSACTOR -1:0]           avalon_read;
wire [NUM_OF_DDR_BACKDOOR_TRANSACTOR -1:0]           avalon_write;
wire [NUM_OF_DDR_BACKDOOR_TRANSACTOR -1:0]   [33:0]  avalon_address;
wire [NUM_OF_DDR_BACKDOOR_TRANSACTOR -1:0]   [511:0] avalon_readdata;
wire [NUM_OF_DDR_BACKDOOR_TRANSACTOR -1:0]   [511:0] avalon_writedata;
wire [NUM_OF_DDR_BACKDOOR_TRANSACTOR -1:0]           avalon_burstcount;
wire [NUM_OF_DDR_BACKDOOR_TRANSACTOR -1:0]   [63:0]  avalon_byteenable;
wire [NUM_OF_DDR_BACKDOOR_TRANSACTOR -1:0]           avalon_readdatavalid; 

wire [0:0]   fgt_emif_s10_hip_local_reset_req_local_reset_req;  
wire [0:0]   fgt_emif_s10_hip_local_reset_status_local_reset_done;
wire [0:0]   fgt_emif_s10_hip_pll_ref_clk_clk;                   
wire [0:0]   fgt_emif_s10_hip_pll_locked_pll_locked ;           
wire [0:0]   fgt_emif_s10_hip_oct_oct_rzqin;                   
wire [0:0]   fgt_emif_s10_hip_mem_mem_ck;                        
wire [0:0]   fgt_emif_s10_hip_mem_mem_ck_n;                     
wire [16:0]  fgt_emif_s10_hip_mem_mem_a;                        
wire [0:0]   fgt_emif_s10_hip_mem_mem_act_n ;                   
wire [1:0]   fgt_emif_s10_hip_mem_mem_ba;                        
wire [0:0]   fgt_emif_s10_hip_mem_mem_bg;                        
wire [0:0]   fgt_emif_s10_hip_mem_mem_cke;                      
wire [0:0]   fgt_emif_s10_hip_mem_mem_cs_n;                      
wire [0:0]   fgt_emif_s10_hip_mem_mem_odt;                      
wire [0:0]   fgt_emif_s10_hip_mem_mem_reset_n;                  
wire [0:0]   fgt_emif_s10_hip_mem_mem_par;                       
wire [0:0]   fgt_emif_s10_hip_mem_mem_alert_n ;                  
wire [7:0]   fgt_emif_s10_hip_mem_mem_dqs;                       
wire [7:0]   fgt_emif_s10_hip_mem_mem_dqs_n ;                    
wire [63:0]  fgt_emif_s10_hip_mem_mem_dq;                        
wire [7:0]   fgt_emif_s10_hip_mem_mem_dbi_n;                     
wire [0:0]   fgt_emif_s10_hip_status_local_cal_success;          
wire [0:0]   fgt_emif_s10_hip_status_local_cal_fail;             
wire [0:0]   fgt_emif_s10_usr_clk_bridge_out_clk_clk;            
wire [0:0]   fgt_emif_s10_usr_reset_bridge_out_reset_reset_n;    


genvar a;
  generate if (NUM_OF_DDR_BACKDOOR_TRANSACTOR != 0) 
  begin: DDR_BACKDOOR
  
  for (a=START_OF_DDR_BACKDOOR_TRANSACTOR; a<START_OF_DDR_BACKDOOR_TRANSACTOR+NUM_OF_DDR_BACKDOOR_TRANSACTOR; a++)
  begin
 `ifdef FGC_CDC
  assign client_clk[a] = avalon_clk [a-START_OF_DDR_BACKDOOR_TRANSACTOR];
 `else
  assign client_clk[a] = user_clk;
 `endif
    DDR_backdoor_top #(                           
                         )
   ddr_backdoor_inst(
     `ifdef FGC_CDC
     .fgc_clk 	(fgc_clk),
     `else
     .fgc_clk 	(user_clk),
     `endif	
    .generic_chassis_rst(generic_chassis_rst),
    .avalon_clk		      (avalon_clk [a-START_OF_DDR_BACKDOOR_TRANSACTOR]),
    .avalon_rst_n		    (avalon_rst_n [a-START_OF_DDR_BACKDOOR_TRANSACTOR]),

    .aximm_awid          (client_aximm_awid[a]), 
    .aximm_awaddr        (client_aximm_awaddr[a]),
    .aximm_awlen         (client_aximm_awlen[a]),
    .aximm_awsize        (client_aximm_awsize[a]),
    .aximm_awburst       (),
    .aximm_awlock        (client_aximm_awlock[a]),
    .aximm_awcache       (client_aximm_awcache[a]),
    .aximm_awqos         (client_aximm_awqos[a]),
    .aximm_awvalid       (client_aximm_awvalid[a]),
    .aximm_awready       (client_aximm_awready[a]),
                                         
                                         
    .aximm_wdata         (client_aximm_wdata[a]),
    .aximm_wstrb         (client_aximm_wstrb[a]),
    .aximm_wlast         (client_aximm_wlast[a]),
    .aximm_wvalid        (client_aximm_wvalid[a]),
    .aximm_wready        (client_aximm_wready[a]),
                                         
      
    .aximm_bid           (client_aximm_bid[a]),
    .aximm_bresp         (client_aximm_bresp[a]),
    .aximm_bvalid        (client_aximm_bvalid[a]),   
    .aximm_bready        (client_aximm_bready[a]),
                                         
                                         
  
    .aximm_arid          (client_aximm_arid[a]),
    .aximm_araddr        (client_aximm_araddr[a]),
    .aximm_arlen         (client_aximm_arlen[a]),
    .aximm_arsize        (client_aximm_arsize[a]),
    .aximm_arburst       (client_aximm_arburst[a]),
    .aximm_arlock        (client_aximm_arlock[a]),
    .aximm_arcache       (client_aximm_arcache[a]),
    .aximm_arqos         (client_aximm_arqos[a]),
    .aximm_arvalid       (client_aximm_arvalid[a]),
    .aximm_arready       (client_aximm_arready[a]),
                                         
    
    .aximm_rid           (client_aximm_rid[a]),
    .aximm_rdata         (client_aximm_rdata[a]),
    .aximm_rresp         (client_aximm_rresp[a]),
    .aximm_rlast         (client_aximm_rlast[a]),
    .aximm_rvalid        (client_aximm_rvalid[a]),
    .aximm_rready        (client_aximm_rready[a]),
                                         
                                          
    .avalon_waitrequest  (avalon_waitrequest[a - START_OF_DDR_BACKDOOR_TRANSACTOR] ),
    .avalon_read         (avalon_read[a - START_OF_DDR_BACKDOOR_TRANSACTOR]        ),
    .avalon_write        (avalon_write[a -  START_OF_DDR_BACKDOOR_TRANSACTOR ]     ),
    .avalon_address      (avalon_address[a - START_OF_DDR_BACKDOOR_TRANSACTOR]     ),
    .avalon_readdata     (avalon_readdata[a -START_OF_DDR_BACKDOOR_TRANSACTOR ]     ),
    .avalon_writedata    (avalon_writedata[a - START_OF_DDR_BACKDOOR_TRANSACTOR]   ),
    .avalon_burstcount   (avalon_burstcount[a -START_OF_DDR_BACKDOOR_TRANSACTOR ]  ),
    .avalon_byteenable   (avalon_byteenable[a -START_OF_DDR_BACKDOOR_TRANSACTOR ]  ),
    .avalon_readdatavalid(avalon_readdatavalid[a-START_OF_DDR_BACKDOOR_TRANSACTOR] ) 
  );              

	assign rd_rx_fifo  [a][14:0] = 'b0;
    assign wr_tx_fifo  [a][14:0] = 'b0;
    assign din_tx_fifo [a][14:0] = 'b0;

   end
  end 
endgenerate

generate
if (NUM_OF_DDR_BACKDOOR_TRANSACTOR != 0) 
begin : EMIF

fgt_emif_s10_16G u0 (
		.emif_s10_emif_usr_clock_bridge_out_clk_clk       (),       //  output,    width = 1,   emif_s10_emif_usr_clock_bridge_out_clk.clk
		.emif_s10_emif_usr_reset_bridge_out_reset_reset_n (), //  output,    width = 1, emif_s10_emif_usr_reset_bridge_out_reset.reset_n
		.emif_s10_mm_bridge_s0_waitrequest                (avalon_waitrequest   [0]),                //  output,    width = 1,                    emif_s10_mm_bridge_s0.waitrequest
		.emif_s10_mm_bridge_s0_readdata                   (avalon_readdata      [0]),                   //  output,  width = 512,                                         .readdata
		.emif_s10_mm_bridge_s0_readdatavalid              (avalon_readdatavalid [0]),              //  output,    width = 1,                                         .readdatavalid
		.emif_s10_mm_bridge_s0_burstcount                 (avalon_burstcount    [0]),                 //   input,    width = 1,                                         .burstcount
		.emif_s10_mm_bridge_s0_writedata                  (avalon_writedata     [0]),                  //   input,  width = 512,                                         .writedata
		.emif_s10_mm_bridge_s0_address                    (avalon_address       [0]),                    //   input,   width = 34,                                         .address
		.emif_s10_mm_bridge_s0_write                      (avalon_write         [0]),                      //   input,    width = 1,                                         .write
		.emif_s10_mm_bridge_s0_read                       (avalon_read          [0]),                       //   input,    width = 1,                                         .read
		.emif_s10_mm_bridge_s0_byteenable                 (avalon_byteenable    [0]),                 //   input,   width = 64,                                         .byteenable
		.emif_s10_mm_bridge_s0_debugaccess                (1'b0),                //   input,    width = 1,                                         .debugaccess
		.emif_s10_mm_clock_bridge_in_clk_clk              (avalon_clk [0]),              //   input,    width = 1,          emif_s10_mm_clock_bridge_in_clk.clk
		.emif_s10_mm_reset_bridge_in_reset_reset_n        (avalon_rst_n[0]),        //   input,    width = 1,        emif_s10_mm_reset_bridge_in_reset.reset_n
		.fgt_emif_s10_16g_0_mem_mem_ck                    (fgt_emif_s10_hip_mem_mem_ck     ),                    //  output,    width = 1,                   fgt_emif_s10_16g_0_mem.mem_ck
		.fgt_emif_s10_16g_0_mem_mem_ck_n                  (fgt_emif_s10_hip_mem_mem_ck_n  ),                  //  output,    width = 1,                                         .mem_ck_n
		.fgt_emif_s10_16g_0_mem_mem_a                     (fgt_emif_s10_hip_mem_mem_a      ),                     //  output,   width = 17,                                         .mem_a
		.fgt_emif_s10_16g_0_mem_mem_act_n                 (fgt_emif_s10_hip_mem_mem_act_n  ),                 //  output,    width = 1,                                         .mem_act_n
		.fgt_emif_s10_16g_0_mem_mem_ba                    (fgt_emif_s10_hip_mem_mem_ba     ),                    //  output,    width = 2,                                         .mem_ba
		.fgt_emif_s10_16g_0_mem_mem_bg                    (fgt_emif_s10_hip_mem_mem_bg     ),                    //  output,    width = 2,                                         .mem_bg
		.fgt_emif_s10_16g_0_mem_mem_cke                   (fgt_emif_s10_hip_mem_mem_cke    ),                   //  output,    width = 2,                                         .mem_cke
		.fgt_emif_s10_16g_0_mem_mem_cs_n                  (fgt_emif_s10_hip_mem_mem_cs_n   ),                  //  output,    width = 2,                                         .mem_cs_n
		.fgt_emif_s10_16g_0_mem_mem_odt                   (fgt_emif_s10_hip_mem_mem_odt    ),                   //  output,    width = 2,                                         .mem_odt
		.fgt_emif_s10_16g_0_mem_mem_reset_n               (fgt_emif_s10_hip_mem_mem_reset_n),               //  output,    width = 1,                                         .mem_reset_n
		.fgt_emif_s10_16g_0_mem_mem_par                   (fgt_emif_s10_hip_mem_mem_par    ),                   //  output,    width = 1,                                         .mem_par
		.fgt_emif_s10_16g_0_mem_mem_alert_n               (fgt_emif_s10_hip_mem_mem_alert_n),               //   input,    width = 1,                                         .mem_alert_n
		.fgt_emif_s10_16g_0_mem_mem_dqs                   (fgt_emif_s10_hip_mem_mem_dqs    ),                   //   inout,    width = 8,                                         .mem_dqs
		.fgt_emif_s10_16g_0_mem_mem_dqs_n                 (fgt_emif_s10_hip_mem_mem_dqs_n  ),                 //   inout,    width = 8,                                         .mem_dqs_n
		.fgt_emif_s10_16g_0_mem_mem_dq                    (fgt_emif_s10_hip_mem_mem_dq     ),                    //   inout,   width = 64,                                         .mem_dq
		.fgt_emif_s10_16g_0_mem_mem_dbi_n                 (fgt_emif_s10_hip_mem_mem_dbi_n  ),                 //   inout,    width = 8,                                         .mem_dbi_n
		.fgt_emif_s10_16g_0_oct_oct_rzqin                 (fgt_emif_s10_hip_oct_oct_rzqin),                 //   input,    width = 1,                   fgt_emif_s10_16g_0_oct.oct_rzqin
		.fgt_emif_s10_16g_0_pll_ref_clk_clk               (fgt_emif_s10_hip_pll_ref_clk_clk),               //   input,    width = 1,           fgt_emif_s10_16g_0_pll_ref_clk.clk
		.fgt_emif_s10_16g_0_status_local_cal_success      (fgt_emif_s10_hip_status_local_cal_success),      //  output,    width = 1,                fgt_emif_s10_16g_0_status.local_cal_success
		.fgt_emif_s10_16g_0_status_local_cal_fail         (fgt_emif_s10_hip_status_local_cal_fail),         //  output,    width = 1,                                         .local_cal_fail
		.local_reset_req                                  (~generic_chassis_rst ),                                  //   input,    width = 1,                          local_reset_req.local_reset_req
		.local_reset_done                                 (fgt_emif_s10_hip_local_reset_status_local_reset_done)                                  //  output,    width = 1,                       local_reset_status.local_reset_done
	);





end 
endgenerate


// CFI transactor
//----------------------------------------------------------------------------

`include "CFI_wires.sv"

generate if (CFI_LOOPBACK != 0)
 begin
    `include "CFI_lbpk.sv"
    assign 		cfi_agent_clock_0 		   	= user_clk; 
    assign 		cfi_agent_rst_n_0 				= !generic_chassis_rst;
    assign 		cfi_agent_clock_1 		   	= user_clk; 
    assign 		cfi_agent_rst_n_1 				= !generic_chassis_rst; 
 end
 endgenerate


/*generate if (CFI_LOOPBACK != 0)
 begin
  assign cfi_agent_clock_0  = user_clk;
  assign cfi_agent_rst_n_0  = ~generic_chassis_rst;
 end // :Template Transactor
endgenerate
*/

  //generate instantiation for CFI Fabric
  genvar m;
  generate if (NUM_OF_CFI_TRANSACTOR != 0) 
  begin: CFI_FABRIC
  
  for (m=START_OF_CFI_TRANSACTOR; m<START_OF_CFI_TRANSACTOR+NUM_OF_CFI_TRANSACTOR; m++)
    begin


   `ifdef FGC_CDC
    assign client_clk[m] = cfi_agent_clock_0; 
   `else 
    assign client_clk[m] = user_clk;
  `endif
        
cfi_fabric_xtor   # (                            
                         .TRANSACTOR_TYPE		(CFI_TYPE),
                         .COUNT_MAX				  (CFI_COUNT_MAX),
                         .TRANSACTOR_VERSION(CFI_TRANSACTOR_VERSION),
                         .EARLY_DELAY       (CFI_EARLY_DELAY), 
                         .CFI_AGENT_MODE    (CFI_AGENT_MODE[m-START_OF_CFI_TRANSACTOR]),
                         .CFI_LOOPBACK      (CFI_LOOPBACK)
                         )
  cfi_fabric_xtor_inst(
   `ifdef FGC_CDC
     .user_clk 	(fgc_clk),
   `else
     .user_clk 	(user_clk),
   `endif						
    .user_rst_n         	(~generic_chassis_rst),
    .cfi_clk						  (cfi_clk[m-START_OF_CFI_TRANSACTOR]),
    .cfi_rst_n				    (cfi_rst_n[m-START_OF_CFI_TRANSACTOR]),

    .rx_req_is_valid           (rx_req_is_valid[m-START_OF_CFI_TRANSACTOR]),
    .rx_req_early_valid        (rx_req_early_valid[m-START_OF_CFI_TRANSACTOR]),    
    .rx_req_protocol_id        (rx_req_protocol_id[m-START_OF_CFI_TRANSACTOR]),
    .rx_req_vc_id              (rx_req_vc_id[m-START_OF_CFI_TRANSACTOR]),
    .rx_req_header             (rx_req_header[m-START_OF_CFI_TRANSACTOR]),
    .rx_req_dstid_or_crd       (rx_req_dstid_or_crd[m-START_OF_CFI_TRANSACTOR]),
    .rx_req_rctrl              (rx_req_rctrl[m-START_OF_CFI_TRANSACTOR]),
    .rx_req_null_packet        (rx_req_null_packet[m-START_OF_CFI_TRANSACTOR]),
    .rx_req_shared_credit      (rx_req_shared_credit[m-START_OF_CFI_TRANSACTOR]),
    .rx_req_trace_packet       (rx_req_trace_packet[m-START_OF_CFI_TRANSACTOR]),
    .rx_req_txblock_crd_flow   (rx_req_txblock_crd_flow[m-START_OF_CFI_TRANSACTOR]),
    .rx_req_rxcrd_valid        (rx_req_rxcrd_valid[m-START_OF_CFI_TRANSACTOR]),
    .rx_req_rxcrd_protocol_id  (rx_req_rxcrd_protocol_id[m-START_OF_CFI_TRANSACTOR]),
    .rx_req_rxcrd_vc_id        (rx_req_rxcrd_vc_id[m-START_OF_CFI_TRANSACTOR]), 
    .rx_req_rxcrd_null_credit  (rx_req_rxcrd_null_credit[m-START_OF_CFI_TRANSACTOR]),
    .rx_req_rxcrd_shared       (rx_req_rxcrd_shared[m-START_OF_CFI_TRANSACTOR]),
    .rx_req_block              (rx_req_block[m-START_OF_CFI_TRANSACTOR]),

    .rx_rsp_is_valid           (rx_rsp_is_valid[m-START_OF_CFI_TRANSACTOR]),
    .rx_rsp_early_valid        (rx_rsp_early_valid[m-START_OF_CFI_TRANSACTOR]),
    .rx_rsp_null_packet        (rx_rsp_null_packet[m-START_OF_CFI_TRANSACTOR]),
    .rx_rsp_protocol_id        (rx_rsp_protocol_id[m-START_OF_CFI_TRANSACTOR]),
    .rx_rsp_vc_id              (rx_rsp_vc_id[m-START_OF_CFI_TRANSACTOR]),
    .rx_rsp_header             (rx_rsp_header[m-START_OF_CFI_TRANSACTOR]),
    .rx_rsp_dstid_or_crd       (rx_rsp_dstid_or_crd[m-START_OF_CFI_TRANSACTOR]),
    .rx_rsp_rctrl              (rx_rsp_rctrl[m-START_OF_CFI_TRANSACTOR]),
    .rx_rsp_shared_credit      (rx_rsp_shared_credit[m-START_OF_CFI_TRANSACTOR]), 
    .rx_rsp_trace_packet       (rx_rsp_trace_packet[m-START_OF_CFI_TRANSACTOR]), 
    .rx_rsp_txblock_crd_flow   (rx_rsp_txblock_crd_flow[m-START_OF_CFI_TRANSACTOR]),
    .rx_rsp_block              (rx_rsp_block[m-START_OF_CFI_TRANSACTOR]), 
    .rx_rsp_rxcrd_null_credit  (rx_rsp_rxcrd_null_credit[m-START_OF_CFI_TRANSACTOR]),
    .rx_rsp_rxcrd_shared       (rx_rsp_rxcrd_shared[m-START_OF_CFI_TRANSACTOR]), 
    .rx_rsp_rxcrd_valid        (rx_rsp_rxcrd_valid[m-START_OF_CFI_TRANSACTOR]),
    .rx_rsp_rxcrd_protocol_id  (rx_rsp_rxcrd_protocol_id[m-START_OF_CFI_TRANSACTOR]),
    .rx_rsp_rxcrd_vc_id        (rx_rsp_rxcrd_vc_id[m-START_OF_CFI_TRANSACTOR]),
 
    .rx_data_is_valid          (rx_data_is_valid[m-START_OF_CFI_TRANSACTOR]),
    .rx_data_early_valid       (rx_data_early_valid[m-START_OF_CFI_TRANSACTOR]),
    .rx_data_null_packet       (rx_data_null_packet[m-START_OF_CFI_TRANSACTOR]),
    .rx_data_protocol_id       (rx_data_protocol_id[m-START_OF_CFI_TRANSACTOR]),
    .rx_data_vc_id             (rx_data_vc_id[m-START_OF_CFI_TRANSACTOR]),
    .rx_data_header            (rx_data_header[m-START_OF_CFI_TRANSACTOR]),
    .rx_data_header_parity     (rx_data_header_parity[m-START_OF_CFI_TRANSACTOR]),
    .rx_data_eop               (rx_data_eop[m-START_OF_CFI_TRANSACTOR]),
    .rx_data_payload           (rx_data_payload[m-START_OF_CFI_TRANSACTOR]),
    .rx_data_payload_par       (rx_data_payload_par[m-START_OF_CFI_TRANSACTOR]),
    .rx_data_poison            (rx_data_poison[m-START_OF_CFI_TRANSACTOR]),    
    .rx_data_shared_credit     (rx_data_shared_credit[m-START_OF_CFI_TRANSACTOR]), 
    .rx_data_trace_packet      (rx_data_trace_packet[m-START_OF_CFI_TRANSACTOR]), 
    .rx_data_txblock_crd_flow  (rx_data_txblock_crd_flow[m-START_OF_CFI_TRANSACTOR]),
    .rx_data_rxcrd_valid       (rx_data_rxcrd_valid[m-START_OF_CFI_TRANSACTOR]),
    .rx_data_dstid_or_crd      (rx_data_dstid_or_crd[m-START_OF_CFI_TRANSACTOR]),
    .rx_data_rctrl             (rx_data_rctrl[m-START_OF_CFI_TRANSACTOR]),
    .rx_data_rxcrd_protocol_id (rx_data_rxcrd_protocol_id[m-START_OF_CFI_TRANSACTOR]),
    .rx_data_rxcrd_vc_id       (rx_data_rxcrd_vc_id[m-START_OF_CFI_TRANSACTOR]),
    .rx_data_block             (rx_data_block[m-START_OF_CFI_TRANSACTOR]), 
    .rx_data_rxcrd_null_credit (rx_data_rxcrd_null_credit[m-START_OF_CFI_TRANSACTOR]),
    .rx_data_rxcrd_shared      (rx_data_rxcrd_shared[m-START_OF_CFI_TRANSACTOR]), 
                                                                 
    .tx_req_is_valid           (tx_req_is_valid[m-START_OF_CFI_TRANSACTOR]),
    .tx_req_early_valid        (tx_req_early_valid[m-START_OF_CFI_TRANSACTOR]),
    .tx_req_protocol_id        (tx_req_protocol_id[m-START_OF_CFI_TRANSACTOR]),
    .tx_req_vc_id              (tx_req_vc_id[m-START_OF_CFI_TRANSACTOR]),
    .tx_req_header             (tx_req_header[m-START_OF_CFI_TRANSACTOR]),
    .tx_req_dstid              (tx_req_dstid[m-START_OF_CFI_TRANSACTOR]),
    .tx_req_rctrl              (tx_req_rctrl[m-START_OF_CFI_TRANSACTOR]),
    .tx_req_null_packet        (tx_req_null_packet[m-START_OF_CFI_TRANSACTOR]),   
    .tx_req_shared_credit      (tx_req_shared_credit[m-START_OF_CFI_TRANSACTOR]), 
    .tx_req_trace_packet       (tx_req_trace_packet[m-START_OF_CFI_TRANSACTOR]),
    .tx_req_txblock_crd_flow   (tx_req_txblock_crd_flow[m-START_OF_CFI_TRANSACTOR]),
    .tx_req_block              (tx_req_block[m-START_OF_CFI_TRANSACTOR]), 
    .tx_req_rxcrd_null_credit  (tx_req_rxcrd_null_credit[m-START_OF_CFI_TRANSACTOR]),
    .tx_req_rxcrd_shared       (tx_req_rxcrd_shared[m-START_OF_CFI_TRANSACTOR]), 
    .tx_req_rxcrd_valid        (tx_req_rxcrd_valid[m-START_OF_CFI_TRANSACTOR]),
    .tx_req_rxcrd_protocol_id  (tx_req_rxcrd_protocol_id[m-START_OF_CFI_TRANSACTOR]),
    .tx_req_rxcrd_vc_id        (tx_req_rxcrd_vc_id[m-START_OF_CFI_TRANSACTOR]),
                                                             
    .tx_rsp_is_valid           (tx_rsp_is_valid[m-START_OF_CFI_TRANSACTOR]),
    .tx_rsp_early_valid        (tx_rsp_early_valid[m-START_OF_CFI_TRANSACTOR]),
    .tx_rsp_null_packet        (tx_rsp_null_packet[m-START_OF_CFI_TRANSACTOR]),
    .tx_rsp_shared_credit      (tx_rsp_shared_credit[m-START_OF_CFI_TRANSACTOR]),
    .tx_rsp_trace_packet       (tx_rsp_trace_packet[m-START_OF_CFI_TRANSACTOR]),
    .tx_rsp_txblock_crd_flow   (tx_rsp_txblock_crd_flow[m-START_OF_CFI_TRANSACTOR]),
    .tx_rsp_protocol_id        (tx_rsp_protocol_id[m-START_OF_CFI_TRANSACTOR]),
    .tx_rsp_vc_id              (tx_rsp_vc_id[m-START_OF_CFI_TRANSACTOR]),
    .tx_rsp_header             (tx_rsp_header[m-START_OF_CFI_TRANSACTOR]),
    .tx_rsp_dstid              (tx_rsp_dstid[m-START_OF_CFI_TRANSACTOR]),
    .tx_rsp_rctrl              (tx_rsp_rctrl[m-START_OF_CFI_TRANSACTOR]),
    .tx_rsp_block              (tx_rsp_block[m-START_OF_CFI_TRANSACTOR]), 
    .tx_rsp_rxcrd_null_credit  (tx_rsp_rxcrd_null_credit[m-START_OF_CFI_TRANSACTOR]),
    .tx_rsp_rxcrd_shared       (tx_rsp_rxcrd_shared[m-START_OF_CFI_TRANSACTOR]), 
    .tx_rsp_rxcrd_valid        (tx_rsp_rxcrd_valid[m-START_OF_CFI_TRANSACTOR]),
    .tx_rsp_rxcrd_protocol_id  (tx_rsp_rxcrd_protocol_id[m-START_OF_CFI_TRANSACTOR]),
    .tx_rsp_rxcrd_vc_id        (tx_rsp_rxcrd_vc_id[m-START_OF_CFI_TRANSACTOR]),
                                                             
    .tx_data_is_valid          (tx_data_is_valid[m-START_OF_CFI_TRANSACTOR]),
    .tx_data_early_valid       (tx_data_early_valid[m-START_OF_CFI_TRANSACTOR]), 
    .tx_data_null_packet       (tx_data_null_packet[m-START_OF_CFI_TRANSACTOR]), 
    .tx_data_shared_credit     (tx_data_shared_credit[m-START_OF_CFI_TRANSACTOR]), 
    .tx_data_trace_packet      (tx_data_trace_packet[m-START_OF_CFI_TRANSACTOR]), 
    .tx_data_protocol_id       (tx_data_protocol_id[m-START_OF_CFI_TRANSACTOR]),
    .tx_data_vc_id             (tx_data_vc_id[m-START_OF_CFI_TRANSACTOR]),
    .tx_data_header            (tx_data_header[m-START_OF_CFI_TRANSACTOR]),
    .tx_data_header_parity     (tx_data_header_parity[m-START_OF_CFI_TRANSACTOR]),
    .tx_data_eop               (tx_data_eop[m-START_OF_CFI_TRANSACTOR]),
    .tx_data_payload           (tx_data_payload[m-START_OF_CFI_TRANSACTOR]),
    .tx_data_payload_par       (tx_data_payload_par[m-START_OF_CFI_TRANSACTOR]),
    .tx_data_poison            (tx_data_poison[m-START_OF_CFI_TRANSACTOR]),    
    .tx_data_dstid             (tx_data_dstid[m-START_OF_CFI_TRANSACTOR]),
    .tx_data_rctrl             (tx_data_rctrl[m-START_OF_CFI_TRANSACTOR]),
    .tx_data_txblock_crd_flow  (tx_data_txblock_crd_flow[m-START_OF_CFI_TRANSACTOR]),
    .tx_data_block             (tx_data_block[m-START_OF_CFI_TRANSACTOR]), 
    .tx_data_rxcrd_null_credit (tx_data_rxcrd_null_credit[m-START_OF_CFI_TRANSACTOR]),
    .tx_data_rxcrd_shared      (tx_data_rxcrd_shared[m-START_OF_CFI_TRANSACTOR]), 
    .tx_data_rxcrd_valid       (tx_data_rxcrd_valid[m-START_OF_CFI_TRANSACTOR]),
    .tx_data_rxcrd_protocol_id (tx_data_rxcrd_protocol_id[m-START_OF_CFI_TRANSACTOR]),
    .tx_data_rxcrd_vc_id       (tx_data_rxcrd_vc_id[m-START_OF_CFI_TRANSACTOR]),

    .cfi_link_mode             (),
    .cfi_peer_clkreq           (),
    .cfi_peer_clkack           (1'b0),
    .cfi_rsp_peer_clkreq       (),
    .cfi_rsp_peer_clkack       (1'b0),
    .rx_con_req                (rx_con_req[m-START_OF_CFI_TRANSACTOR]),
    .rx_con_ack                (rx_con_ack[m-START_OF_CFI_TRANSACTOR]),
    .rx_ipc_read_high          (1'b0),
    .rx_ipc_write_high         (1'b0),
    .tx_con_req                (tx_con_req[m-START_OF_CFI_TRANSACTOR]),
    .tx_con_ack                (tx_con_ack[m-START_OF_CFI_TRANSACTOR]),
    .tx_ipc_read_high          (),
    .tx_ipc_write_high         (),
        
    .tx_req_data_in   (dout_rx_fifo [m][0]),
    .tx_req_rd_en_out (rd_rx_fifo   [m][0]),
    .tx_req_empty_in  (empty_rx_fifo[m][0]), 

    .tx_rsp_data_in   (dout_rx_fifo [m][1]),
    .tx_rsp_rd_en_out (rd_rx_fifo   [m][1]),
    .tx_rsp_empty_in  (empty_rx_fifo[m][1]), 

    .tx_data_hdr_in   (dout_rx_fifo [m][2]),
    .tx_data_hdr_rd_en_out(rd_rx_fifo   [m][2]),
    .tx_data_hdr_empty_in(empty_rx_fifo[m][2]), 

    .tx_data_data_in   (dout_rx_fifo [m][3]),
    .tx_data_data_rd_en_out(rd_rx_fifo   [m][3]),
    .tx_data_data_empty_in(empty_rx_fifo[m][3]), 

    .rx_req_data_out  (din_tx_fifo  [m][0]),
    .rx_req_we_en_out (wr_tx_fifo   [m][0]),
    .rx_req_wait_in   (full_tx_fifo [m][0]),

    .rx_rsp_data_out  (din_tx_fifo  [m][1]),
    .rx_rsp_we_en_out(wr_tx_fifo   [m][1]),
    .rx_rsp_wait_in   (full_tx_fifo [m][1]),

    .rx_data_hdr_out  (din_tx_fifo  [m][2]),
    .rx_data_hdr_we_en_out(wr_tx_fifo [m][2]),
    .rx_data_hdr_wait_in(full_tx_fifo [m][2]),

    .rx_data_data_out  (din_tx_fifo  [m][3]),
    .rx_data_data_we_en_out(wr_tx_fifo [m][3]),
    .rx_data_data_wait_in(full_tx_fifo [m][3]),

      
  .aximm_awvalid    (client_aximm_awvalid[m]),
  .aximm_awready    (client_aximm_awready[m]),
  .aximm_awid       (client_aximm_awid[m]),
  .aximm_awaddr     (client_aximm_awaddr[m]),
  .aximm_awlen      (client_aximm_awlen[m]),
  .aximm_awsize     (client_aximm_awsize[m]),
  .aximm_awburst    (client_aximm_awburst[m]),
  .aximm_awlock     (client_aximm_awlock[m]),
  .aximm_awcache    (client_aximm_awcache[m]),
  .aximm_awqos      (client_aximm_awqos[m]),
                    
  .aximm_wvalid     (client_aximm_wvalid[m]),
  .aximm_wready     (client_aximm_wready[m]),
  .aximm_wlast      (client_aximm_wlast[m]),
  .aximm_wdata      (client_aximm_wdata[m]),
  .aximm_wstrb      (client_aximm_wstrb[m]),
     
  .aximm_bvalid     (client_aximm_bvalid[m]),
  .aximm_bready     (client_aximm_bready[m]),
  .aximm_bid        (client_aximm_bid[m]),
  .aximm_bresp      (client_aximm_bresp[m]),
     
  .aximm_arvalid    (client_aximm_arvalid[m]),
  .aximm_arready    (client_aximm_arready[m]),
  .aximm_arid       (client_aximm_arid[m]),
  .aximm_araddr     (client_aximm_araddr[m]),
  .aximm_arlen      (client_aximm_arlen[m]),
  .aximm_arsize     (client_aximm_arsize[m]),
  .aximm_arburst    (client_aximm_arburst[m]),
  .aximm_arlock     (client_aximm_arlock[m]),
  .aximm_arcache    (client_aximm_arcache[m]),
  .aximm_arqos      (client_aximm_arqos[m]),
  
  .aximm_rvalid    (client_aximm_rvalid[m]),
  .aximm_rready    (client_aximm_rready[m]),
  .aximm_rid       (client_aximm_rid[m]),
  .aximm_rdata     (client_aximm_rdata[m]),
  .aximm_rresp     (client_aximm_rresp[m]),
  .aximm_rlast     (client_aximm_rlast[m])

);
       
    assign rd_rx_fifo  [m][14:4] = 'b0;
		assign wr_tx_fifo  [m][14:4] = 'b0;
		assign din_tx_fifo [m][14:4] = 'b0;
     
    end
  end // :CFI_FABRIC
  endgenerate
  // end of CFI FABRIC


// UFI 2.0 FABRIC transactor
//----------------------------------------------------------------------------

`include "UFI_2_wires.sv"

generate if (UFI_2_LOOPBACK != 0)
 begin
  `include "UFI_2_lpbk.sv"
  assign ufi_2_agent_clock_0  = user_clk;
  assign ufi_2_agent_rst_n_0  = ~generic_chassis_rst;
  assign ufi_2_agent_clock_1  = user_clk;
  assign ufi_2_agent_rst_n_1  = ~generic_chassis_rst;
  assign ufi_2_agent_clock_2  = user_clk;
  assign ufi_2_agent_rst_n_2  = ~generic_chassis_rst;
  assign ufi_2_agent_clock_3  = user_clk;
  assign ufi_2_agent_rst_n_3  = ~generic_chassis_rst;
 end
endgenerate


  //generate instantiation for UFI_2 Fabric
  genvar b;
  generate if (NUM_OF_UFI_2_FABRIC != 0) 
  begin: UFI_2_FABRIC
  
  for (b=START_OF_UFI_2_FABRIC; b<START_OF_UFI_2_FABRIC+NUM_OF_UFI_2_FABRIC; b++)
    begin


   `ifdef FGC_CDC
    assign client_clk[b] = ufi_2_agent_clock_0; 
   `else 
    assign client_clk[b] = user_clk;
  `endif
        
ufi_2_fabric_top   # (                            
                         .TRANSACTOR_TYPE		(UFI_2_FABRIC_TYPE),
                         .COUNT_MAX				(UFI_2_COUNT_MAX),
                         .NUM_OF_CREDIT_CH		(UFI_2_NUM_OF_CREDIT_CH),
                         .CREDIT_ID				(UFI_2_CREDIT_ID),
                        // .DEVICE_NUMBER			(cfg_device_number),
                         //.FUNCTION_NUMBER		(cfg_function_number),
                        // .BUS_NUMBER			(cfg_bus_number),
                         .TRANSACTOR_VERSION	(UFI_2_FABRIC_VERSION),
                         .LOOP_BACK				(UFI_2_LOOPBACK)
                         )
   ufi_2_fabric_top_inst(
   `ifdef FGC_CDC
     .fgc_clk 	(fgc_clk),
   `else
    .fgc_clk 	(user_clk),
  `endif						
    .generic_chassis_rst 			(generic_chassis_rst),
    .ufi_clk				  		(ufi_2_fabric_clk[b-START_OF_UFI_2_FABRIC]),
    .rstn					    	(ufi_2_fabric_rstn[b-START_OF_UFI_2_FABRIC]),

    .ufi_a2f_req_is_valid           (ufi_2_a2f_req_is_valid[b-START_OF_UFI_2_FABRIC]), 
    .ufi_a2f_req_early_valid        (ufi_2_a2f_req_early_valid[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_req_block              (ufi_2_a2f_req_block[b-START_OF_UFI_2_FABRIC]),       
    .ufi_a2f_req_protocol_id        (ufi_2_a2f_req_protocol_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_req_vc_id              (ufi_2_a2f_req_vc_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_req_header             (ufi_2_a2f_req_header[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_req_rxcrd              (ufi_2_a2f_req_rxcrd[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_req_rxcrd_protocol_id  (ufi_2_a2f_req_rxcrd_protocol_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_req_rxcrd_vc_id        (ufi_2_a2f_req_rxcrd_vc_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_req_txflow_crd_block   (ufi_2_a2f_req_txflow_crd_block[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_req_shared_credit      (ufi_2_a2f_req_shared_credit[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_req_rxcrd_shared       (ufi_2_a2f_req_rxcrd_shared[b-START_OF_UFI_2_FABRIC]),

    .ufi_a2f_rsp_is_valid           (ufi_2_a2f_rsp_is_valid[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_rsp_early_valid        (ufi_2_a2f_rsp_early_valid[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_rsp_block              (ufi_2_a2f_rsp_block[b-START_OF_UFI_2_FABRIC]),       
    .ufi_a2f_rsp_protocol_id        (ufi_2_a2f_rsp_protocol_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_rsp_vc_id              (ufi_2_a2f_rsp_vc_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_rsp_header             (ufi_2_a2f_rsp_header[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_rsp_rxcrd              (ufi_2_a2f_rsp_rxcrd[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_rsp_rxcrd_protocol_id  (ufi_2_a2f_rsp_rxcrd_protocol_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_rsp_rxcrd_vc_id        (ufi_2_a2f_rsp_rxcrd_vc_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_rsp_txflow_crd_block   (ufi_2_a2f_rsp_txflow_crd_block[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_rsp_shared_credit      (ufi_2_a2f_rsp_shared_credit[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_rsp_rxcrd_shared       (ufi_2_a2f_rsp_rxcrd_shared[b-START_OF_UFI_2_FABRIC]),
 
    .ufi_a2f_data_is_valid          (ufi_2_a2f_data_is_valid[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_data_early_valid       (ufi_2_a2f_data_early_valid[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_data_block             (ufi_2_a2f_data_block[b-START_OF_UFI_2_FABRIC]),       
    .ufi_a2f_data_protocol_id       (ufi_2_a2f_data_protocol_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_data_vc_id             (ufi_2_a2f_data_vc_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_data_header            (ufi_2_a2f_data_header[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_data_eop               (ufi_2_a2f_data_eop[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_data_payload           (ufi_2_a2f_data_payload[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_data_rxcrd             (ufi_2_a2f_data_rxcrd[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_data_rxcrd_protocol_id (ufi_2_a2f_data_rxcrd_protocol_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_data_rxcrd_vc_id       (ufi_2_a2f_data_rxcrd_vc_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_data_txflow_crd_block  (ufi_2_a2f_data_txflow_crd_block[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_data_shared_credit     (ufi_2_a2f_data_shared_credit[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_data_rxcrd_shared      (ufi_2_a2f_data_rxcrd_shared[b-START_OF_UFI_2_FABRIC]),
                                                                     
    .ufi_f2a_req_is_valid           (ufi_2_f2a_req_is_valid[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_req_early_valid        (ufi_2_f2a_req_early_valid[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_req_block              (ufi_2_f2a_req_block[b-START_OF_UFI_2_FABRIC]),    
    .ufi_f2a_req_protocol_id        (ufi_2_f2a_req_protocol_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_req_vc_id              (ufi_2_f2a_req_vc_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_req_header             (ufi_2_f2a_req_header[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_req_rxcrd              (ufi_2_f2a_req_rxcrd[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_req_rxcrd_protocol_id  (ufi_2_f2a_req_rxcrd_protocol_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_req_rxcrd_vc_id        (ufi_2_f2a_req_rxcrd_vc_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_req_txflow_crd_block   (ufi_2_f2a_req_txflow_crd_block[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_req_shared_credit      (ufi_2_f2a_req_shared_credit[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_req_rxcrd_shared       (ufi_2_f2a_req_rxcrd_shared[b-START_OF_UFI_2_FABRIC]),
                                                                     
    .ufi_f2a_rsp_is_valid           (ufi_2_f2a_rsp_is_valid[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_rsp_early_valid        (ufi_2_f2a_rsp_early_valid[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_rsp_block              (ufi_2_f2a_rsp_block[b-START_OF_UFI_2_FABRIC]),        
    .ufi_f2a_rsp_protocol_id        (ufi_2_f2a_rsp_protocol_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_rsp_vc_id              (ufi_2_f2a_rsp_vc_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_rsp_header             (ufi_2_f2a_rsp_header[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_rsp_rxcrd              (ufi_2_f2a_rsp_rxcrd[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_rsp_rxcrd_protocol_id  (ufi_2_f2a_rsp_rxcrd_protocol_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_rsp_rxcrd_vc_id        (ufi_2_f2a_rsp_rxcrd_vc_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_rsp_txflow_crd_block   (ufi_2_f2a_rsp_txflow_crd_block[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_rsp_shared_credit      (ufi_2_f2a_rsp_shared_credit[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_rsp_rxcrd_shared       (ufi_2_f2a_rsp_rxcrd_shared[b-START_OF_UFI_2_FABRIC]),

    .ufi_f2a_data_is_valid          (ufi_2_f2a_data_is_valid[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_data_early_valid       (ufi_2_f2a_data_early_valid[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_data_block             (ufi_2_f2a_data_block[b-START_OF_UFI_2_FABRIC]),        
    .ufi_f2a_data_protocol_id       (ufi_2_f2a_data_protocol_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_data_vc_id             (ufi_2_f2a_data_vc_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_data_header            (ufi_2_f2a_data_header[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_data_eop               (ufi_2_f2a_data_eop[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_data_payload           (ufi_2_f2a_data_payload[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_data_rxcrd             (ufi_2_f2a_data_rxcrd[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_data_rxcrd_protocol_id (ufi_2_f2a_data_rxcrd_protocol_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_data_rxcrd_vc_id       (ufi_2_f2a_data_rxcrd_vc_id[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_data_txflow_crd_block  (ufi_2_f2a_data_txflow_crd_block[b-START_OF_UFI_2_FABRIC]),    
    .ufi_f2a_data_shared_credit     (ufi_2_f2a_data_shared_credit[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_data_rxcrd_shared      (ufi_2_f2a_data_rxcrd_shared[b-START_OF_UFI_2_FABRIC]),

    .ufi_a2f_txcon_req              (ufi_2_a2f_txcon_req[b-START_OF_UFI_2_FABRIC]),                    
    .ufi_a2f_rx_ack                 (ufi_2_a2f_rx_ack[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_rx_empty               (ufi_2_a2f_rx_empty[b-START_OF_UFI_2_FABRIC]),
    .ufi_a2f_rxdiscon_nack          (ufi_2_a2f_rxdiscon_nack[b-START_OF_UFI_2_FABRIC]),
                                                               
    .ufi_f2a_txcon_req              (ufi_2_f2a_txcon_req[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_rx_ack                 (ufi_2_f2a_rx_ack[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_rx_empty               (ufi_2_f2a_rx_empty[b-START_OF_UFI_2_FABRIC]),
    .ufi_f2a_rxdiscon_nack      (ufi_2_f2a_rxdiscon_nack[b-START_OF_UFI_2_FABRIC]),

    .ufi_f2a_req_fifo_data_in   (dout_rx_fifo [b][0]),
    .ufi_f2a_req_fifo_re_out    (rd_rx_fifo   [b][0]),
    .ufi_f2a_req_fifo_empty_in  (empty_rx_fifo[b][0]), 

    .ufi_f2a_rsp_fifo_data_in   (dout_rx_fifo [b][1]),
    .ufi_f2a_rsp_fifo_re_out    (rd_rx_fifo   [b][1]),
    .ufi_f2a_rsp_fifo_empty_in  (empty_rx_fifo[b][1]), 

    .ufi_f2a_data_fifo_data_in  (dout_rx_fifo [b][2]),
    .ufi_f2a_data_fifo_re_out   (rd_rx_fifo   [b][2]),
    .ufi_f2a_data_fifo_empty_in (empty_rx_fifo[b][2]), 

    .ufi_a2f_req_fifo_data_out  (din_tx_fifo  [b][0]),
    .ufi_a2f_req_fifo_we_out    (wr_tx_fifo   [b][0]),
    .ufi_a2f_req_fifo_wait_in   (full_tx_fifo [b][0]),

    .ufi_a2f_rsp_fifo_data_out  (din_tx_fifo  [b][1]),
    .ufi_a2f_rsp_fifo_we_out    (wr_tx_fifo   [b][1]),
    .ufi_a2f_rsp_fifo_wait_in   (full_tx_fifo [b][1]),

    .ufi_a2f_data_fifo_data_out (din_tx_fifo  [b][2]),
    .ufi_a2f_data_fifo_we_out   (wr_tx_fifo   [b][2]),
    .ufi_a2f_data_fifo_wait_in  (full_tx_fifo [b][2]),
    
         .device_number			(cfg_device_number),
         .function_number		(cfg_function_number),
         .bus_number			(cfg_bus_number),
  
  .aximm_awvalid    (client_aximm_awvalid[b]),
  .aximm_awready    (client_aximm_awready[b]),
  .aximm_awid       (client_aximm_awid[b]),
  .aximm_awaddr     (client_aximm_awaddr[b]),
  .aximm_awlen      (client_aximm_awlen[b]),
  .aximm_awsize     (client_aximm_awsize[b]),
  .aximm_awburst    (client_aximm_awburst[b]),
  .aximm_awlock     (client_aximm_awlock[b]),
  .aximm_awcache    (client_aximm_awcache[b]),
  .aximm_awqos      (client_aximm_awqos[b]),
                    
  .aximm_wvalid     (client_aximm_wvalid[b]),
  .aximm_wready     (client_aximm_wready[b]),
  .aximm_wlast      (client_aximm_wlast[b]),
  .aximm_wdata      (client_aximm_wdata[b]),
  .aximm_wstrb      (client_aximm_wstrb[b]),
     
  .aximm_bvalid     (client_aximm_bvalid[b]),
  .aximm_bready     (client_aximm_bready[b]),
  .aximm_bid        (client_aximm_bid[b]),
  .aximm_bresp      (client_aximm_bresp[b]),
     
  .aximm_arvalid    (client_aximm_arvalid[b]),
  .aximm_arready    (client_aximm_arready[b]),
  .aximm_arid       (client_aximm_arid[b]),
  .aximm_araddr     (client_aximm_araddr[b]),
  .aximm_arlen      (client_aximm_arlen[b]),
  .aximm_arsize     (client_aximm_arsize[b]),
  .aximm_arburst    (client_aximm_arburst[b]),
  .aximm_arlock     (client_aximm_arlock[b]),
  .aximm_arcache    (client_aximm_arcache[b]),
  .aximm_arqos      (client_aximm_arqos[b]),
  
  .aximm_rvalid    (client_aximm_rvalid[b]),
  .aximm_rready    (client_aximm_rready[b]),
  .aximm_rid       (client_aximm_rid[b]),
  .aximm_rdata     (client_aximm_rdata[b]),
  .aximm_rresp     (client_aximm_rresp[b]),
  .aximm_rlast     (client_aximm_rlast[b]),

  .direct_axis_rx_tdata (axi_rc_tdata_client[b]),
 	.direct_axis_rx_tkeep (axi_rc_tkeep_client[b]),
  .direct_axis_rx_tlast (axi_rc_tlast_client[b]),
  .direct_axis_rx_tvalid(axi_rc_tvalid_client[b]),
  .direct_axis_rx_tuser (axi_rc_tuser_client[b]),
  .direct_axis_rx_tready(axi_rc_tready_client[b]),
  .direct_axis_tx_tdata (axi_rq_tdata_client[b]),
  .direct_axis_tx_tkeep (axi_rq_tkeep_client[b]),
  .direct_axis_tx_tlast (axi_rq_tlast_client[b]),
  .direct_axis_tx_tvalid(axi_rq_tvalid_client[b]),
  .direct_axis_tx_tuser (axi_rq_tuser_client[b]),
  .direct_axis_tx_tready(axi_rq_tready_client[b])  

);
    
    
    assign rd_rx_fifo  [b][14:3] = 'b0;
		assign wr_tx_fifo  [b][14:3] = 'b0;
		assign din_tx_fifo [b][14:3] = 'b0;
     
    end
  end // :UFI_2_FABRIC
  endgenerate
  // end of UFI_2 FABRIC


// UFI 2.0 AGENT transactor
//----------------------------------------------------------------------------
  genvar k;
  generate if (NUM_OF_UFI_2_AGENT != 0) 
  begin: UFI_2_AGENT
  
  for (k=START_OF_UFI_2_AGENT; k<START_OF_UFI_2_AGENT+NUM_OF_UFI_2_AGENT; k++)
    begin
   `ifdef FGC_CDC
    assign client_clk[k] = ufi_2_agent_clock_0; 
   `else 
    assign client_clk[k] = user_clk;
  `endif
    

ufi_2_agent_top # (                             
                         .TRANSACTOR_TYPE		(UFI_2_AGENT_TYPE),
                         .COUNT_MAX				(UFI_2_COUNT_MAX),
                         .NUM_OF_CREDIT_CH		(UFI_2_NUM_OF_CREDIT_CH),
                         .CREDIT_ID				(UFI_2_CREDIT_ID),
                         .TRANSACTOR_VERSION	(UFI_2_AGENT_VERSION),
                         .LOOP_BACK				(UFI_2_LOOPBACK)                         
                         )
           ufi_2_agent_top_inst
(
    `ifdef FGC_CDC
     .fgc_clk 	(fgc_clk),
   `else
    .fgc_clk 	(user_clk),
  `endif	
    .generic_chassis_rst 			(generic_chassis_rst),
    .ufi_clk						(ufi_2_agent_clk[k-START_OF_UFI_2_AGENT]),
    .rstn							(ufi_2_agent_rstn[k-START_OF_UFI_2_AGENT]),

    .ufi_a2f_req_is_valid           (a2f_2_req_is_valid[k-START_OF_UFI_2_AGENT]), 
    .ufi_a2f_req_protocol_id        (a2f_2_req_protocol_id[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_req_early_valid        (a2f_2_req_early_valid[k-START_OF_UFI_2_AGENT]),   
    .ufi_a2f_req_block              (a2f_2_req_block[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_req_vc_id              (a2f_2_req_vc_id[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_req_header             (a2f_2_req_header[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_req_rxcrd              (a2f_2_req_rxcrd[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_req_rxcrd_protocol_id  (a2f_2_req_rxcrd_protocol_id[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_req_rxcrd_vc_id        (a2f_2_req_rxcrd_vc_id[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_req_txflow_crd_block   (a2f_2_req_txflow_crd_block[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_req_shared_credit      (a2f_2_req_shared_credit[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_req_rxcrd_shared       (a2f_2_req_rxcrd_shared[k-START_OF_UFI_2_AGENT]),
                                                                   
    .ufi_a2f_rsp_is_valid           (a2f_2_rsp_is_valid[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_rsp_protocol_id        (a2f_2_rsp_protocol_id[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_rsp_early_valid        (a2f_2_rsp_early_valid[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_rsp_block              (a2f_2_rsp_block[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_rsp_vc_id              (a2f_2_rsp_vc_id[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_rsp_header             (a2f_2_rsp_header[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_rsp_rxcrd              (a2f_2_rsp_rxcrd[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_rsp_rxcrd_protocol_id  (a2f_2_rsp_rxcrd_protocol_id[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_rsp_rxcrd_vc_id        (a2f_2_rsp_rxcrd_vc_id[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_rsp_txflow_crd_block   (a2f_2_rsp_txflow_crd_block[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_rsp_shared_credit      (a2f_2_rsp_shared_credit[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_rsp_rxcrd_shared       (a2f_2_rsp_rxcrd_shared[k-START_OF_UFI_2_AGENT]),

    .ufi_a2f_data_is_valid          (a2f_2_data_is_valid[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_data_protocol_id       (a2f_2_data_protocol_id[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_data_early_valid       (a2f_2_data_early_valid[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_data_block             (a2f_2_data_block[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_data_vc_id             (a2f_2_data_vc_id[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_data_header            (a2f_2_data_header[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_data_eop               (a2f_2_data_eop[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_data_payload           (a2f_2_data_payload[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_data_rxcrd             (a2f_2_data_rxcrd[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_data_rxcrd_protocol_id (a2f_2_data_rxcrd_protocol_id[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_data_rxcrd_vc_id       (a2f_2_data_rxcrd_vc_id[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_data_txflow_crd_block  (a2f_2_data_txflow_crd_block[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_data_shared_credit     (a2f_2_data_shared_credit[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_data_rxcrd_shared      (a2f_2_data_rxcrd_shared[k-START_OF_UFI_2_AGENT]),
                                                                     
    .ufi_f2a_req_is_valid           (f2a_2_req_is_valid[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_req_protocol_id        (f2a_2_req_protocol_id[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_req_early_valid        (f2a_2_req_early_valid[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_req_block              (f2a_2_req_block[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_req_vc_id              (f2a_2_req_vc_id[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_req_header             (f2a_2_req_header[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_req_rxcrd              (f2a_2_req_rxcrd[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_req_rxcrd_protocol_id  (f2a_2_req_rxcrd_protocol_id[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_req_rxcrd_vc_id        (f2a_2_req_rxcrd_vc_id[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_req_txflow_crd_block   (f2a_2_req_txflow_crd_block[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_req_shared_credit      (f2a_2_req_shared_credit[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_req_rxcrd_shared       (f2a_2_req_rxcrd_shared[k-START_OF_UFI_2_AGENT]),
                                                                     
    .ufi_f2a_rsp_is_valid           (f2a_2_rsp_is_valid[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_rsp_early_valid        (f2a_2_rsp_early_valid[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_rsp_block              (f2a_2_rsp_block[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_rsp_protocol_id        (f2a_2_rsp_protocol_id[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_rsp_vc_id              (f2a_2_rsp_vc_id[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_rsp_header             (f2a_2_rsp_header[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_rsp_rxcrd              (f2a_2_rsp_rxcrd[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_rsp_rxcrd_protocol_id  (f2a_2_rsp_rxcrd_protocol_id[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_rsp_rxcrd_vc_id        (f2a_2_rsp_rxcrd_vc_id[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_rsp_txflow_crd_block   (f2a_2_rsp_txflow_crd_block[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_rsp_shared_credit      (f2a_2_rsp_shared_credit[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_rsp_rxcrd_shared       (f2a_2_rsp_rxcrd_shared[k-START_OF_UFI_2_AGENT]),                                                                     
    .ufi_f2a_data_is_valid          (f2a_2_data_is_valid[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_data_early_valid       (f2a_2_data_early_valid[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_data_block             (f2a_2_data_block[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_data_protocol_id       (f2a_2_data_protocol_id[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_data_vc_id             (f2a_2_data_vc_id[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_data_header            (f2a_2_data_header[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_data_eop               (f2a_2_data_eop[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_data_payload           (f2a_2_data_payload[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_data_rxcrd             (f2a_2_data_rxcrd[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_data_rxcrd_protocol_id (f2a_2_data_rxcrd_protocol_id[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_data_rxcrd_vc_id       (f2a_2_data_rxcrd_vc_id[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_data_txflow_crd_block  (f2a_2_data_txflow_crd_block[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_data_shared_credit     (f2a_2_data_shared_credit[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_data_rxcrd_shared      (f2a_2_data_rxcrd_shared[k-START_OF_UFI_2_AGENT]),

    .ufi_a2f_txcon_req              (a2f_2_txcon_req[k-START_OF_UFI_2_AGENT]),                    
    .ufi_a2f_rx_ack                 (a2f_2_rx_ack[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_rx_empty               (a2f_2_rx_empty[k-START_OF_UFI_2_AGENT]),
    .ufi_a2f_rxdiscon_nack          (a2f_2_rxdiscon_nack[k-START_OF_UFI_2_AGENT]),
                                                               
    .ufi_f2a_txcon_req              (f2a_2_txcon_req[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_rx_ack                 (f2a_2_rx_ack[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_rx_empty               (f2a_2_rx_empty[k-START_OF_UFI_2_AGENT]),
    .ufi_f2a_rxdiscon_nack          (f2a_2_rxdiscon_nack[k-START_OF_UFI_2_AGENT]),

    .ufi_a2f_req_fifo_data_in   (dout_rx_fifo [k][0]),
    .ufi_a2f_req_fifo_re_out    (rd_rx_fifo   [k][0]),
    .ufi_a2f_req_fifo_empty_in  (empty_rx_fifo[k][0]), 

    .ufi_a2f_rsp_fifo_data_in   (dout_rx_fifo [k][1]),
    .ufi_a2f_rsp_fifo_re_out    (rd_rx_fifo   [k][1]),
    .ufi_a2f_rsp_fifo_empty_in  (empty_rx_fifo[k][1]), 

    .ufi_a2f_data_fifo_data_in  (dout_rx_fifo [k][2]),
    .ufi_a2f_data_fifo_re_out   (rd_rx_fifo   [k][2]),
    .ufi_a2f_data_fifo_empty_in (empty_rx_fifo[k][2]), 

    .ufi_f2a_req_fifo_data_out  (din_tx_fifo  [k][0]),
    .ufi_f2a_req_fifo_we_out    (wr_tx_fifo   [k][0]),
    .ufi_f2a_req_fifo_wait_in   (full_tx_fifo [k][0]),

    .ufi_f2a_rsp_fifo_data_out  (din_tx_fifo  [k][1]),
    .ufi_f2a_rsp_fifo_we_out    (wr_tx_fifo   [k][1]),
    .ufi_f2a_rsp_fifo_wait_in   (full_tx_fifo [k][1]),

    .ufi_f2a_data_fifo_data_out (din_tx_fifo  [k][2]),
    .ufi_f2a_data_fifo_we_out   (wr_tx_fifo   [k][2]),
    .ufi_f2a_data_fifo_wait_in  (full_tx_fifo [k][2]),
  
  .aximm_awvalid    (client_aximm_awvalid[k]),
  .aximm_awready    (client_aximm_awready[k]),
  .aximm_awid       (client_aximm_awid[k]),
  .aximm_awaddr     (client_aximm_awaddr[k]),
  .aximm_awlen      (client_aximm_awlen[k]),
  .aximm_awsize     (client_aximm_awsize[k]),
  .aximm_awburst    (client_aximm_awburst[k]),
  .aximm_awlock     (client_aximm_awlock[k]),
  .aximm_awcache    (client_aximm_awcache[k]),
  .aximm_awqos      (client_aximm_awqos[k]),
                    
  .aximm_wvalid     (client_aximm_wvalid[k]),
  .aximm_wready     (client_aximm_wready[k]),
  .aximm_wlast      (client_aximm_wlast[k]),
  .aximm_wdata      (client_aximm_wdata[k]),
  .aximm_wstrb      (client_aximm_wstrb[k]),
     
  .aximm_bvalid     (client_aximm_bvalid[k]),
  .aximm_bready     (client_aximm_bready[k]),
  .aximm_bid        (client_aximm_bid[k]),
  .aximm_bresp      (client_aximm_bresp[k]),
     
  .aximm_arvalid    (client_aximm_arvalid[k]),
  .aximm_arready    (client_aximm_arready[k]),
  .aximm_arid       (client_aximm_arid[k]),
  .aximm_araddr     (client_aximm_araddr[k]),
  .aximm_arlen      (client_aximm_arlen[k]),
  .aximm_arsize     (client_aximm_arsize[k]),
  .aximm_arburst    (client_aximm_arburst[k]),
  .aximm_arlock     (client_aximm_arlock[k]),
  .aximm_arcache    (client_aximm_arcache[k]),
  .aximm_arqos      (client_aximm_arqos[k]),
  
  .aximm_rvalid    (client_aximm_rvalid[k]),
  .aximm_rready    (client_aximm_rready[k]),
  .aximm_rid       (client_aximm_rid[k]),
  .aximm_rdata     (client_aximm_rdata[k]),
  .aximm_rresp     (client_aximm_rresp[k]),
  .aximm_rlast     (client_aximm_rlast[k])     
);
     
     
				assign rd_rx_fifo  [k][14:3] = 'b0;
				assign wr_tx_fifo  [k][14:3] = 'b0;
				assign din_tx_fifo [k][14:3] = 'b0;

        assign axi_rq_tdata_client[k]  = 'b0;
        assign axi_rq_tkeep_client[k]  = 'b0;
        assign axi_rq_tlast_client[k]  = 'b0;
        assign axi_rq_tuser_client[k]  = 'b0;
        assign axi_rq_tvalid_client[k] = 'b0;
        assign axi_rc_tready_client[k] = 'b0;

    end
  end // :UFI_2_AGENT
  endgenerate
// End of UFI_2_AGENT


////////////////////////////////////////////////////////////////////////////////////////////
//                                      CXL.$ Host Version 3                              //
////////////////////////////////////////////////////////////////////////////////////////////
`include "CXL_CACHE_V3_wires.sv"
genvar x;

generate if (NUM_OF_CXL_CACHE_V3_HOST != 0) begin: CXL_CACHE_V3_HOST
  for (x=START_OF_CXL_CACHE_V3_HOST; x<START_OF_CXL_CACHE_V3_HOST + NUM_OF_CXL_CACHE_V3_HOST; x++) begin
    
    assign client_clk[x] = cxl_cache_v3_host_clk[x-START_OF_CXL_CACHE_V3_HOST];
    
    CXL_Cache_HOST_v3_Transactor_top # (
                          
                              .TRANSACTOR_TYPE(CXL_CACHE_V3_HOST_TYPE),
                              .TRANSACTOR_VERSION(CXL_CACHE_V3_VERSION)                            

    ) CXL_Cache_Host_v3_Transactor_top_inst (
        `ifdef FGC_CDC
        .generic_chassis_clk 	(fgc_clk),
        `else
        .generic_chassis_clk 	(user_clk),
        `endif
        .generic_chassis_rst 	(generic_chassis_rst), 
        .CXL_clk  	     	 	(cxl_cache_v3_host_clk[x-START_OF_CXL_CACHE_V3_HOST]),
        .CXL_rst_n     	 		(cxl_cache_v3_host_rstn[x-START_OF_CXL_CACHE_V3_HOST]),
        
        .dout_rx_fifo   		(dout_rx_fifo [x][5:0]), 
        .rd_rx_fifo     		(rd_rx_fifo   [x][5:0]), 
        .empty_rx_fifo  		(empty_rx_fifo[x][5:0]),

        .wr_tx_fifo     		(wr_tx_fifo   [x][4:0]),
        .din_tx_fifo    		(din_tx_fifo  [x][4:0]),
        .full_tx_fifo   		(full_tx_fifo [x][4:0]),
// CXL Interface
        // D2H request channel
        .D2H_REQ_VALID            (CXL_CACHE_V3_D2H_REQ_VALID           [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_REQ_OPCODE           (CXL_CACHE_V3_D2H_REQ_OPCODE          [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_REQ_ADDRESS          (CXL_CACHE_V3_D2H_REQ_ADDRESS         [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_REQ_CQID             (CXL_CACHE_V3_D2H_REQ_CQID            [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_REQ_RSVD             (CXL_CACHE_V3_D2H_REQ_RSVD            [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_REQ_ADDRPARITY       (CXL_CACHE_V3_D2H_REQ_ADDRPARITY      [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_REQ_CACHEID          (CXL_CACHE_V3_D2H_REQ_CACHEID         [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_REQ_PORTID           (CXL_CACHE_V3_D2H_REQ_PORTID          [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_REQ_NONTEMPORAL      (CXL_CACHE_V3_D2H_REQ_NONTEMPORAL     [x-START_OF_CXL_CACHE_V3_HOST]),
    
        // D2H data channel
        .D2H_DATA_VALID           (CXL_CACHE_V3_D2H_DATA_VALID          [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_DATA_UQID            (CXL_CACHE_V3_D2H_DATA_UQID           [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_DATA_BOGUS           (CXL_CACHE_V3_D2H_DATA_BOGUS          [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_DATA_POISON          (CXL_CACHE_V3_D2H_DATA_POISON         [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_DATA_DATA            (CXL_CACHE_V3_D2H_DATA_DATA           [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_DATA_DATAPARITY      (CXL_CACHE_V3_D2H_DATA_DATAPARITY     [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_DATA_BYTEEN          (CXL_CACHE_V3_D2H_DATA_BYTEEN         [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_DATA_PORTID          (CXL_CACHE_V3_D2H_DATA_PORTID         [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_DATA_RSVD            (CXL_CACHE_V3_D2H_DATA_RSVD           [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_DATA_BEPARITY        (CXL_CACHE_V3_D2H_DATA_BEPARITY       [x-START_OF_CXL_CACHE_V3_HOST]),
    
        // D2H response channel
        .D2H_RSP_VALID            (CXL_CACHE_V3_D2H_RSP_VALID           [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_RSP_OPCODE           (CXL_CACHE_V3_D2H_RSP_OPCODE          [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_RSP_UQID             (CXL_CACHE_V3_D2H_RSP_UQID            [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_RSP_PORTID           (CXL_CACHE_V3_D2H_RSP_PORTID          [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_RSP_RSVD             (CXL_CACHE_V3_D2H_RSP_RSVD            [x-START_OF_CXL_CACHE_V3_HOST]),
    
        // D2H Credit flow
        .D2H_REQ_CREDIT_RETURN           (CXL_CACHE_V3_D2H_REQ_CREDIT_RETURN        [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_REQ_CREDIT_RETURN_PORTID    (CXL_CACHE_V3_D2H_REQ_CREDIT_RETURN_PORTID [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_DATA_CREDIT_RETURN          (CXL_CACHE_V3_D2H_DATA_CREDIT_RETURN       [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_DATA_CREDIT_RETURN_PORTID   (CXL_CACHE_V3_D2H_DATA_CREDIT_RETURN_PORTID[x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_RSP_CREDIT_RETURN           (CXL_CACHE_V3_D2H_RSP_CREDIT_RETURN        [x-START_OF_CXL_CACHE_V3_HOST]),
        .D2H_RSP_CREDIT_RETURN_PORTID    (CXL_CACHE_V3_D2H_RSP_CREDIT_RETURN_PORTID [x-START_OF_CXL_CACHE_V3_HOST]),
    
        // H2D request channel
        .H2D_REQ_VALID            (CXL_CACHE_V3_H2D_REQ_VALID           [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_REQ_OPCODE           (CXL_CACHE_V3_H2D_REQ_OPCODE          [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_REQ_ADDRESS          (CXL_CACHE_V3_H2D_REQ_ADDRESS         [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_REQ_UQID             (CXL_CACHE_V3_H2D_REQ_UQID            [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_REQ_ADDRPARITY       (CXL_CACHE_V3_H2D_REQ_ADDRPARITY      [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_REQ_CACHEID          (CXL_CACHE_V3_H2D_REQ_CACHEID         [x-START_OF_CXL_CACHE_V3_HOST]),   
        .H2D_REQ_PORTID           (CXL_CACHE_V3_H2D_REQ_PORTID          [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_REQ_RSVD             (CXL_CACHE_V3_H2D_REQ_RSVD            [x-START_OF_CXL_CACHE_V3_HOST]),
    
        // H2D data channel
        .H2D_DATA_VALID           (CXL_CACHE_V3_H2D_DATA_VALID          [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_DATA_CQID            (CXL_CACHE_V3_H2D_DATA_CQID           [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_DATA_GO_ERR          (CXL_CACHE_V3_H2D_DATA_GO_ERR         [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_DATA_POISON          (CXL_CACHE_V3_H2D_DATA_POISON         [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_DATA_DATA            (CXL_CACHE_V3_H2D_DATA_DATA           [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_DATA_DATAPARITY      (CXL_CACHE_V3_H2D_DATA_DATAPARITY     [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_DATA_PORTID          (CXL_CACHE_V3_H2D_DATA_PORTID         [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_DATA_RSVD            (CXL_CACHE_V3_H2D_DATA_RSVD           [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_DATA_CACHEID         (CXL_CACHE_V3_H2D_DATA_CACHEID        [x-START_OF_CXL_CACHE_V3_HOST]),
    
        // H2D response channel
        .H2D_RSP_VALID            (CXL_CACHE_V3_H2D_RSP_VALID           [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_RSP_OPCODE           (CXL_CACHE_V3_H2D_RSP_OPCODE          [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_RSP_DATA             (CXL_CACHE_V3_H2D_RSP_DATA            [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_RSP_PRE              (CXL_CACHE_V3_H2D_RSP_PRE             [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_RSP_CQID             (CXL_CACHE_V3_H2D_RSP_CQID            [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_RSP_RSVD             (CXL_CACHE_V3_H2D_RSP_RSVD            [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_RSP_CACHEID          (CXL_CACHE_V3_H2D_RSP_CACHEID         [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_RSP_PORTID           (CXL_CACHE_V3_H2D_RSP_PORTID          [x-START_OF_CXL_CACHE_V3_HOST]),
    
        // H2D Credit flow
        .H2D_REQ_CREDIT_RETURN           (CXL_CACHE_V3_H2D_REQ_CREDIT_RETURN        [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_REQ_CREDIT_RETURN_PORTID    (CXL_CACHE_V3_H2D_REQ_CREDIT_RETURN_PORTID [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_DATA_CREDIT_RETURN          (CXL_CACHE_V3_H2D_DATA_CREDIT_RETURN       [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_DATA_CREDIT_RETURN_PORTID   (CXL_CACHE_V3_H2D_DATA_CREDIT_RETURN_PORTID[x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_RSP_CREDIT_RETURN           (CXL_CACHE_V3_H2D_RSP_CREDIT_RETURN        [x-START_OF_CXL_CACHE_V3_HOST]),
        .H2D_RSP_CREDIT_RETURN_PORTID    (CXL_CACHE_V3_H2D_RSP_CREDIT_RETURN_PORTID [x-START_OF_CXL_CACHE_V3_HOST]),
        
        // PCIe fields
        .device_number		(cfg_device_number),
        .function_number	(cfg_function_number),
        .bus_number			  (cfg_bus_number),

        //aximm interface with the client
        .aximm_awvalid    (client_aximm_awvalid[x]),
        .aximm_awready    (client_aximm_awready[x]),
        .aximm_awid       (client_aximm_awid[x]),
        .aximm_awaddr     (client_aximm_awaddr[x]),
        .aximm_awlen      (client_aximm_awlen[x]),
        .aximm_awsize     (client_aximm_awsize[x]),
        .aximm_awburst    (client_aximm_awburst[x]),
        .aximm_awlock     (client_aximm_awlock[x]),
        .aximm_awcache    (client_aximm_awcache[x]),
        .aximm_awqos      (client_aximm_awqos[x]),
                          
        .aximm_wvalid     (client_aximm_wvalid[x]),
        .aximm_wready     (client_aximm_wready[x]),
        .aximm_wlast      (client_aximm_wlast[x]),
        .aximm_wdata      (client_aximm_wdata[x]),
        .aximm_wstrb      (client_aximm_wstrb[x]),
           
        .aximm_bvalid     (client_aximm_bvalid[x]),
        .aximm_bready     (client_aximm_bready[x]),
        .aximm_bid        (client_aximm_bid[x]),
        .aximm_bresp      (client_aximm_bresp[x]),
           
        .aximm_arvalid    (client_aximm_arvalid[x]),
        .aximm_arready    (client_aximm_arready[x]),
        .aximm_arid       (client_aximm_arid[x]),
        .aximm_araddr     (client_aximm_araddr[x]),
        .aximm_arlen      (client_aximm_arlen[x]),
        .aximm_arsize     (client_aximm_arsize[x]),
        .aximm_arburst    (client_aximm_arburst[x]),
        .aximm_arlock     (client_aximm_arlock[x]),
        .aximm_arcache    (client_aximm_arcache[x]),
        .aximm_arqos      (client_aximm_arqos[x]),
        .aximm_rvalid     (client_aximm_rvalid[x]),
        .aximm_rready     (client_aximm_rready[x]),
        .aximm_rid        (client_aximm_rid[x]),
        .aximm_rdata      (client_aximm_rdata[x]),
        .aximm_rresp      (client_aximm_rresp[x]),
        .aximm_rlast      (client_aximm_rlast[x]),

        .direct_axis_rx_tdata (axi_rc_tdata_client[x]),
 	      .direct_axis_rx_tkeep (axi_rc_tkeep_client[x]),
        .direct_axis_rx_tlast (axi_rc_tlast_client[x]),
        .direct_axis_rx_tvalid(axi_rc_tvalid_client[x]),
        .direct_axis_rx_tuser (axi_rc_tuser_client[x]),
        .direct_axis_rx_tready(axi_rc_tready_client[x]),
        .direct_axis_tx_tdata (axi_rq_tdata_client[x]),
        .direct_axis_tx_tkeep (axi_rq_tkeep_client[x]),
        .direct_axis_tx_tlast (axi_rq_tlast_client[x]),
        .direct_axis_tx_tvalid(axi_rq_tvalid_client[x]),
        .direct_axis_tx_tuser (axi_rq_tuser_client[x]),
        .direct_axis_tx_tready(axi_rq_tready_client[x])
           
       );                           

    assign rd_rx_fifo  [START_OF_CXL_CACHE_V3_HOST][14:6] = 'b0;
    assign wr_tx_fifo  [START_OF_CXL_CACHE_V3_HOST][14:5] = 'b0;
    assign din_tx_fifo [START_OF_CXL_CACHE_V3_HOST][14:5] = 'b0;
 
  end // for                                                                           
  end // CXL.$ Host Version 3                                     
endgenerate   



////////////////////////////////////////////////////////////////////////////////////////////
//                                      CXL.$ Device Version 3                            //
////////////////////////////////////////////////////////////////////////////////////////////
// instantiation for CXL.$ Device Version 3

assign cxl_cache_v3_device_clock_0  = user_clk;
assign cxl_cache_v3_device_rstn_0  = ~generic_chassis_rst;


generate if (NUM_OF_CXL_CACHE_V3_DEVICE != 0) begin: CXL_CACHE_V3_DEVICE_1

    `ifdef FGC_CDC
    assign client_clk[START_OF_CXL_CACHE_V3_DEVICE] = cxl_cache_v3_device_clock_0; 
   `else 
    assign client_clk[START_OF_CXL_CACHE_V3_DEVICE] = user_clk;
  `endif
    

CXL_Cache_DEVICE_v3_Transactor_top # (                             
                              .TRANSACTOR_TYPE(CXL_CACHE_V3_DEVICE_TYPE),
                              .TRANSACTOR_VERSION(CXL_CACHE_V3_VERSION)                            

    ) CXL_Cache_Device_v3_Transactor_top_inst (
        `ifdef FGC_CDC
        .generic_chassis_clk 	(fgc_clk),
        `else
        .generic_chassis_clk 	(user_clk),
        `endif
        .generic_chassis_rst 	(generic_chassis_rst), 
        .CXL_clk  	     	 	(cxl_cache_v3_device_clock_0),
        .CXL_rst_n     	 		(cxl_cache_v3_device_rstn_0),
        
        .dout_rx_fifo   		(dout_rx_fifo [START_OF_CXL_CACHE_V3_DEVICE][4:0]), 
        .rd_rx_fifo     		(rd_rx_fifo   [START_OF_CXL_CACHE_V3_DEVICE][4:0]), 
        .empty_rx_fifo  		(empty_rx_fifo[START_OF_CXL_CACHE_V3_DEVICE][4:0]),

        .wr_tx_fifo     		(wr_tx_fifo   [START_OF_CXL_CACHE_V3_DEVICE][5:0]),
        .din_tx_fifo    		(din_tx_fifo  [START_OF_CXL_CACHE_V3_DEVICE][5:0]),
        .full_tx_fifo   		(full_tx_fifo [START_OF_CXL_CACHE_V3_DEVICE][5:0]),
// CXL Interface
        // D2H request channel
        .D2H_REQ_VALID            (cxl_CACHE_V3_D2H_REQ_VALID       ),
        .D2H_REQ_OPCODE           (cxl_CACHE_V3_D2H_REQ_OPCODE      ),
        .D2H_REQ_ADDRESS          (cxl_CACHE_V3_D2H_REQ_ADDRESS     ),
        .D2H_REQ_CQID             (cxl_CACHE_V3_D2H_REQ_CQID        ),
        .D2H_REQ_RSVD             (cxl_CACHE_V3_D2H_REQ_RSVD        ),
        .D2H_REQ_ADDRPARITY       (cxl_CACHE_V3_D2H_REQ_ADDRPARITY  ),
        .D2H_REQ_CACHEID          (cxl_CACHE_V3_D2H_REQ_CACHEID     ),
        .D2H_REQ_PORTID           (cxl_CACHE_V3_D2H_REQ_PORTID      ),
        .D2H_REQ_NONTEMPORAL      (cxl_CACHE_V3_D2H_REQ_NONTEMPORAL ),
    
        // D2H data channel
        .D2H_DATA_VALID           (cxl_CACHE_V3_D2H_DATA_VALID      ),
        .D2H_DATA_UQID            (cxl_CACHE_V3_D2H_DATA_UQID       ),
        .D2H_DATA_BOGUS           (cxl_CACHE_V3_D2H_DATA_BOGUS      ),
        .D2H_DATA_POISON          (cxl_CACHE_V3_D2H_DATA_POISON     ),
        .D2H_DATA_DATA            (cxl_CACHE_V3_D2H_DATA_DATA       ),
        .D2H_DATA_DATAPARITY      (cxl_CACHE_V3_D2H_DATA_DATAPARITY ),
        .D2H_DATA_BYTEEN          (cxl_CACHE_V3_D2H_DATA_BYTEEN     ),
        .D2H_DATA_PORTID          (cxl_CACHE_V3_D2H_DATA_PORTID     ),
        .D2H_DATA_RSVD            (cxl_CACHE_V3_D2H_DATA_RSVD       ),
        .D2H_DATA_BEPARITY        (cxl_CACHE_V3_D2H_DATA_BEPARITY   ),
    
        // D2H response channel
        .D2H_RSP_VALID            (cxl_CACHE_V3_D2H_RSP_VALID       ),
        .D2H_RSP_OPCODE           (cxl_CACHE_V3_D2H_RSP_OPCODE      ),
        .D2H_RSP_UQID             (cxl_CACHE_V3_D2H_RSP_UQID        ),
        .D2H_RSP_PORTID           (cxl_CACHE_V3_D2H_RSP_PORTID      ),
        .D2H_RSP_RSVD             (cxl_CACHE_V3_D2H_RSP_RSVD        ),
    
        // D2H Credit flow
        .D2H_REQ_CREDIT_RETURN           (cxl_CACHE_V3_D2H_REQ_CREDIT_RETURN        ),
        .D2H_REQ_CREDIT_RETURN_PORTID    (cxl_CACHE_V3_D2H_REQ_CREDIT_RETURN_PORTID ),
        .D2H_DATA_CREDIT_RETURN          (cxl_CACHE_V3_D2H_DATA_CREDIT_RETURN       ),
        .D2H_DATA_CREDIT_RETURN_PORTID   (cxl_CACHE_V3_D2H_DATA_CREDIT_RETURN_PORTID),
        .D2H_RSP_CREDIT_RETURN           (cxl_CACHE_V3_D2H_RSP_CREDIT_RETURN        ),
        .D2H_RSP_CREDIT_RETURN_PORTID    (cxl_CACHE_V3_D2H_RSP_CREDIT_RETURN_PORTID ),
    
        // H2D request channel
        .H2D_REQ_VALID            (cxl_CACHE_V3_H2D_REQ_VALID      ),
        .H2D_REQ_OPCODE           (cxl_CACHE_V3_H2D_REQ_OPCODE     ),
        .H2D_REQ_ADDRESS          (cxl_CACHE_V3_H2D_REQ_ADDRESS    ),
        .H2D_REQ_UQID             (cxl_CACHE_V3_H2D_REQ_UQID       ),
        .H2D_REQ_ADDRPARITY       (cxl_CACHE_V3_H2D_REQ_ADDRPARITY ),
        .H2D_REQ_CACHEID          (cxl_CACHE_V3_H2D_REQ_CACHEID    ),   
        .H2D_REQ_PORTID           (cxl_CACHE_V3_H2D_REQ_PORTID     ),
        .H2D_REQ_RSVD             (cxl_CACHE_V3_H2D_REQ_RSVD       ),
        // H2D data chancxl
        .H2D_DATA_VALID           (cxl_CACHE_V3_H2D_DATA_VALID     ),
        .H2D_DATA_CQID            (cxl_CACHE_V3_H2D_DATA_CQID      ),
        .H2D_DATA_GO_ERR          (cxl_CACHE_V3_H2D_DATA_GO_ERR    ),
        .H2D_DATA_POISON          (cxl_CACHE_V3_H2D_DATA_POISON    ),
        .H2D_DATA_DATA            (cxl_CACHE_V3_H2D_DATA_DATA      ),
        .H2D_DATA_DATAPARITY      (cxl_CACHE_V3_H2D_DATA_DATAPARITY),
        .H2D_DATA_PORTID          (cxl_CACHE_V3_H2D_DATA_PORTID    ),
        .H2D_DATA_RSVD            (cxl_CACHE_V3_H2D_DATA_RSVD      ),
        .H2D_DATA_CACHEID         (cxl_CACHE_V3_H2D_DATA_CACHEID   ),
    
        // H2D response channel
        .H2D_RSP_VALID            (cxl_CACHE_V3_H2D_RSP_VALID      ),
        .H2D_RSP_OPCODE           (cxl_CACHE_V3_H2D_RSP_OPCODE     ),
        .H2D_RSP_DATA             (cxl_CACHE_V3_H2D_RSP_DATA       ),
        .H2D_RSP_PRE              (cxl_CACHE_V3_H2D_RSP_PRE        ),
        .H2D_RSP_CQID             (cxl_CACHE_V3_H2D_RSP_CQID       ),
        .H2D_RSP_RSVD             (cxl_CACHE_V3_H2D_RSP_RSVD       ),
        .H2D_RSP_CACHEID          (cxl_CACHE_V3_H2D_RSP_CACHEID    ),
        .H2D_RSP_PORTID           (cxl_CACHE_V3_H2D_RSP_PORTID     ),
    
        // H2D Credit flow
        .H2D_REQ_CREDIT_RETURN           (cxl_CACHE_V3_H2D_REQ_CREDIT_RETURN        ),
        .H2D_REQ_CREDIT_RETURN_PORTID    (cxl_CACHE_V3_H2D_REQ_CREDIT_RETURN_PORTID ),
        .H2D_DATA_CREDIT_RETURN          (cxl_CACHE_V3_H2D_DATA_CREDIT_RETURN       ),
        .H2D_DATA_CREDIT_RETURN_PORTID   (cxl_CACHE_V3_H2D_DATA_CREDIT_RETURN_PORTID),
        .H2D_RSP_CREDIT_RETURN           (cxl_CACHE_V3_H2D_RSP_CREDIT_RETURN        ),
        .H2D_RSP_CREDIT_RETURN_PORTID    (cxl_CACHE_V3_H2D_RSP_CREDIT_RETURN_PORTID ),

        //aximm interface with the client
        .aximm_awvalid    (client_aximm_awvalid[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_awready    (client_aximm_awready[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_awid       (client_aximm_awid[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_awaddr     (client_aximm_awaddr[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_awlen      (client_aximm_awlen[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_awsize     (client_aximm_awsize[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_awburst    (client_aximm_awburst[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_awlock     (client_aximm_awlock[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_awcache    (client_aximm_awcache[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_awqos      (client_aximm_awqos[START_OF_CXL_CACHE_V3_DEVICE]),
                          
        .aximm_wvalid     (client_aximm_wvalid[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_wready     (client_aximm_wready[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_wlast      (client_aximm_wlast[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_wdata      (client_aximm_wdata[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_wstrb      (client_aximm_wstrb[START_OF_CXL_CACHE_V3_DEVICE]),
           
        .aximm_bvalid     (client_aximm_bvalid[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_bready     (client_aximm_bready[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_bid        (client_aximm_bid[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_bresp      (client_aximm_bresp[START_OF_CXL_CACHE_V3_DEVICE]),
           
        .aximm_arvalid    (client_aximm_arvalid[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_arready    (client_aximm_arready[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_arid       (client_aximm_arid[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_araddr     (client_aximm_araddr[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_arlen      (client_aximm_arlen[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_arsize     (client_aximm_arsize[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_arburst    (client_aximm_arburst[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_arlock     (client_aximm_arlock[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_arcache    (client_aximm_arcache[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_arqos      (client_aximm_arqos[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_rvalid     (client_aximm_rvalid[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_rready     (client_aximm_rready[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_rid        (client_aximm_rid[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_rdata      (client_aximm_rdata[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_rresp      (client_aximm_rresp[START_OF_CXL_CACHE_V3_DEVICE]),
        .aximm_rlast      (client_aximm_rlast[START_OF_CXL_CACHE_V3_DEVICE]) 
       );                           

    assign rd_rx_fifo  [START_OF_CXL_CACHE_V3_DEVICE][14:5] = 'b0;
    assign wr_tx_fifo  [START_OF_CXL_CACHE_V3_DEVICE][14:6] = 'b0;
    assign din_tx_fifo [START_OF_CXL_CACHE_V3_DEVICE][14:6] = 'b0;

    assign axi_rq_tdata_client[START_OF_CXL_CACHE_V3_DEVICE]  = 'b0;
    assign axi_rq_tkeep_client[START_OF_CXL_CACHE_V3_DEVICE]  = 'b0;
    assign axi_rq_tlast_client[START_OF_CXL_CACHE_V3_DEVICE]  = 'b0;
    assign axi_rq_tuser_client[START_OF_CXL_CACHE_V3_DEVICE]  = 'b0;
    assign axi_rq_tvalid_client[START_OF_CXL_CACHE_V3_DEVICE] = 'b0;
    assign axi_rc_tready_client[START_OF_CXL_CACHE_V3_DEVICE] = 'b0;
                                                                                      
  end // CXL.$ Device Version 3                                     
endgenerate    


////////////////////////////////////////////////////////////////////////////////////////////
//                                      CXL.G Fabric                                      //
////////////////////////////////////////////////////////////////////////////////////////////



genvar e;

/*
generate if (NUM_OF_CXL_G_FABRIC != 0 || NUM_OF_CXL_G_AGENT != 0) begin 
    `include "cxl_g_structures.vh"
    `include "CXL_G_wires.sv"
end
endgenerate
*/
// `include "cxl_g_structures.vh"
 
import cxl_g_structures_pkg::*;
`include "CXL_G_wires.sv"

generate if (NUM_OF_CXL_G_FABRIC != 0) begin: CXL_G_FABRIC
  for (e=START_OF_CXL_G_FABRIC; e<START_OF_CXL_G_FABRIC + NUM_OF_CXL_G_FABRIC; e++) begin
    
    `ifdef FGC_CDC
      assign client_clk[e] = fgc_clk;
   `else 
      assign client_clk[e] = user_clk;
  `endif
    
    
    CXL_G_UNCORE_Transactor_top # (
                          
                              .TRANSACTOR_TYPE(CXL_G_FABRIC_TYPE),
                              .TRANSACTOR_VERSION(CXL_G_VERSION),
                              .COUNT_MAX(CXL_G_MAX_CREDITS)

    ) CXL_G_UNCORE_Transactor_top_inst (
        `ifdef FGC_CDC
        .generic_chassis_clk 	(fgc_clk),
        `else
        .generic_chassis_clk 	(user_clk),
        `endif
        .generic_chassis_rst 	(generic_chassis_rst), 
        .CXL_clk  	     	 	(cxl_g_fabric_clk[e-START_OF_CXL_G_FABRIC]),
        .CXL_rst_n     	 		(cxl_g_fabric_rstn[e-START_OF_CXL_G_FABRIC]),
        
        .dout_rx_fifo   		(dout_rx_fifo [e][2:0]), 
        .rd_rx_fifo     		(rd_rx_fifo   [e][2:0]), 
        .empty_rx_fifo  		(empty_rx_fifo[e][2:0]),

        .wr_tx_fifo     		(wr_tx_fifo   [e][2:0]),
        .din_tx_fifo    		(din_tx_fifo  [e][2:0]),
        .full_tx_fifo   		(full_tx_fifo [e][2:0]),
// CXL Interface
        
        // Global INIT signals
        .c2u_txcon_req          (CXL_G_UNCORE_C2U_txcon_req         [e-START_OF_CXL_G_FABRIC]),
        .c2u_rxcon_ack          (CXL_G_UNCORE_C2U_rxcon_ack         [e-START_OF_CXL_G_FABRIC]),
        .c2u_rxdiscon_nack      (CXL_G_UNCORE_C2U_rxdiscon_nack     [e-START_OF_CXL_G_FABRIC]),
        .c2u_rx_empty           (CXL_G_UNCORE_C2U_rx_empty          [e-START_OF_CXL_G_FABRIC]),

        .u2c_txcon_req          (CXL_G_UNCORE_U2C_txcon_req         [e-START_OF_CXL_G_FABRIC]),
        .u2c_rxcon_ack          (CXL_G_UNCORE_U2C_rxcon_ack         [e-START_OF_CXL_G_FABRIC]),
        .u2c_rxdiscon_nack      (CXL_G_UNCORE_U2C_rxdiscon_nack     [e-START_OF_CXL_G_FABRIC]),
        .u2c_rx_empty           (CXL_G_UNCORE_U2C_rx_empty          [e-START_OF_CXL_G_FABRIC]),


        // C2U Request
        .C2U_Req_req_shared_credit(CXL_G_UNCORE_C2U_Req_req_shared_credit   [e-START_OF_CXL_G_FABRIC]),
        .C2U_Req_req_vc_id      (CXL_G_UNCORE_C2U_Req_req_vc_id             [e-START_OF_CXL_G_FABRIC]),
        .C2U_Req_req_protocol_id(CXL_G_UNCORE_C2U_Req_req_protocol_id       [e-START_OF_CXL_G_FABRIC]),
        .C2U_Req_req_header     (CXL_G_UNCORE_C2U_Req_req_header            [e-START_OF_CXL_G_FABRIC]),
        .C2U_Req_early_valid    (CXL_G_UNCORE_C2U_Req_early_valid           [e-START_OF_CXL_G_FABRIC]),
        .C2U_Req_rxcrd_valid    (CXL_G_UNCORE_C2U_Req_rxcrd_valid    [e-START_OF_CXL_G_FABRIC]),
        .C2U_Req_rxcrd_vc_id    (CXL_G_UNCORE_C2U_Req_rxcrd_vc_id    [e-START_OF_CXL_G_FABRIC]),
        .C2U_Req_rxcrd_shared   (CXL_G_UNCORE_C2U_Req_rxcrd_shared   [e-START_OF_CXL_G_FABRIC]),
        .C2U_Req_rxcrd_afifo    (CXL_G_UNCORE_C2U_Req_rxcrd_afifo    [e-START_OF_CXL_G_FABRIC]),


        // C2U Data
        .C2U_Data_data_shared_credit  (CXL_G_UNCORE_C2U_Data_data_shared_credit     [e-START_OF_CXL_G_FABRIC]),
        .C2U_Data_data_eop            (CXL_G_UNCORE_C2U_Data_data_eop               [e-START_OF_CXL_G_FABRIC]),
        .C2U_Data_data_vc_id          (CXL_G_UNCORE_C2U_Data_data_vc_id             [e-START_OF_CXL_G_FABRIC]),
        .C2U_Data_data_protocol_id    (CXL_G_UNCORE_C2U_Data_data_protocol_id       [e-START_OF_CXL_G_FABRIC]),
        .C2U_Data_data_header_payload (CXL_G_UNCORE_C2U_Data_data_header_payload    [e-START_OF_CXL_G_FABRIC]),
        .C2U_Data_early_valid         (CXL_G_UNCORE_C2U_Data_early_valid            [e-START_OF_CXL_G_FABRIC]),
        .C2U_Data_rxcrd_valid         (CXL_G_UNCORE_C2U_Data_rxcrd_valid    [e-START_OF_CXL_G_FABRIC]),
        .C2U_Data_rxcrd_vc_id         (CXL_G_UNCORE_C2U_Data_rxcrd_vc_id    [e-START_OF_CXL_G_FABRIC]),
        .C2U_Data_rxcrd_shared        (CXL_G_UNCORE_C2U_Data_rxcrd_shared   [e-START_OF_CXL_G_FABRIC]),
        .C2U_Data_rxcrd_afifo         (CXL_G_UNCORE_C2U_Data_rxcrd_afifo    [e-START_OF_CXL_G_FABRIC]),
        

        // U2C Response
        .U2C_Resp_resp_shared_credit  (CXL_G_UNCORE_U2C_Resp_resp_shared_credit   [e-START_OF_CXL_G_FABRIC]),
        .U2C_Resp_resp_vc_id          (CXL_G_UNCORE_U2C_Resp_resp_vc_id           [e-START_OF_CXL_G_FABRIC]),
        .U2C_Resp_resp_protocol_id    (CXL_G_UNCORE_U2C_Resp_resp_protocol_id     [e-START_OF_CXL_G_FABRIC]),
        .U2C_Resp_resp_header         (CXL_G_UNCORE_U2C_Resp_resp_header          [e-START_OF_CXL_G_FABRIC]),
        .U2C_Resp_early_valid         (CXL_G_UNCORE_U2C_Resp_early_valid          [e-START_OF_CXL_G_FABRIC]),
        .U2C_Resp_rxcrd_valid         (CXL_G_UNCORE_U2C_Resp_rxcrd_valid    [e-START_OF_CXL_G_FABRIC]),
        .U2C_Resp_rxcrd_vc_id         (CXL_G_UNCORE_U2C_Resp_rxcrd_vc_id    [e-START_OF_CXL_G_FABRIC]),
        .U2C_Resp_rxcrd_shared        (CXL_G_UNCORE_U2C_Resp_rxcrd_shared   [e-START_OF_CXL_G_FABRIC]),
        .U2C_Resp_rxcrd_afifo         (CXL_G_UNCORE_U2C_Resp_rxcrd_afifo    [e-START_OF_CXL_G_FABRIC]),
        
         
        // U2C Data
        .U2C_Data_data_shared_credit   (CXL_G_UNCORE_U2C_Data_data_shared_credit   [e-START_OF_CXL_G_FABRIC]),
        .U2C_Data_data_eop             (CXL_G_UNCORE_U2C_Data_data_eop             [e-START_OF_CXL_G_FABRIC]),
        .U2C_Data_data_vc_id           (CXL_G_UNCORE_U2C_Data_data_vc_id           [e-START_OF_CXL_G_FABRIC]),
        .U2C_Data_data_protocol_id     (CXL_G_UNCORE_U2C_Data_data_protocol_id     [e-START_OF_CXL_G_FABRIC]),
        .U2C_Data_data_header_payload  (CXL_G_UNCORE_U2C_Data_data_header_payload  [e-START_OF_CXL_G_FABRIC]),
        .U2C_Data_early_valid          (CXL_G_UNCORE_U2C_Data_early_valid          [e-START_OF_CXL_G_FABRIC]),
        .U2C_Data_rxcrd_valid          (CXL_G_UNCORE_U2C_Data_rxcrd_valid   [e-START_OF_CXL_G_FABRIC]),
        .U2C_Data_rxcrd_vc_id          (CXL_G_UNCORE_U2C_Data_rxcrd_vc_id   [e-START_OF_CXL_G_FABRIC]),
        .U2C_Data_rxcrd_shared         (CXL_G_UNCORE_U2C_Data_rxcrd_shared  [e-START_OF_CXL_G_FABRIC]),
        .U2C_Data_rxcrd_afifo          (CXL_G_UNCORE_U2C_Data_rxcrd_afifo   [e-START_OF_CXL_G_FABRIC]),
        

        //aximm interface with the client
        .aximm_awvalid    (client_aximm_awvalid[e]),
        .aximm_awready    (client_aximm_awready[e]),
        .aximm_awid       (client_aximm_awid[e]),
        .aximm_awaddr     (client_aximm_awaddr[e]),
        .aximm_awlen      (client_aximm_awlen[e]),
        .aximm_awsize     (client_aximm_awsize[e]),
        .aximm_awburst    (client_aximm_awburst[e]),
        .aximm_awlock     (client_aximm_awlock[e]),
        .aximm_awcache    (client_aximm_awcache[e]),
        .aximm_awqos      (client_aximm_awqos[e]),
                          
        .aximm_wvalid     (client_aximm_wvalid[e]),
        .aximm_wready     (client_aximm_wready[e]),
        .aximm_wlast      (client_aximm_wlast[e]),
        .aximm_wdata      (client_aximm_wdata[e]),
        .aximm_wstrb      (client_aximm_wstrb[e]),
           
        .aximm_bvalid     (client_aximm_bvalid[e]),
        .aximm_bready     (client_aximm_bready[e]),
        .aximm_bid        (client_aximm_bid[e]),
        .aximm_bresp      (client_aximm_bresp[e]),
           
        .aximm_arvalid    (client_aximm_arvalid[e]),
        .aximm_arready    (client_aximm_arready[e]),
        .aximm_arid       (client_aximm_arid[e]),
        .aximm_araddr     (client_aximm_araddr[e]),
        .aximm_arlen      (client_aximm_arlen[e]),
        .aximm_arsize     (client_aximm_arsize[e]),
        .aximm_arburst    (client_aximm_arburst[e]),
        .aximm_arlock     (client_aximm_arlock[e]),
        .aximm_arcache    (client_aximm_arcache[e]),
        .aximm_arqos      (client_aximm_arqos[e]),
        .aximm_rvalid     (client_aximm_rvalid[e]),
        .aximm_rready     (client_aximm_rready[e]),
        .aximm_rid        (client_aximm_rid[e]),
        .aximm_rdata      (client_aximm_rdata[e]),
        .aximm_rresp      (client_aximm_rresp[e]),
        .aximm_rlast      (client_aximm_rlast[e]) 
           
       );                           

    assign rd_rx_fifo  [START_OF_CXL_CACHE_V3_HOST][14:3] = 'b0;
    assign wr_tx_fifo  [START_OF_CXL_CACHE_V3_HOST][14:3] = 'b0;
    assign din_tx_fifo [START_OF_CXL_CACHE_V3_HOST][14:3] = 'b0;
 
  end // for                                                                           
  end // CXL.G Fabric                                     
endgenerate   


////////////////////////////////////////////////////////////////////////////////////////////
//                                      CXL.G Agent                                       //
////////////////////////////////////////////////////////////////////////////////////////////
// instantiation for CXL.G Agent




generate if (NUM_OF_CXL_G_AGENT != 0) begin: CXL_G_AGENT_1
    
    assign cxl_g_agent_clock_0  = user_clk;
    assign cxl_g_agent_rstn_0  = ~generic_chassis_rst;

    `ifdef FGC_CDC
    assign client_clk[START_OF_CXL_G_AGENT] = cxl_g_agent_clock_0; 
   `else 
    assign client_clk[START_OF_CXL_G_AGENT] = user_clk;
  `endif
    

CXL_G_CORE_Transactor_top # (                             
                              .TRANSACTOR_TYPE(CXL_G_AGENT_TYPE),
                              .TRANSACTOR_VERSION(CXL_G_VERSION),                            
                              .COUNT_MAX(CXL_G_MAX_CREDITS)
    ) CXL_G_CORE_Transactor_top_inst (
        `ifdef FGC_CDC
        .generic_chassis_clk 	(fgc_clk),
        `else
        .generic_chassis_clk 	(user_clk),
        `endif
        .generic_chassis_rst 	(generic_chassis_rst), 
        .CXL_clk  	     	 	(cxl_g_agent_clock_0),
        .CXL_rst_n     	 		(cxl_g_agent_rstn_0), 

        .dout_rx_fifo   		(dout_rx_fifo [START_OF_CXL_G_AGENT][2:0]), 
        .rd_rx_fifo     		(rd_rx_fifo   [START_OF_CXL_G_AGENT][2:0]), 
        .empty_rx_fifo  		(empty_rx_fifo[START_OF_CXL_G_AGENT][2:0]),

        .wr_tx_fifo     		(wr_tx_fifo   [START_OF_CXL_G_AGENT][2:0]),
        .din_tx_fifo    		(din_tx_fifo  [START_OF_CXL_G_AGENT][2:0]),
        .full_tx_fifo   		(full_tx_fifo [START_OF_CXL_G_AGENT][2:0]),
// CXL Interface
        
       // Global INIT signals
        .c2u_txcon_req          (CXL_G_CORE_C2U_txcon_req_0),
        .c2u_rxcon_ack          (CXL_G_CORE_C2U_rxcon_ack_0),
        .c2u_rxdiscon_nack      (CXL_G_CORE_C2U_rxdiscon_nack_0),
        .c2u_rx_empty           (CXL_G_CORE_C2U_rx_empty_0),

        .u2c_txcon_req          (CXL_G_CORE_U2C_txcon_req_0),
        .u2c_rxcon_ack          (CXL_G_CORE_U2C_rxcon_ack_0),
        .u2c_rxdiscon_nack      (CXL_G_CORE_U2C_rxdiscon_nack_0),
        .u2c_rx_empty           (CXL_G_CORE_U2C_rx_empty_0),

        // C2U Request
        .C2U_Req_req_shared_credit      (CXL_G_CORE_C2U_Req_req_shared_credit_0),
        .C2U_Req_req_vc_id              (CXL_G_CORE_C2U_Req_req_vc_id_0),
        .C2U_Req_req_protocol_id        (CXL_G_CORE_C2U_Req_req_protocol_id_0),
        .C2U_Req_req_header             (CXL_G_CORE_C2U_Req_req_header_0),
        .C2U_Req_early_valid            (CXL_G_CORE_C2U_Req_early_valid_0),
        .C2U_Req_rxcrd_valid       (CXL_G_CORE_C2U_Req_rxcrd_valid_0),
        .C2U_Req_rxcrd_vc_id       (CXL_G_CORE_C2U_Req_rxcrd_vc_id_0),
        .C2U_Req_rxcrd_shared      (CXL_G_CORE_C2U_Req_rxcrd_shared_0),
        .C2U_Req_rxcrd_afifo       (CXL_G_CORE_C2U_Req_rxcrd_afifo_0),

        // C2U Data
        .C2U_Data_data_shared_credit        (CXL_G_CORE_C2U_Data_data_shared_credit_0),
        .C2U_Data_data_eop                  (CXL_G_CORE_C2U_Data_data_eop_0),
        .C2U_Data_data_vc_id                (CXL_G_CORE_C2U_Data_data_vc_id_0),
        .C2U_Data_data_protocol_id          (CXL_G_CORE_C2U_Data_data_protocol_id_0),
        .C2U_Data_data_header_payload       (CXL_G_CORE_C2U_Data_data_header_payload_0),
        .C2U_Data_early_valid               (CXL_G_CORE_C2U_Data_early_valid_0),
        .C2U_Data_rxcrd_valid         (CXL_G_CORE_C2U_Data_rxcrd_valid_0),
        .C2U_Data_rxcrd_vc_id         (CXL_G_CORE_C2U_Data_rxcrd_vc_id_0),
        .C2U_Data_rxcrd_shared        (CXL_G_CORE_C2U_Data_rxcrd_shared_0),
        .C2U_Data_rxcrd_afifo         (CXL_G_CORE_C2U_Data_rxcrd_afifo_0),

        // U2C Response
        .U2C_Resp_resp_shared_credit        (CXL_G_CORE_U2C_Resp_resp_shared_credit_0),
        .U2C_Resp_resp_vc_id                (CXL_G_CORE_U2C_Resp_resp_vc_id_0),
        .U2C_Resp_resp_protocol_id          (CXL_G_CORE_U2C_Resp_resp_protocol_id_0),
        .U2C_Resp_resp_header               (CXL_G_CORE_U2C_Resp_resp_header_0),
        .U2C_Resp_early_valid               (CXL_G_CORE_U2C_Resp_early_valid_0),
        .U2C_Resp_rxcrd_valid         (CXL_G_CORE_U2C_Resp_rxcrd_valid_0),
        .U2C_Resp_rxcrd_vc_id         (CXL_G_CORE_U2C_Resp_rxcrd_vc_id_0),
        .U2C_Resp_rxcrd_shared        (CXL_G_CORE_U2C_Resp_rxcrd_shared_0),
        .U2C_Resp_rxcrd_afifo         (CXL_G_CORE_U2C_Resp_rxcrd_afifo_0),

        // U2C Data
        .U2C_Data_data_shared_credit        (CXL_G_CORE_U2C_Data_data_shared_credit_0),
        .U2C_Data_data_eop                  (CXL_G_CORE_U2C_Data_data_eop_0),
        .U2C_Data_data_vc_id                (CXL_G_CORE_U2C_Data_data_vc_id_0),
        .U2C_Data_data_protocol_id          (CXL_G_CORE_U2C_Data_data_protocol_id_0),
        .U2C_Data_data_header_payload       (CXL_G_CORE_U2C_Data_data_header_payload_0),
        .U2C_Data_early_valid               (CXL_G_CORE_U2C_Data_early_valid_0),
        .U2C_Data_rxcrd_valid         (CXL_G_CORE_U2C_Data_rxcrd_valid_0),
        .U2C_Data_rxcrd_vc_id         (CXL_G_CORE_U2C_Data_rxcrd_vc_id_0),
        .U2C_Data_rxcrd_shared        (CXL_G_CORE_U2C_Data_rxcrd_shared_0),
        .U2C_Data_rxcrd_afifo         (CXL_G_CORE_U2C_Data_rxcrd_afifo_0),


        //aximm interface with the client
        .aximm_awvalid    (client_aximm_awvalid [START_OF_CXL_G_AGENT]),
        .aximm_awready    (client_aximm_awready [START_OF_CXL_G_AGENT]),
        .aximm_awid       (client_aximm_awid    [START_OF_CXL_G_AGENT]),
        .aximm_awaddr     (client_aximm_awaddr  [START_OF_CXL_G_AGENT]),
        .aximm_awlen      (client_aximm_awlen   [START_OF_CXL_G_AGENT]),
        .aximm_awsize     (client_aximm_awsize  [START_OF_CXL_G_AGENT]),
        .aximm_awburst    (client_aximm_awburst [START_OF_CXL_G_AGENT]),
        .aximm_awlock     (client_aximm_awlock  [START_OF_CXL_G_AGENT]),
        .aximm_awcache    (client_aximm_awcache [START_OF_CXL_G_AGENT]),
        .aximm_awqos      (client_aximm_awqos   [START_OF_CXL_G_AGENT]),
                          
        .aximm_wvalid     (client_aximm_wvalid  [START_OF_CXL_G_AGENT]),
        .aximm_wready     (client_aximm_wready  [START_OF_CXL_G_AGENT]),
        .aximm_wlast      (client_aximm_wlast   [START_OF_CXL_G_AGENT]),
        .aximm_wdata      (client_aximm_wdata   [START_OF_CXL_G_AGENT]),
        .aximm_wstrb      (client_aximm_wstrb   [START_OF_CXL_G_AGENT]),
           
        .aximm_bvalid     (client_aximm_bvalid  [START_OF_CXL_G_AGENT]),
        .aximm_bready     (client_aximm_bready  [START_OF_CXL_G_AGENT]),
        .aximm_bid        (client_aximm_bid     [START_OF_CXL_G_AGENT]),
        .aximm_bresp      (client_aximm_bresp   [START_OF_CXL_G_AGENT]),
           
        .aximm_arvalid    (client_aximm_arvalid [START_OF_CXL_G_AGENT]),
        .aximm_arready    (client_aximm_arready [START_OF_CXL_G_AGENT]),
        .aximm_arid       (client_aximm_arid    [START_OF_CXL_G_AGENT]),
        .aximm_araddr     (client_aximm_araddr  [START_OF_CXL_G_AGENT]),
        .aximm_arlen      (client_aximm_arlen   [START_OF_CXL_G_AGENT]),
        .aximm_arsize     (client_aximm_arsize  [START_OF_CXL_G_AGENT]),
        .aximm_arburst    (client_aximm_arburst [START_OF_CXL_G_AGENT]),
        .aximm_arlock     (client_aximm_arlock  [START_OF_CXL_G_AGENT]),
        .aximm_arcache    (client_aximm_arcache [START_OF_CXL_G_AGENT]),
        .aximm_arqos      (client_aximm_arqos   [START_OF_CXL_G_AGENT]),
        .aximm_rvalid     (client_aximm_rvalid  [START_OF_CXL_G_AGENT]),
        .aximm_rready     (client_aximm_rready  [START_OF_CXL_G_AGENT]),
        .aximm_rid        (client_aximm_rid     [START_OF_CXL_G_AGENT]),
        .aximm_rdata      (client_aximm_rdata   [START_OF_CXL_G_AGENT]),
        .aximm_rresp      (client_aximm_rresp   [START_OF_CXL_G_AGENT]),
        .aximm_rlast      (client_aximm_rlast   [START_OF_CXL_G_AGENT]) 
       );                           

    assign rd_rx_fifo  [START_OF_CXL_G_AGENT][14:3] = 'b0;
    assign wr_tx_fifo  [START_OF_CXL_G_AGENT][14:3] = 'b0;
    assign din_tx_fifo [START_OF_CXL_G_AGENT][14:3] = 'b0;

    assign axi_rq_tdata_client  [START_OF_CXL_G_AGENT]  = 'b0;
    assign axi_rq_tkeep_client  [START_OF_CXL_G_AGENT]  = 'b0;
    assign axi_rq_tlast_client  [START_OF_CXL_G_AGENT]  = 'b0;
    assign axi_rq_tuser_client  [START_OF_CXL_G_AGENT]  = 'b0;
    assign axi_rq_tvalid_client [START_OF_CXL_G_AGENT]  = 'b0;
    assign axi_rc_tready_client [START_OF_CXL_G_AGENT]  = 'b0;
                                                                                      
  end // CXL.G Agent                                     
endgenerate    

////////////////////////////////////////////////////////////////////////////////////////////
//                                      DDI Transactor                                    //
////////////////////////////////////////////////////////////////////////////////////////////
// instantiation for CXL.$ Device Version 3
`include "DDI_wires.sv"
assign ddi_clock_0  = user_clk;
assign ddi_rstn_0  = ~generic_chassis_rst;

genvar y;
generate if (NUM_OF_DDI_TRANSACTOR != 0) begin: DDI_TRANSACTOR
  for (y=START_OF_DDI_TRANSACTOR; y<START_OF_DDI_TRANSACTOR + NUM_OF_DDI_TRANSACTOR; y++) begin
    
   
    assign client_clk[y] = ddi_clock[y-START_OF_DDI_TRANSACTOR];

DDI_Transactor_top # (                             
                              .TRANSACTOR_TYPE(DDI_TYPE),
                              .TRANSACTOR_VERSION(DDI_TRANSACTOR_VERSION),
                              .DDI_GENERATOR(DDI_GENERATOR[y-START_OF_DDI_TRANSACTOR]),
                              .DDI_NUM_EMBEDDED_PORTS(DDI_NUM_EMBEDDED_PORTS[y-START_OF_DDI_TRANSACTOR]),
                              .DDI_NUM_LANES(DDI_NUM_LANES[y-START_OF_DDI_TRANSACTOR])

    ) DDI_Transactor_top_inst (
        `ifdef FGC_CDC
        .generic_chassis_clk 	(fgc_clk),
        `else
        .generic_chassis_clk 	(user_clk),
        `endif
        .generic_chassis_rst 	(generic_chassis_rst), 
        
        
        // DDI Interface
        .DDI_clk  	     	 	(ddi_clock      [y-START_OF_DDI_TRANSACTOR]),
        .DDI_rst_n     	 		(ddi_rstn       [y-START_OF_DDI_TRANSACTOR]),
        .DDI_VALID          (ddi_valid      [y-START_OF_DDI_TRANSACTOR][DDI_NUM_EMBEDDED_PORTS[y-START_OF_DDI_TRANSACTOR]-1:0]),
        .DDI_DATA_0         (ddi_data_0     [y-START_OF_DDI_TRANSACTOR][DDI_NUM_EMBEDDED_PORTS[y-START_OF_DDI_TRANSACTOR]-1:0]),
        .DDI_DATA_1         (ddi_data_1     [y-START_OF_DDI_TRANSACTOR][DDI_NUM_EMBEDDED_PORTS[y-START_OF_DDI_TRANSACTOR]-1:0]),
        .DDI_DATA_2         (ddi_data_2     [y-START_OF_DDI_TRANSACTOR][DDI_NUM_EMBEDDED_PORTS[y-START_OF_DDI_TRANSACTOR]-1:0]),
        .DDI_DATA_3         (ddi_data_3     [y-START_OF_DDI_TRANSACTOR][DDI_NUM_EMBEDDED_PORTS[y-START_OF_DDI_TRANSACTOR]-1:0]),
        //aximm interface with the client
        .aximm_awvalid    (client_aximm_awvalid[START_OF_DDI_TRANSACTOR]),
        .aximm_awready    (client_aximm_awready[START_OF_DDI_TRANSACTOR]),
        .aximm_awid       (client_aximm_awid[START_OF_DDI_TRANSACTOR]),
        .aximm_awaddr     (client_aximm_awaddr[START_OF_DDI_TRANSACTOR]),
        .aximm_awlen      (client_aximm_awlen[START_OF_DDI_TRANSACTOR]),
        .aximm_awsize     (client_aximm_awsize[START_OF_DDI_TRANSACTOR]),
        .aximm_awburst    (client_aximm_awburst[START_OF_DDI_TRANSACTOR]),
        .aximm_awlock     (client_aximm_awlock[START_OF_DDI_TRANSACTOR]),
        .aximm_awcache    (client_aximm_awcache[START_OF_DDI_TRANSACTOR]),
        .aximm_awqos      (client_aximm_awqos[START_OF_DDI_TRANSACTOR]),
                          
        .aximm_wvalid     (client_aximm_wvalid[START_OF_DDI_TRANSACTOR]),
        .aximm_wready     (client_aximm_wready[START_OF_DDI_TRANSACTOR]),
        .aximm_wlast      (client_aximm_wlast[START_OF_DDI_TRANSACTOR]),
        .aximm_wdata      (client_aximm_wdata[START_OF_DDI_TRANSACTOR]),
        .aximm_wstrb      (client_aximm_wstrb[START_OF_DDI_TRANSACTOR]),
           
        .aximm_bvalid     (client_aximm_bvalid[START_OF_DDI_TRANSACTOR]),
        .aximm_bready     (client_aximm_bready[START_OF_DDI_TRANSACTOR]),
        .aximm_bid        (client_aximm_bid[START_OF_DDI_TRANSACTOR]),
        .aximm_bresp      (client_aximm_bresp[START_OF_DDI_TRANSACTOR]),
           
        .aximm_arvalid    (client_aximm_arvalid[START_OF_DDI_TRANSACTOR]),
        .aximm_arready    (client_aximm_arready[START_OF_DDI_TRANSACTOR]),
        .aximm_arid       (client_aximm_arid[START_OF_DDI_TRANSACTOR]),
        .aximm_araddr     (client_aximm_araddr[START_OF_DDI_TRANSACTOR]),
        .aximm_arlen      (client_aximm_arlen[START_OF_DDI_TRANSACTOR]),
        .aximm_arsize     (client_aximm_arsize[START_OF_DDI_TRANSACTOR]),
        .aximm_arburst    (client_aximm_arburst[START_OF_DDI_TRANSACTOR]),
        .aximm_arlock     (client_aximm_arlock[START_OF_DDI_TRANSACTOR]),
        .aximm_arcache    (client_aximm_arcache[START_OF_DDI_TRANSACTOR]),
        .aximm_arqos      (client_aximm_arqos[START_OF_DDI_TRANSACTOR]),
        .aximm_rvalid     (client_aximm_rvalid[START_OF_DDI_TRANSACTOR]),
        .aximm_rready     (client_aximm_rready[START_OF_DDI_TRANSACTOR]),
        .aximm_rid        (client_aximm_rid[START_OF_DDI_TRANSACTOR]),
        .aximm_rdata      (client_aximm_rdata[START_OF_DDI_TRANSACTOR]),
        .aximm_rresp      (client_aximm_rresp[START_OF_DDI_TRANSACTOR]),
        .aximm_rlast      (client_aximm_rlast[START_OF_DDI_TRANSACTOR]) 
       );                           

    assign axi_rq_tdata_client[START_OF_DDI_TRANSACTOR]  = 'b0;
    assign axi_rq_tkeep_client[START_OF_DDI_TRANSACTOR]  = 'b0;
    assign axi_rq_tlast_client[START_OF_DDI_TRANSACTOR]  = 'b0;
    assign axi_rq_tuser_client[START_OF_DDI_TRANSACTOR]  = 'b0;
    assign axi_rq_tvalid_client[START_OF_DDI_TRANSACTOR] = 'b0;
    assign axi_rc_tready_client[START_OF_DDI_TRANSACTOR] = 'b0;
  
  end // for
  end // DDI Transactor                                   
endgenerate    




////////////////////////////////////////////////////////////////////
      `include "fpga_psf20_defines.vm"
//      `include "uhfi_params.inc"
      `include "IOSF_P_wires.sv"
      
generate if (IOSF_P_LOOPBACK != 0)
 begin
    `include "IOSF_P_lpbk.sv"

  // PLL to be used as slow clock for loopback
  // ------------------------------------------------
   wire locked_slow;
   wire fgc_slow_clk;

   clk_10M local_clk_inst(
       .clk_out1(fgc_slow_clk), 
       .reset(1'b0), 
       .locked(locked_slow), 
       .clk_in1(user_clk)
   );   

    assign 		iosf_prime_clk_0 		   	= fgc_slow_clk; 
    assign 		iosf_prime_clk_1 		   	= fgc_slow_clk; 
    assign    iosf_p_rstn_0           = ~generic_chassis_rst;
    assign    iosf_p_rstn_1           = ~generic_chassis_rst; 
 end
endgenerate


// IOSF Primary transactor
//----------------------------------------------------------------------------
  generate if (NUM_OF_IOSF_P_TRANSACTOR != 0) 
  begin: IOSF_P

  //    `include "cnvrg_indirect_param.inc"

  //generate instantiation for IOSF_P
  genvar h;
   
  for (h=START_OF_IOSF_P_TRANSACTOR; h<START_OF_IOSF_P_TRANSACTOR+NUM_OF_IOSF_P_TRANSACTOR; h++)
    begin

  `ifdef FGC_CDC
    assign client_clk[h] = iosf_prime_clk_0; 
   `else 
    assign client_clk[h] = user_clk;
  `endif

  iosf_p_xtor_top   # (     
                         .IOSF_FIP_IS_FABRIC(IOSF_FIP_IS_FABRIC[h-START_OF_IOSF_P_TRANSACTOR]),  
                         .TRANSACTOR_TYPE		(IOSF_P_TYPE),
                         .TRANSACTOR_VERSION	(IOSF_P_TRANSACTOR_VERSION),
                         `include "IOSF_P_param_inst.sv"
                           )
  iosf_p_xtor_top_inst(
                        .user_clk(user_clk),
                        .iosf_prime_clk(iosf_prime_clk[h-START_OF_IOSF_P_TRANSACTOR]),
                        .user_rst_n(~generic_chassis_rst),
                        .iosf_prim_rst_n(iosf_p_rstn[h-START_OF_IOSF_P_TRANSACTOR]),
                        //.rst(generic_chassis_rst), 
                        .fabric_credit_put  (iosf_fabric_credit_put  [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_credit_cmd  (iosf_fabric_credit_cmd  [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_credit_data (iosf_fabric_credit_data [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_credit_rtype(iosf_fabric_credit_rtype[h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_credit_chid (iosf_fabric_credit_chid [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_req_put     (iosf_fabric_req_put     [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_req_chid    (iosf_fabric_req_chid    [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_req_dest_id (iosf_fabric_req_dest_id [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_req_rs      (iosf_fabric_req_rs      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_req_rtype   (iosf_fabric_req_rtype   [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_req_cdata   (iosf_fabric_req_cdata   [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_req_dlen    (iosf_fabric_req_dlen    [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_req_tc      (iosf_fabric_req_tc      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_req_ns      (iosf_fabric_req_ns      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_req_ro      (iosf_fabric_req_ro      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_req_locked  (iosf_fabric_req_locked  [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mfmt        (iosf_fabric_mfmt        [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mtype       (iosf_fabric_mtype       [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mtc         (iosf_fabric_mtc         [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mro         (iosf_fabric_mro         [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mns         (iosf_fabric_mns         [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mrs         (iosf_fabric_mrs         [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mdeadline   (iosf_fabric_mdeadline   [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mrsvd0_7    (iosf_fabric_mrsvd0_7    [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mrsvd1_1    (iosf_fabric_mrsvd1_1    [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mrsvd1_3    (iosf_fabric_mrsvd1_3    [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mrsvd1_7    (iosf_fabric_mrsvd1_7    [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mth         (iosf_fabric_mth         [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mido        (iosf_fabric_mido        [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mtd         (iosf_fabric_mtd         [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mecrc       (iosf_fabric_mecrc       [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mecrc_generate(iosf_fabric_mecrc_generate[h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mecrc_error (iosf_fabric_mecrc_error [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mlength     (iosf_fabric_mlength     [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .fabric_mrqid       (iosf_fabric_mrqid       [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mtag        (iosf_fabric_mtag        [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mlbe        (iosf_fabric_mlbe        [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mfbe        (iosf_fabric_mfbe        [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_maddress    (iosf_fabric_maddress    [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mdest_id    (iosf_fabric_mdest_id    [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mat         (iosf_fabric_mat         [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mcparity    (iosf_fabric_mcparity    [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mdparity    (iosf_fabric_mdparity    [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mep         (iosf_fabric_mep         [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_msai        (iosf_fabric_msai        [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_msrc_id     (iosf_fabric_msrc_id     [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mpasidtlp   (iosf_fabric_mpasidtlp   [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_mdata       (iosf_fabric_mdata       [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_ttif_credit_put(iosf_fabric_ttif_credit_put      [h-START_OF_IOSF_P_TRANSACTOR]),         
                        .fabric_ttif_credit_chid (iosf_fabric_ttif_credit_chid [h-START_OF_IOSF_P_TRANSACTOR]),              
                        .fabric_ttif_credit_rtype(iosf_fabric_ttif_credit_rtype[h-START_OF_IOSF_P_TRANSACTOR]),  
                        .fabric_ttif_credit_cmd  (iosf_fabric_ttif_credit_cmd  [h-START_OF_IOSF_P_TRANSACTOR]),   
                        .fabric_ttif_credit_data (iosf_fabric_ttif_credit_data [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .fabric_ttif_cmd_put     (iosf_fabric_ttif_cmd_put     [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_ttif_cmd_chid    (iosf_fabric_ttif_cmd_chid    [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_ttif_cmd_rtype   (iosf_fabric_ttif_cmd_rtype   [h-START_OF_IOSF_P_TRANSACTOR]),
                        
                        .agent_cmd_put       (iosf_agent_cmd_put       [h-START_OF_IOSF_P_TRANSACTOR]),          
                        .agent_cmd_chid      (iosf_agent_cmd_chid      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_cmd_rtype     (iosf_agent_cmd_rtype     [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tfmt          (iosf_agent_tfmt          [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_ttype         (iosf_agent_ttype         [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_ttc           (iosf_agent_ttc           [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tro           (iosf_agent_tro           [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tns           (iosf_agent_tns           [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tlength       (iosf_agent_tlength       [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_trqid         (iosf_agent_trqid         [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_ttag          (iosf_agent_ttag          [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tlbe          (iosf_agent_tlbe          [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tfbe          (iosf_agent_tfbe          [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_taddress      (iosf_agent_taddress      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tdest_id      (iosf_agent_tdest_id      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tat           (iosf_agent_tat           [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tcparity      (iosf_agent_tcparity      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tdparity      (iosf_agent_tdparity      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tep           (iosf_agent_tep           [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tsai          (iosf_agent_tsai          [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tsrc_id       (iosf_agent_tsrc_id       [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_trs           (iosf_agent_trs           [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tdeadline     (iosf_agent_tdeadline     [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_trsvd0_7      (iosf_agent_trsvd0_7      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_trsvd1_1      (iosf_agent_trsvd1_1      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_trsvd1_3      (iosf_agent_trsvd1_3      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_trsvd1_7      (iosf_agent_trsvd1_7      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tth           (iosf_agent_tth           [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tido          (iosf_agent_tido          [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_ttd           (iosf_agent_ttd           [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tecrc         (iosf_agent_tecrc         [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tecrc_generate(iosf_agent_tecrc_generate[h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_tecrc_error   (iosf_agent_tecrc_error   [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_tpasidtlp     (iosf_agent_tpasidtlp     [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_target_data   (iosf_agent_target_data   [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_gnt_put       (iosf_agent_gnt_put       [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_gnt_chid      (iosf_agent_gnt_chid      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_gnt_rtype     (iosf_agent_gnt_rtype     [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_gnt_type      (iosf_agent_gnt_type      [h-START_OF_IOSF_P_TRANSACTOR]),

                        .fabric_cmd_put       (iosf_fabric_cmd_put       [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_cmd_chid      (iosf_fabric_cmd_chid      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_cmd_rtype     (iosf_fabric_cmd_rtype     [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tfmt          (iosf_fabric_tfmt          [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_ttype         (iosf_fabric_ttype         [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_ttc           (iosf_fabric_ttc           [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tro           (iosf_fabric_tro           [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tns           (iosf_fabric_tns           [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tlength       (iosf_fabric_tlength       [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_trqid         (iosf_fabric_trqid         [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_ttag          (iosf_fabric_ttag          [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tlbe          (iosf_fabric_tlbe          [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tfbe          (iosf_fabric_tfbe          [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_taddress      (iosf_fabric_taddress      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tdest_id      (iosf_fabric_tdest_id      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tat           (iosf_fabric_tat           [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tcparity      (iosf_fabric_tcparity      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tdparity      (iosf_fabric_tdparity      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tep           (iosf_fabric_tep           [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tsai          (iosf_fabric_tsai          [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tsrc_id       (iosf_fabric_tsrc_id       [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_trs           (iosf_fabric_trs           [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tdeadline     (iosf_fabric_tdeadline     [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_trsvd0_7      (iosf_fabric_trsvd0_7      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_trsvd1_1      (iosf_fabric_trsvd1_1      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_trsvd1_3      (iosf_fabric_trsvd1_3      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_trsvd1_7      (iosf_fabric_trsvd1_7      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tth           (iosf_fabric_tth           [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tido          (iosf_fabric_tido          [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_ttd           (iosf_fabric_ttd           [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tecrc         (iosf_fabric_tecrc         [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tecrc_generate(iosf_fabric_tecrc_generate[h-START_OF_IOSF_P_TRANSACTOR]),  
                        .fabric_tecrc_error   (iosf_fabric_tecrc_error   [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_tpasidtlp     (iosf_fabric_tpasidtlp     [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_target_data   (iosf_fabric_target_data   [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_gnt_put       (iosf_fabric_gnt_put       [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_gnt_chid      (iosf_fabric_gnt_chid      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_gnt_rtype     (iosf_fabric_gnt_rtype     [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_gnt_type      (iosf_fabric_gnt_type      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_credit_put     (iosf_agent_credit_put  [h-START_OF_IOSF_P_TRANSACTOR]),                        
                        .agent_credit_cmd     (iosf_agent_credit_cmd  [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_credit_data    (iosf_agent_credit_data [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_credit_rtype   (iosf_agent_credit_rtype[h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_credit_chid    (iosf_agent_credit_chid [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_req_put        (iosf_agent_req_put     [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_req_chid       (iosf_agent_req_chid    [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_req_rtype      (iosf_agent_req_rtype   [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_req_rs         (iosf_agent_req_rs      [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_req_cdata      (iosf_agent_req_cdata   [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_req_dlen       (iosf_agent_req_dlen    [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_req_tc         (iosf_agent_req_tc      [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_req_dest_id    (iosf_agent_req_dest_id [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_req_ns         (iosf_agent_req_ns      [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_req_ro         (iosf_agent_req_ro      [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_req_locked     (iosf_agent_req_locked  [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_mfmt           (iosf_agent_mfmt        [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_mtype          (iosf_agent_mtype       [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_mtc            (iosf_agent_mtc         [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_mro            (iosf_agent_mro         [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_mns            (iosf_agent_mns         [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_mrs            (iosf_agent_mrs         [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_mlength        (iosf_agent_mlength     [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_mrqid          (iosf_agent_mrqid       [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_mtag           (iosf_agent_mtag        [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_mlbe           (iosf_agent_mlbe        [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_mfbe           (iosf_agent_mfbe        [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_maddress       (iosf_agent_maddress    [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_mdest_id       (iosf_agent_mdest_id    [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_mat            (iosf_agent_mat         [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_mcparity       (iosf_agent_mcparity    [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_mdparity       (iosf_agent_mdparity    [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_mep            (iosf_agent_mep         [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_msai           (iosf_agent_msai        [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_msrc_id        (iosf_agent_msrc_id     [h-START_OF_IOSF_P_TRANSACTOR]),   
                        .agent_mdeadline      (iosf_agent_mdeadline   [h-START_OF_IOSF_P_TRANSACTOR]),   
                        .agent_mrsvd0_7       (iosf_agent_mrsvd0_7    [h-START_OF_IOSF_P_TRANSACTOR]),   
                        .agent_mrsvd1_1       (iosf_agent_mrsvd1_1    [h-START_OF_IOSF_P_TRANSACTOR]),   
                        .agent_mrsvd1_3       (iosf_agent_mrsvd1_3    [h-START_OF_IOSF_P_TRANSACTOR]),   
                        .agent_mrsvd1_7       (iosf_agent_mrsvd1_7    [h-START_OF_IOSF_P_TRANSACTOR]),   
                        .agent_mth            (iosf_agent_mth         [h-START_OF_IOSF_P_TRANSACTOR]),   
                        .agent_mido           (iosf_agent_mido        [h-START_OF_IOSF_P_TRANSACTOR]),   
                        .agent_mtd            (iosf_agent_mtd         [h-START_OF_IOSF_P_TRANSACTOR]),   
                        .agent_mecrc          (iosf_agent_mecrc       [h-START_OF_IOSF_P_TRANSACTOR]),   
                        .agent_mecrc_generate (iosf_agent_mecrc_generate[h-START_OF_IOSF_P_TRANSACTOR]),   
                        .agent_mecrc_error    (iosf_agent_mecrc_error [h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_mpasidtlp      (iosf_agent_mpasidtlp   [h-START_OF_IOSF_P_TRANSACTOR]),   
                        .agent_mdata          (iosf_agent_mdata       [h-START_OF_IOSF_P_TRANSACTOR]),   
                        .fabric_prim_ism_agent(iosf_fabric_prim_ism_agent      [h-START_OF_IOSF_P_TRANSACTOR]),
                        .fabric_prim_ism_fabric  (iosf_fabric_prim_ism_fabric  [h-START_OF_IOSF_P_TRANSACTOR]),   
                        .fabric_power_prim_clkack(iosf_fabric_power_prim_clkack[h-START_OF_IOSF_P_TRANSACTOR]),  
                        .fabric_power_prim_clkreq(iosf_fabric_power_prim_clkreq[h-START_OF_IOSF_P_TRANSACTOR]),  
                        .agent_prim_ism_fabric   (iosf_agent_prim_ism_fabric   [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_prim_ism_agent    (iosf_agent_prim_ism_agent    [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_power_prim_clkack (iosf_agent_power_prim_clkack [h-START_OF_IOSF_P_TRANSACTOR]), 
                        .agent_power_prim_clkreq (iosf_agent_power_prim_clkreq [h-START_OF_IOSF_P_TRANSACTOR]), 
                                                 
                        .agent_ttif_credit_put  (iosf_agent_ttif_credit_put  [h-START_OF_IOSF_P_TRANSACTOR]),    
                        .agent_ttif_credit_chid (iosf_agent_ttif_credit_chid [h-START_OF_IOSF_P_TRANSACTOR]),    
                        .agent_ttif_credit_rtype(iosf_agent_ttif_credit_rtype[h-START_OF_IOSF_P_TRANSACTOR]),   
                        .agent_ttif_credit_cmd  (iosf_agent_ttif_credit_cmd  [h-START_OF_IOSF_P_TRANSACTOR]),    
                        .agent_ttif_credit_data (iosf_agent_ttif_credit_data [h-START_OF_IOSF_P_TRANSACTOR]),   
                        .agent_ttif_cmd_put     (iosf_agent_ttif_cmd_put     [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_ttif_cmd_chid    (iosf_agent_ttif_cmd_chid    [h-START_OF_IOSF_P_TRANSACTOR]),
                        .agent_ttif_cmd_rtype   (iosf_agent_ttif_cmd_rtype   [h-START_OF_IOSF_P_TRANSACTOR]),


                        .fifo_data_in (dout_rx_fifo [h][0]),
                        .fifo_re_out  (rd_rx_fifo   [h][0]),
                        .fifo_empty_in(empty_rx_fifo[h][0]), 
                                      
                        .fifo_data_out(din_tx_fifo [h][0]),
                        .fifo_we_out  (wr_tx_fifo  [h][0]),
                        .fifo_wait_in (full_tx_fifo[h][0]),

                      `ifdef PCIE_BRIDGE
                        .direct_rx_req_mux (direct_desc_rx_req[h]),
                        .direct_rx_desc_mux(direct_desc_rx_desc[h]),
                        .direct_rx_data_mux(direct_desc_rx_data[h]),
                        .direct_rx_dfr_mux (direct_desc_rx_dfr[h]),
                        .direct_rx_dv_mux  (direct_desc_rx_dv[h]),
                        .direct_rx_be_mux  (direct_desc_rx_be[h]),
                        .direct_rx_ack_mux (direct_desc_rx_ack[h]),
                        .direct_rx_ws_mux  (direct_desc_rx_ws[h]),
                        .direct_rx_eof_mux (direct_desc_rx_eof[h]),

                        .direct_tx_req_mux (direct_desc_tx_req[h]),
                        .direct_tx_desc_mux(direct_desc_tx_desc[h]),
                        .direct_tx_data_mux(direct_desc_tx_data[h]),
                        .direct_tx_dfr_mux (direct_desc_tx_dfr[h]),
                        .direct_tx_ack_mux (direct_desc_tx_ack[h]),
                        .direct_tx_ws_mux  (direct_desc_tx_ws[h]),
                        .direct_tx_req_arbiter_mux(direct_desc_tx_req_arbiter[h]),
                        .direct_tx_ack_arbiter_mux(direct_desc_tx_ack_arbiter[h]),  
                      `else 
                        .direct_rx_req_mux ('b0),
                        .direct_rx_desc_mux('b0),
                        .direct_rx_data_mux('b0),
                        .direct_rx_dfr_mux ('b0),
                        .direct_rx_dv_mux  ('b0),
                        .direct_rx_be_mux  ('b0),

                        .direct_tx_ack_mux ('b0),
                        .direct_tx_ws_mux  ('b0),	
                        .direct_tx_ack_arbiter_mux('b0),
                      `endif  
 
                        .aximm_awvalid    (client_aximm_awvalid[h]),
                        .aximm_awready    (client_aximm_awready[h]),
                        .aximm_awid       (client_aximm_awid[h]),
                        .aximm_awaddr     (client_aximm_awaddr[h]),
                        .aximm_awlen      (client_aximm_awlen[h]),
                        .aximm_awsize     (client_aximm_awsize[h]),
                        .aximm_awburst    (client_aximm_awburst[h]),
                        .aximm_awlock     (client_aximm_awlock[h]),
                        .aximm_awcache    (client_aximm_awcache[h]),
                        .aximm_awqos      (client_aximm_awqos[h]),
                                          
                        .aximm_wvalid     (client_aximm_wvalid[h]),
                        .aximm_wready     (client_aximm_wready[h]),
                        .aximm_wlast      (client_aximm_wlast[h]),
                        .aximm_wdata      (client_aximm_wdata[h]),
                        .aximm_wstrb      (client_aximm_wstrb[h]),
                           
                        .aximm_bvalid     (client_aximm_bvalid[h]),
                        .aximm_bready     (client_aximm_bready[h]),
                        .aximm_bid        (client_aximm_bid[h]),
                        .aximm_bresp      (client_aximm_bresp[h]),
                           
                        .aximm_arvalid    (client_aximm_arvalid[h]),
                        .aximm_arready    (client_aximm_arready[h]),
                        .aximm_arid       (client_aximm_arid[h]),
                        .aximm_araddr     (client_aximm_araddr[h]),
                        .aximm_arlen      (client_aximm_arlen[h]),
                        .aximm_arsize     (client_aximm_arsize[h]),
                        .aximm_arburst    (client_aximm_arburst[h]),
                        .aximm_arlock     (client_aximm_arlock[h]),
                        .aximm_arcache    (client_aximm_arcache[h]),
                        .aximm_arqos      (client_aximm_arqos[h]),
                        
                        .aximm_rvalid    (client_aximm_rvalid[h]),
                        .aximm_rready    (client_aximm_rready[h]),
                        .aximm_rid       (client_aximm_rid[h]),
                        .aximm_rdata     (client_aximm_rdata[h]),
                        .aximm_rresp     (client_aximm_rresp[h]),
                        .aximm_rlast     (client_aximm_rlast[h])
                        
    );

    assign rd_rx_fifo  [h][14:1] = 'b0;
		assign wr_tx_fifo  [h][14:1] = 'b0;
		assign din_tx_fifo [h][14:1] = 'b0;
    
  `ifndef PCIE_BRIDGE   
    assign direct_desc_rx_ack[h]  = 'b0; 
    assign direct_desc_rx_ws[h]   = 'b0;
    assign direct_desc_rx_eof[h]  = 'b0;
    assign direct_desc_tx_req[h]  = 'b0;
    assign direct_desc_tx_desc[h] = 'b0;
    assign direct_desc_tx_data[h] = 'b0;
    assign direct_desc_tx_dfr[h]  = 'b0;
  `endif         

    end // for
  end // :IOSF Primary
  endgenerate
// End of IOSF Primary/
//
//
//
  
//*******************************************************************************************
//---------------------------------END OF DDR TRANSACTOR-----------------------------------
   generate
    if (NUM_OF_ADDITIONAL_COMM_BLOCKS == 1)
    begin: ADDITIONAL_COMM_BLOCK_0
    
    `include "Additional_COMM_Blocks_0_XMR.sv"
    
    end
 endgenerate
 
   generate
    if (NUM_OF_ADDITIONAL_COMM_BLOCKS == 2)
    begin: ADDITIONAL_COMM_BLOCK_1
    
    `include "Additional_COMM_Blocks_0_XMR.sv"
    `include "Additional_COMM_Blocks_1_XMR.sv"
    
    end
 endgenerate
 
   generate
    if (NUM_OF_ADDITIONAL_COMM_BLOCKS == 3)
    begin: ADDITIONAL_COMM_BLOCK_2
    
    `include "Additional_COMM_Blocks_0_XMR.sv"
    `include "Additional_COMM_Blocks_1_XMR.sv"
    `include "Additional_COMM_Blocks_2_XMR.sv"
    
    end
 endgenerate
 
   generate
    if (NUM_OF_ADDITIONAL_COMM_BLOCKS == 4)
    begin: ADDITIONAL_COMM_BLOCK_3
    
    `include "Additional_COMM_Blocks_0_XMR.sv"
    `include "Additional_COMM_Blocks_1_XMR.sv"
    `include "Additional_COMM_Blocks_2_XMR.sv"
    `include "Additional_COMM_Blocks_3_XMR.sv" 
    
    end
 endgenerate
 
   generate
    if (NUM_OF_ADDITIONAL_COMM_BLOCKS == 5)
    begin: ADDITIONAL_COMM_BLOCK_4
    
    `include "Additional_COMM_Blocks_0_XMR.sv"
    `include "Additional_COMM_Blocks_1_XMR.sv"
    `include "Additional_COMM_Blocks_2_XMR.sv"
    `include "Additional_COMM_Blocks_3_XMR.sv"
    `include "Additional_COMM_Blocks_4_XMR.sv"
    
    end
 endgenerate
 
    generate
    if (NUM_OF_ADDITIONAL_COMM_BLOCKS == 6)
    begin: ADDITIONAL_COMM_BLOCK_5
    
    `include "Additional_COMM_Blocks_0_XMR.sv"
    `include "Additional_COMM_Blocks_1_XMR.sv"
    `include "Additional_COMM_Blocks_2_XMR.sv"
    `include "Additional_COMM_Blocks_3_XMR.sv"
    `include "Additional_COMM_Blocks_4_XMR.sv"
    `include "Additional_COMM_Blocks_5_XMR.sv"
    
    end
 endgenerate

	 
//rgoura end
`ifndef ALTERA_BOARD
`ifdef FPGA_SYNTH

  generate
    if (ENABLE_ILA == 1)
    begin: ILA_TRANSACTORS
      ILA_transactors #(
        .NUM_OF_DUMMY_TRANSACTOR        (NUM_OF_DUMMY_TRANSACTOR   	 ), 	 
        .NUM_OF_CXL_CACHE_HOST   		(NUM_OF_CXL_CACHE_HOST   		 ),
        .NUM_OF_CXL_CACHE_DEVICE        (NUM_OF_CXL_CACHE_DEVICE     ),
        .NUM_OF_CXL_MEM_MASTER     	    (NUM_OF_CXL_MEM_MASTER     	 ),
        .NUM_OF_CXL_MEM_SLAVE      	    (NUM_OF_CXL_MEM_SLAVE      	 ),  
        //.NUM_OF_C2U_IDI_TRANSACTOR 	    (NUM_OF_C2U_IDI_TRANSACTOR 	 ),
       // .NUM_OF_CMI_REQ_TRANSACTOR 	    (NUM_OF_CMI_REQ_TRANSACTOR 	 ),
        //.NUM_OF_CMI_RSP_TRANSACTOR 	    (NUM_OF_CMI_RSP_TRANSACTOR 	 ),
        .NUM_OF_UFI_1_FABRIC            (NUM_OF_UFI_1_FABRIC           ),
        .NUM_OF_UFI_1_AGENT             (NUM_OF_UFI_1_AGENT            ),
        .NUM_OF_ICXL_HOST	        	(NUM_OF_ICXL_HOST			 	     ),
        .NUM_OF_ICXL_DEVICE             (NUM_OF_ICXL_DEVICE          ),  
        //.NUM_OF_SB_TRANSACTOR              (NUM_OF_SB_TRANSACTOR),

        .START_OF_DUMMY                 (START_OF_DUMMY           ),
        .START_OF_CXL_CACHE_HOST        (START_OF_CXL_CACHE_HOST  ),
        .START_OF_CXL_MEM_MASTER        (START_OF_CXL_MEM_MASTER  ),
        .START_OF_CXL_CACHE_DEVICE      (START_OF_CXL_CACHE_DEVICE),
        .START_OF_CXL_MEM_SLAVE         (START_OF_CXL_MEM_SLAVE   ),
       // .START_OF_CMI_REQ               (START_OF_CMI_REQ         ),
       // .START_OF_CMI_RSP               (START_OF_CMI_RSP         ),
        .START_OF_UFI_1_FABRIC          (START_OF_UFI_1_FABRIC      ),
        .START_OF_UFI_1_AGENT           (START_OF_UFI_1_AGENT       ),
        .START_OF_ICXL_HOST             (START_OF_ICXL_HOST       ),
        .START_OF_ICXL_DEVICE           (START_OF_ICXL_DEVICE     )//,
      //  .START_OF_SB_TRANSACTOR          (START_OF_SB_TRANSACTOR)
      )
      ILA_transactors_inst
      (
        .user_clk         (user_clk),
        .client_clk       (client_clk),
        .client_rst_n     (client_rst_n),

        .ufi_fabric_aximm_debug_port_wire (ufi_fabric_aximm_debug_port_wire),
        .ufi_fabric_ufi_debug_port_wire   (ufi_fabric_ufi_debug_port_wire  )
      /*synthesis syn_noprun=1*//*synthesis syn_keep=1*/
      );
    end
 endgenerate

`endif
`endif


`endif  //COLLAGE_COMPILE

endmodule 



