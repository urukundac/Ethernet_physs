
////////// USER MUST EDIT THE FOLLOWING LINES /////////////

		`define TRANSACTORS_PATH `FPGA_TRANSACTORS_TOP
		
	
		//THIS IS THE ORDER OF THE TRANSACTORS!!
		
		parameter NUM_OF_DUMMY_TRANSACTOR   		= 0;    //HAS 1 RX FIFO AND 1 TX FIFO  //SHOULD BE USED ONLY FOR DEVELOPMENT 
		parameter NUM_OF_CXL_CACHE_HOST  			= 0;	//HAS 5 RX FIFO AND 5 TX FIFO  
		parameter NUM_OF_CXL_MEM_MASTER 			= 0;	//HAS 2 RX FIFO AND 2 TX FIFO
		parameter NUM_OF_CXL_CACHE_DEVICE  			= 0;    //HAS 5 RX FIFO AND 5 TX FIFO  //SHOULD BE USED ONLY FOR DEVELOPMENT
		parameter NUM_OF_CXL_MEM_SLAVE 				= 0;	//HAS 2 RX FIFO AND 2 TX FIFO  //SHOULD BE USED ONLY FOR DEVELOPMENT 
		parameter NUM_OF_UFI_1_FABRIC			 	= 0;	//HAS 3 RX FIFO AND 3 TX FIFO
		parameter NUM_OF_UFI_1_AGENT			 	= 0;	//HAS 3 RX FIFO AND 3 TX FIFO  //SHOULD BE USED ONLY FOR DEVELOPMENT
		parameter NUM_OF_ICXL_HOST			 		= 0;	//HAS 4 RX FIFO AND 4 TX FIFO
		parameter NUM_OF_ICXL_DEVICE		 		= 0;	//HAS 4 RX FIFO AND 4 TX FIFO  //SHOULD BE USED ONLY FOR DEVELOPMENT	
		parameter NUM_OF_SB_AGENT_TRANSACTOR    	= 0;    //HAS 1 RX FIFO AND 1 TX FIFO
		parameter NUM_OF_SB_FABRIC_TRANSACTOR   	= 0;    //HAS 1 RX FIFO AND 1 TX FIFO
		parameter NUM_OF_TEMPLATE_TRANSACTOR    	= 0;    //HAS user defined amount of RX FIFO AND user defined amount of TX FIFO  UP TO 15 FIFOS FROM EACH KIND!!!
		parameter NUM_OF_AXIM_SLAVE_TRANSACTOR 		= 0;    //HAS 3 RX FIFO AND 4 TX FIFO     
		parameter NUM_OF_AXIM_MASTER_TRANSACTOR 	= 0;	//HAS 4 RX FIFO AND 3 TX FIFO
		parameter NUM_OF_GPIO_TRANSACTOR 			= 0;	//HAS 1 RX FIFO AND 1 TX FIFO
		parameter NUM_OF_AUX_TRANSACTOR 			= 0;	//HAS 1 RX FIFO AND 1 TX FIFO
		parameter NUM_OF_APB_MASTER_TRANSACTOR 		= 0; 	//HAS 1 RX FIFO AND 1 TX FIFO
		parameter NUM_OF_APB_SLAVE_TRANSACTOR 		= 0; 	//HAS 1 RX FIFO AND 1 TX FIFO
		parameter NUM_OF_CFI_TRANSACTOR 			= 0;	//HAS 4 RX FIFO AND 4 TX FIFO
		parameter NUM_OF_DDR_BACKDOOR_TRANSACTOR	= 0;	//HAS 0 RX FIFO AND 0 TX FIFO 
		parameter NUM_OF_UFI_2_FABRIC			 	= 0;	//HAS 3 RX FIFO AND 3 TX FIFO
		parameter NUM_OF_UFI_2_AGENT			 	= 0;	//HAS 3 RX FIFO AND 3 TX FIFO  //SHOULD BE USED ONLY FOR DEVELOPMENT
		parameter NUM_OF_CXL_CACHE_V3_HOST  		= 0;    //HAS 6 RX FIFO AND 5 TX FIFO  
		parameter NUM_OF_CXL_CACHE_V3_DEVICE 		= 0;	//HAS 5 RX FIFO AND 6 TX FIFO  //SHOULD BE USED ONLY FOR DEVELOPMENT
    parameter NUM_OF_CXL_G_FABRIC     			    = 0;
		parameter NUM_OF_CXL_G_AGENT   				      = 0;
		parameter NUM_OF_DDI_TRANSACTOR      		= 0; 	//HAS 0 RX FIFO AND 0 TX FIFO  //SHOULD BE USED ONLY FOR DEVELOPMENT
		parameter NUM_OF_SFI_TRANSACTOR				= 1;	//HAS 4 RX FIFO AND 4 TX FIFO
		parameter NUM_OF_IOSF_P_TRANSACTOR   		= 0;	//HAS 1 RX FIFO AND 1 TX FIFO
		parameter NUM_OF_ADDITIONAL_COMM_BLOCKS 	= 0;	//HAS user defined amount of RX FIFO AND user defined amount of TX FIFO.  UP TO 14 FIFOS FROM EACH KIND!!!
	 
		parameter NUM_OF_COMM_BLOCK_USED_FOR_DIRECT = 0;	//the number of comm block that will be used for direct operation
    parameter        USE_ALTERA_PHY_IN_BRIDGE                      =1; 
	  parameter  logic [127:0] PCIE_BRIDGE_PHY_TYPE = (USE_ALTERA_PHY_IN_BRIDGE==1)? "STRATIX10M" : "HAPS_80";//"STRATIX10M"; 
		parameter 		AXIM_LOOPBACK        					= 0;
		parameter int 	AXIM_MASTER_ADDR_COMMAND_WIDTH 	[3:0]  	= {128,128,128,128};
		parameter int 	AXIM_SLAVE_ADDR_COMMAND_WIDTH 	[3:0] 	= {128,128,128,128};
		parameter int   AXI_MASTER_DATA_WIDTH			[3:0]  	= {128,128,128,1024};
		parameter int   AXI_SLAVE_DATA_WIDTH 			[3:0] 	= {128,128,128,1024};

		parameter int 	MISORDER_TEST               			= 0;
		
		parameter 		APB_LOOPBACK   							= 0;
		
		parameter 		SFI_LOOPBACK         					= 0;

		parameter 		CFI_LOOPBACK         					= 0;
		parameter int	CFI_AGENT_MODE 					[3:0]   = {0,0,1,0};		// 1=agent.  0= fabric each bit is for a seperate instnce of CFI_TRANSACTOR
		parameter int 	CFI_EARLY_DELAY             	  		= 1;

	  parameter int   CXL_G_MAX_CREDITS               = 12;

		parameter 		GPIO_LOOPBACK           				= 0;
		parameter     	UFI_2_LOOPBACK                  		= 0;
		parameter     	IOSF_P_LOOPBACK                 		= 0;
		//		parameter int  	RESET_VALUE_GPIO        		[3:0]  	= {128'b0,128'b0,128'b0,128'b0};
		parameter int  	RESET_VALUE_GPIO        		[3:0]  	= {'b0,'b0,'b0,'b0}; 
		parameter int	IOSF_FIP_IS_FABRIC 				[3:0]  	= {0,0,0,1}; 	//0 = FIP is agent, 1 = FIP is fabric

    `include "IOSF_P_param.sv"
 
	//	parameter NUM_OF_C2U_IDI_TRANSACTOR   	= 0;    //0>=NUM_OF_C2U_IDI_TRANSACTOR<=15
	//	parameter NUM_OF_CMI_REQ_TRANSACTOR   	= 0;    //0>=NUM_OF_CMI_REQ_TRANSACTOR<=15
	//	parameter NUM_OF_CMI_RSP_TRANSACTOR   	= 0;    //0>=NUM_OF_CMI_RSP_TRANSACTOR<=15


  `ifdef FPGA_SYNTH //non DPI (HVCS) and non-sim
    	parameter int  	NUM_OF_GPIO_IN          		[3:0]  	= {128,128,128,128};
	  	parameter int  	NUM_OF_GPIO_OUT         		[3:0]  	= {128,128,128,128};
      parameter int   DDI_GENERATOR               [3:0]   = {1,1,1,1};
	  	parameter int   DDI_NUM_EMBEDDED_PORTS      [3:0]   = {1,1,1,1};
      parameter int   DDI_NUM_LANES               [3:0]   = {1,1,1,1};
 
		//USER MUST SET THIS PARAMETER ACCORDING TO THE TRANSACTORS HE CONFIGURED
		parameter bit[3:0] NUM_OF_TX_FIFO [14:0] = { 	4'd0, //for communication block 14
														4'd0, //for communication block 13
														4'd0, //for communication block 12
														4'd0, //for communication block 11
														4'd0, //for communication block 10
														4'd0, //for communication block 9
														4'd0, //for communication block 8
														4'd0, //for communication block 7
														4'd0, //for communication block 6
														4'd0, //for communication block 5
														4'd0, //for communication block 4
														4'd0, //for communication block 3
														4'd0, //for communication block 2
														4'd0, //for communication block 1 
														4'd4  //for communication block 0
                                                    };
		
		//USER MUST SET THIS PARAMETER ACCORDING TO THE TRANSACTORS HE CONFIGURED
        parameter bit[3:0]  NUM_OF_RX_FIFO [14:0] = {  	4'd0, //for communication block 14
														4'd0, //for communication block 13
														4'd0, //for communication block 12
														4'd0, //for communication block 11
														4'd0, //for communication block 10
														4'd0, //for communication block 9
														4'd0, //for communication block 8
														4'd0, //for communication block 7
														4'd0, //for communication block 6
														4'd0, //for communication block 5
														4'd0, //for communication block 4
														4'd0, //for communication block 3
														4'd0, //for communication block 2
														4'd0, //for communication block 1
														4'd4  //for communication block 0
                                                    };
                                                    
         parameter bit [4:0] UFI_1_CREDIT_ID [15:0]  = {5'b0, 
                                                      5'b0,
                                                      5'b0, 
                                                      5'b0,
                                                      5'b0, 
                                                      5'b0,
                                                      5'b0, 
                                                      5'b0,
                                                      5'b11100,
                                                      5'b11000,
                                                      5'b10100, 
                                                      5'b10000,
                                                      5'b01100, 
                                                      5'b01000,
                                                      5'b00100, 
                                                      5'b00000};

			//THE FOLLOWING PARAMETER IS ONLY RELAVENT FOR UFI_2_LOOPBACK MODE
			// vc_id(4bits), protocol_id(2bits)   //CREDITS enabled
			// Protocol ID: 00 - IDI
			//				01 - UXI.C & UXI.NC
			//				10 - CXL.MEM (=UXI.MEM)
			//				11 - NULL
         parameter bit [5:0] UFI_2_CREDIT_ID [15:0]  = {6'b0, 	//THIS IS ONLY RELAVENT FOR UFI_2_LOOPBACK MODE
                                                      6'b0,
                                                      6'b0, 
                                                      6'b0,
                                                      6'b0, 
                                                      6'b0,
                                                      6'b0, 
                                                      6'b0,
                                                      6'b011100,
                                                      6'b011000,
                                                      6'b010100, 
                                                      6'b010000,
                                                      6'b001100, 
                                                      6'b001000,
                                                      6'b000100, 
                                                      6'b000000};
                                   
     `endif

			parameter  UFI_1_COUNT_MAX                 		= 5'd12;   	//max value of credit counter
			parameter  UFI_1_NUM_OF_CREDIT_CH          		= 8;      	//Number of credit channels enabled from the UFI_CREDIT_ID list (from bottom to top)

			parameter  UFI_2_COUNT_MAX                 		= 5'd12;   	//max value of credit counter

			//THE FOLLOWING PARAMETER IS ONLY RELAVENT FOR UFI_2_LOOPBACK MODE
			parameter  UFI_2_NUM_OF_CREDIT_CH          		= 6;      	//THIS IS ONLY RELAVENT FOR UFI_2_LOOPBACK MODE  
																		//Number of credit channels enabled from the UFI_CREDIT_ID list (from bottom to top)
			
			parameter int CFI_COUNT_MAX                 	= 5'd12;	//max value of credit counter	
		
			parameter int SB_AGENT_MAXPLDBIT_SRC_0  		= 31;     // The options are 7, 15 and 31.
			parameter int SB_AGENT_MAXPLDBIT_SRC_1  		= 31;
			parameter int SB_AGENT_MAXPLDBIT_SRC_2  		= 31;
			parameter int SB_AGENT_MAXPLDBIT_SRC_3  		= 31;
			parameter int SB_AGENT_MAXPLDBIT_SRC_4  		= 31;
			parameter int SB_AGENT_MAXPLDBIT_SRC_5  		= 31;  
		
			parameter int SB_FABRIC_MAXPLDBIT_SRC_0  		= 31;     // The options are 7, 15 and 31.
			parameter int SB_FABRIC_MAXPLDBIT_SRC_1  		= 31;
			parameter int SB_FABRIC_MAXPLDBIT_SRC_2  		= 31;
			parameter int SB_FABRIC_MAXPLDBIT_SRC_3  		= 31;
			parameter int SB_FABRIC_MAXPLDBIT_SRC_4  		= 31;
			parameter int SB_FABRIC_MAXPLDBIT_SRC_5  		= 31;  
			
			parameter int SB_AGENT_SUPPORT_HSB_AND_SSB_0	= 0; 
			parameter int SB_AGENT_SUPPORT_HSB_AND_SSB_1	= 0;
			parameter int SB_AGENT_SUPPORT_HSB_AND_SSB_2	= 0;
			parameter int SB_AGENT_SUPPORT_HSB_AND_SSB_3	= 0;
			parameter int SB_AGENT_SUPPORT_HSB_AND_SSB_4	= 0;
			parameter int SB_AGENT_SUPPORT_HSB_AND_SSB_5	= 0;
			
			parameter int SB_FABRIC_SUPPORT_HSB_AND_SSB_0	= 0; 
			parameter int SB_FABRIC_SUPPORT_HSB_AND_SSB_1	= 0;
			parameter int SB_FABRIC_SUPPORT_HSB_AND_SSB_2	= 0;
			parameter int SB_FABRIC_SUPPORT_HSB_AND_SSB_3	= 0;
			parameter int SB_FABRIC_SUPPORT_HSB_AND_SSB_4	= 0;
			parameter int SB_FABRIC_SUPPORT_HSB_AND_SSB_5	= 0;
			
			parameter int SFI_D_SRC_0  						= 64;     // The options are 64 and 128.
			parameter int SFI_D_SRC_1  						= 64;
			parameter int SFI_D_SRC_2  						= 64;
			parameter int SFI_D_SRC_3  						= 64;
			parameter int SFI_D_SRC_4  						= 64;
			parameter int SFI_D_SRC_5  						= 64; 
			
			parameter int TEMPLATE_INPUT_PORT_WIDTH_SRC_0  	= 31;     // The options are 1-512.
			parameter int TEMPLATE_INPUT_PORT_WIDTH_SRC_1  	= 31;
			parameter int TEMPLATE_INPUT_PORT_WIDTH_SRC_2  	= 31;
			parameter int TEMPLATE_INPUT_PORT_WIDTH_SRC_3  	= 31;
			parameter int TEMPLATE_INPUT_PORT_WIDTH_SRC_4  	= 31;
			parameter int TEMPLATE_INPUT_PORT_WIDTH_SRC_5  	= 31;   
			
			parameter int TEMPLATE_OUTPUT_PORT_WIDTH_SRC_0  = 31;     // The options are 1-512.
			parameter int TEMPLATE_OUTPUT_PORT_WIDTH_SRC_1  = 31;
			parameter int TEMPLATE_OUTPUT_PORT_WIDTH_SRC_2  = 31;
			parameter int TEMPLATE_OUTPUT_PORT_WIDTH_SRC_3  = 31;
			parameter int TEMPLATE_OUTPUT_PORT_WIDTH_SRC_4  = 31;
			parameter int TEMPLATE_OUTPUT_PORT_WIDTH_SRC_5  = 31; 		
			
			parameter LOCAL_BUS_IS_28b						= "FALSE"; //defines if BAR 2 will be 28b address or 24b address
				 
		                                          
 /////  USER SHOULDN'T TOUCH THE FOLLOWING LINES  ////////////    USER SHOULDN'T TOUCH THE FOLLOWING LINES        ///////////////////////////////////////////////////////////////////////////////
																																															////                                                   
                
      //	`ifdef GTC_DPI	|| ifdef SIM
       `ifndef FPGA_SYNTH     //targets HVCS and AV sims     
       parameter int GPIO_OUT_0 = 128;
       parameter int GPIO_OUT_1 = 128;
       parameter int GPIO_OUT_2 = 128;
       parameter int GPIO_OUT_3 = 128;
       parameter int  	NUM_OF_GPIO_OUT         		[3:0]  	= {GPIO_OUT_3,GPIO_OUT_2,GPIO_OUT_1,GPIO_OUT_0};
       parameter int GPIO_IN_0 = 128;
       parameter int GPIO_IN_1 = 128;
       parameter int GPIO_IN_2 = 128;
       parameter int GPIO_IN_3 = 128;
  		 parameter int  	NUM_OF_GPIO_IN          		[3:0]  	= {GPIO_IN_3,GPIO_IN_2,GPIO_IN_1,GPIO_IN_0};
       parameter int   DDI_GENERATOR_0  = 1;
       parameter int   DDI_GENERATOR_1  = 1;
       parameter int   DDI_GENERATOR_2  = 1;
       parameter int   DDI_GENERATOR_3  = 1;
       parameter int   DDI_GENERATOR          		[3:0]  	= {DDI_GENERATOR_3,DDI_GENERATOR_2,DDI_GENERATOR_1,DDI_GENERATOR_0};
		   parameter int   DDI_NUM_EMBEDDED_PORTS_0 = 1;
       parameter int   DDI_NUM_EMBEDDED_PORTS_1 = 1;
       parameter int   DDI_NUM_EMBEDDED_PORTS_2 = 1;
       parameter int   DDI_NUM_EMBEDDED_PORTS_3 = 1;
       parameter int   DDI_NUM_EMBEDDED_PORTS     [3:0]    = {DDI_NUM_EMBEDDED_PORTS_3,DDI_NUM_EMBEDDED_PORTS_2,DDI_NUM_EMBEDDED_PORTS_1,DDI_NUM_EMBEDDED_PORTS_0};
       parameter int   DDI_NUM_LANES_0  = 1;
       parameter int   DDI_NUM_LANES_1  = 1;
       parameter int   DDI_NUM_LANES_2  = 1;
       parameter int   DDI_NUM_LANES_3  = 1;
       parameter int   DDI_NUM_LANES              [3:0]    = {DDI_NUM_LANES_3,DDI_NUM_LANES_2,DDI_NUM_LANES_1,DDI_NUM_LANES_0};
       parameter bit[31:0] NUM_OF_TX_FIFO_TEST_LOW  = 32'd1; //concatenated communication blocks - can't override unpacked arrays from command line
       parameter bit[27:0] NUM_OF_TX_FIFO_TEST_HIGH  = 32'd0; //concatenated communication blocks - can't override unpacked arrays from command line     
       parameter bit[31:0] NUM_OF_RX_FIFO_TEST_LOW  = 32'd1; //concatenated communication blocks - can't override unpacked arrays from command line
       parameter bit[27:0] NUM_OF_RX_FIFO_TEST_HIGH  = 28'd0; //concatenated communication blocks - can't override unpacked arrays from command line 
       parameter bit[31:0] UFI_1_CREDIT_ID_TEST_LOW = 'h00000000;
       parameter bit[31:0] UFI_1_CREDIT_ID_TEST_MID = 'h00000000;
       parameter bit[16:0] UFI_1_CREDIT_ID_TEST_HIGH= 'h00000000;
       parameter bit[4:0]  UFI_1_CREDIT_ID [15:0]  =   {
                                                     UFI_1_CREDIT_ID_TEST_HIGH [15:11],// vc_id(3bits),protocol_id(2bits)          
                                                     UFI_1_CREDIT_ID_TEST_HIGH [10:6],   //for communication block 14
                                                     UFI_1_CREDIT_ID_TEST_HIGH [5:1],   //for communication block 13
                                                     {UFI_1_CREDIT_ID_TEST_HIGH  [0:0], UFI_1_CREDIT_ID_TEST_MID  [31:28]}, //for communication block 10
                                                     UFI_1_CREDIT_ID_TEST_MID  [27:23],   //for communication block 9
                                                     UFI_1_CREDIT_ID_TEST_MID  [22:18],   //for communication block 8
                                                     UFI_1_CREDIT_ID_TEST_MID  [17:13],    //for communication block 7                                              
                                                     UFI_1_CREDIT_ID_TEST_MID  [12:8],    //for communication block 6
                                                     UFI_1_CREDIT_ID_TEST_MID  [7:3],    //for communication block 6
                                                     {UFI_1_CREDIT_ID_TEST_MID  [2:0],UFI_1_CREDIT_ID_TEST_LOW  [31:30]}, //for communication block 5
                                                     UFI_1_CREDIT_ID_TEST_LOW  [29:25],   //for communication block 4
                                                     UFI_1_CREDIT_ID_TEST_LOW  [24:20],   //for communication block 3
                                                     UFI_1_CREDIT_ID_TEST_LOW  [19:15],   //for communication block 2
                                                     UFI_1_CREDIT_ID_TEST_LOW  [14:10],    //for communication block 1
                                                     UFI_1_CREDIT_ID_TEST_LOW  [9:5],    //for communication block 1
                                                     UFI_1_CREDIT_ID_TEST_LOW  [4:0]};    //for communication block 0

       parameter bit[31:0] UFI_2_CREDIT_ID_TEST_LOW = 'h00000000;
       parameter bit[31:0] UFI_2_CREDIT_ID_TEST_MID = 'h00000000;
       parameter bit[31:0] UFI_2_CREDIT_ID_TEST_HIGH= 'h00000000;
       parameter bit[5:0] UFI_2_CREDIT_ID [15:0]  =   {UFI_2_CREDIT_ID_TEST_HIGH [31:26],// vc_id(3bits),protocol_id(2bits)          
                                                     UFI_2_CREDIT_ID_TEST_HIGH [25:20],   //for communication block 14
                                                     UFI_2_CREDIT_ID_TEST_HIGH [19:14],   //for communication block 13
                                                     UFI_2_CREDIT_ID_TEST_HIGH  [13:8],    //for communication block 12
                                                     UFI_2_CREDIT_ID_TEST_HIGH  [7:2],   //for communication block 11
                                                     {UFI_2_CREDIT_ID_TEST_HIGH  [1:0], UFI_2_CREDIT_ID_TEST_MID  [31:28]}, //for communication block 10
                                                     UFI_2_CREDIT_ID_TEST_MID  [27:22],   //for communication block 9
                                                     UFI_2_CREDIT_ID_TEST_MID  [21:16],   //for communication block 8
                                                     UFI_2_CREDIT_ID_TEST_MID  [15:10],    //for communication block 7                                                     
                                                     UFI_2_CREDIT_ID_TEST_MID  [9:4],    //for communication block 6
                                                     {UFI_2_CREDIT_ID_TEST_MID  [3:0],UFI_2_CREDIT_ID_TEST_LOW  [31:30]}, //for communication block 5
                                                     UFI_2_CREDIT_ID_TEST_LOW  [29:24],   //for communication block 4
                                                     UFI_2_CREDIT_ID_TEST_LOW  [23:18],   //for communication block 3
                                                     UFI_2_CREDIT_ID_TEST_LOW  [17:12],   //for communication block 2
                                                     UFI_2_CREDIT_ID_TEST_LOW  [11:6],    //for communication block 1
                                                     UFI_2_CREDIT_ID_TEST_LOW  [5:0]};    //for communication block 0

       parameter bit[31:0] CFI_CREDIT_ID_TEST_LOW = 'h00000000;
       parameter bit[31:0] CFI_CREDIT_ID_TEST_MID = 'h00000000;
       parameter bit[16:0] CFI_CREDIT_ID_TEST_HIGH= 'h00000000;
       parameter bit [4:0] CFI_CREDIT_ID [15:0]  =   { // vc_id(3bits),protocol_id(2bits)                                                    
                                                     CFI_CREDIT_ID_TEST_HIGH [15:11],   //for communication block 9
                                                     CFI_CREDIT_ID_TEST_HIGH [10:6],   //for communication block 8
                                                     CFI_CREDIT_ID_TEST_MID  [5:1], //for communication block 6
                                                     {CFI_CREDIT_ID_TEST_HIGH  [0:0],CFI_CREDIT_ID_TEST_MID  [31:28]}, //for communication block 5
                                                     CFI_CREDIT_ID_TEST_MID  [27:23], //for communication block 4
                                                     CFI_CREDIT_ID_TEST_MID  [22:18], //for communication block 3
                                                     CFI_CREDIT_ID_TEST_MID  [17:13], //for communication block 2
                                                     CFI_CREDIT_ID_TEST_MID  [12:8],   //for communication block 1
                                                     CFI_CREDIT_ID_TEST_MID  [7:3],   //for communication block 0                                                     
                                                     {CFI_CREDIT_ID_TEST_MID  [2:0],CFI_CREDIT_ID_TEST_LOW  [31:30]}, //for communication block 6
                                                     CFI_CREDIT_ID_TEST_LOW  [29:25], //for communication block 5
                                                     CFI_CREDIT_ID_TEST_LOW  [24:20], //for communication block 4
                                                     CFI_CREDIT_ID_TEST_LOW  [19:15], //for communication block 3
                                                     CFI_CREDIT_ID_TEST_LOW  [14:10], //for communication block 2
                                                     CFI_CREDIT_ID_TEST_LOW  [9:5],   //for communication block 1
                                                     CFI_CREDIT_ID_TEST_LOW  [4:0]};  //for communication block 0

       parameter bit[3:0]  NUM_OF_TX_FIFO [14:0] =  {NUM_OF_TX_FIFO_TEST_HIGH[27:24],//for communication block 14
                                                     NUM_OF_TX_FIFO_TEST_HIGH[23:20],//for communication block 13
                                                     NUM_OF_TX_FIFO_TEST_HIGH[19:16],//for communication block 12
                                                     NUM_OF_TX_FIFO_TEST_HIGH[15:12],//for communication block 11
                                                     NUM_OF_TX_FIFO_TEST_HIGH[11:8],//for communication block 10
                                                     NUM_OF_TX_FIFO_TEST_HIGH[7:4],//for communication block 9
                                                     NUM_OF_TX_FIFO_TEST_HIGH[3:0],//for communication block 8
                                                     NUM_OF_TX_FIFO_TEST_LOW[31:28],//for communication block 7
                                                     NUM_OF_TX_FIFO_TEST_LOW[27:24],//for communication block 6
                                                     NUM_OF_TX_FIFO_TEST_LOW[23:20],//for communication block 5
                                                     NUM_OF_TX_FIFO_TEST_LOW[19:16],//for communication block 4
                                                     NUM_OF_TX_FIFO_TEST_LOW[15:12],//for communication block 3
                                                     NUM_OF_TX_FIFO_TEST_LOW[11:8], //for communication block 2
                                                     NUM_OF_TX_FIFO_TEST_LOW[7:4],  //for communication block 1
                                                     NUM_OF_TX_FIFO_TEST_LOW[3:0]};//for communication block 0

			parameter bit[3:0]  NUM_OF_RX_FIFO [14:0] =	  {NUM_OF_RX_FIFO_TEST_HIGH[27:24],//for communication block 14
                                                     NUM_OF_RX_FIFO_TEST_HIGH[23:20],//for communication block 13
                                                     NUM_OF_RX_FIFO_TEST_HIGH[19:16],//for communication block 12
                                                     NUM_OF_RX_FIFO_TEST_HIGH[15:12],//for communication block 11
                                                     NUM_OF_RX_FIFO_TEST_HIGH[11:8],//for communication block 10
                                                     NUM_OF_RX_FIFO_TEST_HIGH[7:4],//for communication block 9
                                                     NUM_OF_RX_FIFO_TEST_HIGH[3:0],//for communication block 8
                                                     NUM_OF_RX_FIFO_TEST_LOW[31:28],//for communication block 7
                                                     NUM_OF_RX_FIFO_TEST_LOW[27:24],//for communication block 6
                                                     NUM_OF_RX_FIFO_TEST_LOW[23:20],//for communication block 5
                                                     NUM_OF_RX_FIFO_TEST_LOW[19:16],//for communication block 4
                                                     NUM_OF_RX_FIFO_TEST_LOW[15:12],//for communication block 3
                                                     NUM_OF_RX_FIFO_TEST_LOW[11:8], //for communication block 2
                                                     NUM_OF_RX_FIFO_TEST_LOW[7:4],  //for communication block 1
                                                     NUM_OF_RX_FIFO_TEST_LOW[3:0]};//for communication block 0

    `endif
		
						

																					////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			

