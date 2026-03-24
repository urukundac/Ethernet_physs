//---------------------------------------------------------------------------------------------------------
//Filename: uhfi_params.inc
//Type: SystemVerilog Include File
//Description: List of Parameters that control the functionality of UHFI HW. 
//             User needs to modify paramter values accordingly for their project.      
//----------------------------------------------------------------------------------------------------------

//----------------------------------------------
//GMT Cluster related parameters
//----------------------------------------------
    parameter GMT_ASYNC           = 1
  , parameter GMT_D_WIDTH         = 63
  , parameter GMT_GCR_DSIZE       = 512
  , parameter GMT_MAX_ADDR        = 63
  , parameter GMT_MAX_DATA_LEN    = 9
  , parameter GMT_MDEST_ID_WIDTH  = 15
  , parameter GMT_MSRC_ID_WIDTH   = 15
  , parameter GMT_NUMCHAN         = 4'h0
  , parameter GMT_NUMCHANL2       = 4'h0
  , parameter GMT_RS_WIDTH        = 1
  , parameter GMT_SAI_WIDTH       = 6
  , parameter GMT_SB_PAYLOAD_SIZE = 7
  , parameter GMT_TDEST_ID_WIDTH  = 15
  , parameter GMT_TSRC_ID_WIDTH   = 15
  //Select the FIFO databus size depending on GMT transport
  //Collage won't let you export a parameter string. So please use the enumerated value until this is resolved.
  //AAL_PCIE = 1
  //UMR_PCIE = 2
  //FTDI_USB = 3
  //UMR_POD  = 4
  //Default  = UMR_PCIE
  `ifdef UHFI_MT_AAL_PCIE
    , parameter GMT_FIFO_DSIZE     = 512
    , parameter GMT_TRANSPORT_TYPE = 1
  `elsif UHFI_MT_UMR_DPCIE
    , parameter GMT_FIFO_DSIZE     = 32
    , parameter GMT_TRANSPORT_TYPE = 2
  `elsif UHFI_MT_FTDI_USB
    , parameter GMT_FIFO_DSIZE     = 32
    , parameter GMT_TRANSPORT_TYPE = 3
  `else
    , parameter GMT_FIFO_DSIZE     = 32
    , parameter GMT_TRANSPORT_TYPE = 2
  `endif

//-----------------------------------------------
  
//-----------------------------------------------
//PCIe and LB2SB Cluster related parameters
//------------------------------------------------
  , parameter AGENT_PSFPORT_MAX_NUMCHAN = 0
  , parameter AGENT_PSFPORT_NUMCHAN = {16'd0,16'd0}
  , parameter AGENT_PSFPORT_NUMCHANL2 = 0
  , parameter [255:0] BDF_LIST = 256'h000000000000000000001000000000000000000FF
  //, parameter [255:0] BDF_LIST = 256'h10000000000000000000100000000000000000000
  , parameter MAXPLDBIT = 7
  , parameter [191:0] CMD_COMPARE = 192'b0
  , parameter [191:0] CMD_MASK = 192'b0
  , parameter EXPANSION_MODE = 1'h0
  , parameter EXTERNAL_CORE_FIP = 0
  , parameter FABRIC_PSFPORT_MAX_NUMCHAN = 0
  , parameter FABRIC_PSFPORT_NUMCHAN ={16'd0,16'd0}
  , parameter FABRIC_PSFPORT_NUMCHANL2 = 0
  , parameter FABRIC_PSFPORT_NUM_EXTERNAL_PIPE_STAGES = 0

  //****************************NOTE***************************************************************************************
  //IOSF_CHID_WIDTH controls the width of UHFI's channel-ID related IOSF Primary ports. 
  //IOSF_CHAN_ID_WIDTH controls the width of the channel-ID related IOSF ports of the PSF agent/fabric module inside UHFI. 
  //IOSF_CHID_WIDTH must always be equal to IOSF_CHAN_ID_WIDTH.
  //IOSF_SRC_ID_WIDTH controls the width of UHFI's src_id and dest_id related IOSF Primary ports.
  //IOSF_DST_ID_WIDTH controls the width of the src_id and dest_id related IOSF ports of the PSF agent/fabric module inside UHFI.
  //IOSF_SRC_ID_WIDTH must be equal to IOSF_DST_ID_WIDTH. User will need to adjust IOSF_FABRIC_ID_WIDTH and IOSF_PORT_ID_WIDTH values to match 
  //IOSF_SRC_ID_WIDTH and IOSF_DST_ID_WIDTH 
  //************************************************************************************************************************
  , parameter IOSF_CHID_WIDTH = 0
  , parameter IOSF_CHAN_ID_WIDTH = 0
  , parameter IOSF_FABRIC_ID_WIDTH = 3
  , parameter IOSF_PORT_ID_WIDTH = 5
  , parameter IOSF_DST_ID_WIDTH = (2 + 1 + IOSF_FABRIC_ID_WIDTH + 1 + IOSF_PORT_ID_WIDTH + 1 + IOSF_CHAN_ID_WIDTH + 1) - 1
  , parameter IOSF_SRC_ID_WIDTH = (2 + 1 + IOSF_FABRIC_ID_WIDTH + 1 + IOSF_PORT_ID_WIDTH + 1 + IOSF_CHID_WIDTH + 1) - 1
  
  , parameter IOSF_DATA_WIDTH = 1024 //uru
  , parameter IOSF_DATA_PARITY_WIDTH = 4 //uru
  , parameter IOSF_FIP_IS_ENCAPSULATED = 0
  , parameter IOSF_FIP_IS_FABRIC = 1
  //, parameter IOSF_MAX_DATA_LEN = 6
  //To support MPS= 512 DW
  , parameter IOSF_MAX_DATA_LEN = 7
  , parameter IOSF_PRI_TC_EN = 16'b1111_1111_1111_1111 //TC=7 is for UMA SRAM. set 7th bit to 0 , all other traffic classes are for HOST PLDA
  , parameter IOSF_PRI_CHNL_EN = 16'b1111_1111_1111_1111 //CHNL=2 is for UMA SRAM. set 2nd bit to 0 , all other channels are for HOST PLDA
  , parameter IOSF_SAI_WIDTH = 8
  , parameter IOSF_RS_WIDTH = 1
  , parameter IOSF_SB_IS_FABRIC = 1'h0
  , parameter indirect_device_number = 5'ha
  , parameter indirect_function_number = 3'h0
  , parameter LOCAL_IS_FABRIC = 1'h1
  , parameter [3:0] FPGA_NUMBER = 4'b0001
  , parameter BYPASS_SB_EP = 1
  , parameter UHFI_CAR_HAS_MMCM = 1
  , parameter [FABRIC_PSFPORT_MAX_NUMCHAN:0][15:0] FABRIC_PSFPORT_REQ_CREDIT_P = {(FABRIC_PSFPORT_MAX_NUMCHAN+1){16'd4}}
  , parameter [FABRIC_PSFPORT_MAX_NUMCHAN:0][15:0] FABRIC_PSFPORT_REQ_CREDIT_NP = {(FABRIC_PSFPORT_MAX_NUMCHAN+1){16'd4}}
  , parameter [FABRIC_PSFPORT_MAX_NUMCHAN:0][15:0] FABRIC_PSFPORT_REQ_CREDIT_C = {(FABRIC_PSFPORT_MAX_NUMCHAN+1){16'd4}}
  , parameter HAS_EXP_ROM = 0
  , parameter LB_NUM_OF_INTERNAL_AGENTS = 5 //2 SB + Reg File + LB GTX agent + Phantom agent
  , parameter LB_NUM_OF_ADD_AGENTS = 0
  , parameter RF_NUM_OF_INTERNAL_REGISTERS = 9 //FIP internal - do not change!!   
  , parameter RF_NUM_OF_ADD_REGISTERS = 22
  , parameter LB_NUM_OF_AGENTS = (LB_NUM_OF_INTERNAL_AGENTS + LB_NUM_OF_ADD_AGENTS)
  , parameter LB_EXT_AGENTS = (LB_NUM_OF_ADD_AGENTS == 0 ? LB_NUM_OF_ADD_AGENTS : LB_NUM_OF_ADD_AGENTS - 1)
  , parameter LB_EXT_AGENTS_DATA_WIDTH = ((LB_NUM_OF_ADD_AGENTS == 0 ? LB_NUM_OF_ADD_AGENTS + 1 : LB_NUM_OF_ADD_AGENTS)* 64) - 1
  , parameter RF_NUM_OF_REGISTERS = RF_NUM_OF_INTERNAL_REGISTERS + RF_NUM_OF_ADD_REGISTERS
  , parameter REG_FILE_PARAM = (64*(RF_NUM_OF_REGISTERS - 8)) - 1
  , parameter REG_FILE_INTERNAL_PARAM = (64*(RF_NUM_OF_REGISTERS - 7)) - 1
  , parameter BDF1_REGISTER_DEFAULT_VALUE = BDF_LIST[63:0] 
  , parameter BDF2_REGISTER_DEFAULT_VALUE = BDF_LIST[127:64] 
  , parameter BDF3_REGISTER_DEFAULT_VALUE = BDF_LIST[191:128] 
  , parameter BDF4_REGISTER_DEFAULT_VALUE = BDF_LIST[255:192]

  //Parameter to support Serial and Parallel GTX/GTH connection
  , parameter UHFI_CONN_PHY_DISABLE = 0
 
  //PLDA Gen2 Enablement
  , parameter PCIE_GEN2_EN = 0

  //Base addresses and sizes of LB Agents internal and external to UHFI   
  , parameter [31:0] RF_BASE_ADDR        = 32'h00920000
  , parameter        RF_SIZE             = 32'h00007FFF
  , parameter [31:0] SB_MB_IN_BASE_ADDR  = 32'h00930000
  , parameter        SB_MB_IN_SIZE       = 32'h00007FFF
  , parameter [31:0] SB_MB_OUT_BASE_ADDR = 32'h00940000
  , parameter        SB_MB_OUT_SIZE      = 32'h00007FFF
  , parameter [31:0] GTX_LOCAL_BASE_ADDR = 32'h01000000
  , parameter        GTX_LOCAL_SIZE      = 32'h02FFFFFF
  , parameter [31:0] PHANTOM_BASE_ADDR   = 32'h00980000
  , parameter        PHANTOM_SIZE        = 32'h00000008
  
  //Default values of internal UHFI registers 
  , parameter FPGA_VERSION_REGISTER_VALUE       = 64'h6e640061_6c6f6e65    //ASCII - LCD will show -  nd alone    - Upper line in LCD
  , parameter FPGA_PROJECT_NAME_REGISTER_VALUE  = 64'h46495000_2d537461    //ASCII - LCD will show -  FIP -sta    - Upper line in LCD
  , parameter STATUS_REGISTER_DEFAULT_VALUE     = 64'h00000000_00000000
  , parameter REPLACE_BUS_DEVICE_FUNCTION_VALUE = 64'h00000000_00000000  
  , parameter CONFIG_REGISTER_DEFAULT_VALUE     = 64'h00000000_00000001  

  , parameter EXTRA_BITS_FOR_BPI_FLASH = 64'h00000000_00000000 

  , parameter CMD_COMPARE_DEFAULT_VALUE_1 = CMD_COMPARE[63:0] 
  , parameter CMD_COMPARE_DEFAULT_VALUE_2 = CMD_COMPARE[127:64] 
  , parameter CMD_COMPARE_DEFAULT_VALUE_3 = CMD_COMPARE[191:128]

  , parameter CMD_MASK_DEFAULT_VALUE_1 = CMD_MASK[63:0]
  , parameter CMD_MASK_DEFAULT_VALUE_2 = CMD_MASK[127:64]
  , parameter CMD_MASK_DEFAULT_VALUE_3 = CMD_MASK[191:128]

  , parameter CMPL_COMPARE_DEFAULT_VALUE = 64'h00000000_00000000

  , parameter  DDMA_ADDRESS_RANGE_BASE_DEFAULT_VALUE_1  =  64'h00000000_00000000
  , parameter  DDMA_ADDRESS_RANGE_LIMIT_DEFAULT_VALUE_1 =  64'h00000000_00000000
  , parameter  DDMA_ADDRESS_RANGE_BASE_DEFAULT_VALUE_0  =  64'h00000000_00000000
  , parameter  DDMA_ADDRESS_RANGE_LIMIT_DEFAULT_VALUE_0 =  64'h00000000_00000000
  , parameter  DDMA_ADDRESS_RANGE_STATIC_OFFSET_DEFAULT_VALUE = 64'h00000000_00000000
  , parameter  DDMA_CONTROL_DEFAULT_VALUE = 64'h00000000_00000000
  , parameter  DDMA_SRC_IDs_DEFAULT_VALUE  = 64'h00000000_00000000


  //DDMA IOSF Fields Register
  , parameter DDMA_FMT_TYPE_MASK_DEFAULT_VALUE        = 64'h00000000_00000000      
  , parameter DDMA_SAI_RS_TC_CHNL_MASK_DEFAULT_VALUE  = 64'h00000000_00000000
  , parameter DDMA_DEST_IDS_MASK_DEFAULT_VALUE        = 64'h00000000_00000000      
  , parameter DDMA_SRC_IDS_MASK_DEFAULT_VALUE         = 64'h00000000_00000000       
  , parameter DDMA_FMT_TYPE_DEFAULT_VALUE             = 64'h00000000_00000000           
  , parameter DDMA_SAI_RS_TC_CHNL_DEFAULT_VALUE       = 64'h00000000_00000000     
  , parameter DDMA_DEST_IDS_DEFAULT_VALUE             = 64'h00000000_00000000           
  

  , parameter [(RF_NUM_OF_REGISTERS*64)-1:0] REGISTERS_DEFAULT_VALUE = { 
                                                                        //UHFI Registers
                                                                        DDMA_FMT_TYPE_MASK_DEFAULT_VALUE,
                                                                        DDMA_SAI_RS_TC_CHNL_MASK_DEFAULT_VALUE, 
                                                                        DDMA_DEST_IDS_MASK_DEFAULT_VALUE,
                                                                        DDMA_SRC_IDS_MASK_DEFAULT_VALUE,
                                                                        DDMA_FMT_TYPE_DEFAULT_VALUE,
                                                                        DDMA_SAI_RS_TC_CHNL_DEFAULT_VALUE,
                                                                        DDMA_DEST_IDS_DEFAULT_VALUE,
                                                                        DDMA_SRC_IDs_DEFAULT_VALUE,
                                                                        DDMA_CONTROL_DEFAULT_VALUE,
                                                                        DDMA_ADDRESS_RANGE_STATIC_OFFSET_DEFAULT_VALUE,
                                                                        DDMA_ADDRESS_RANGE_LIMIT_DEFAULT_VALUE_0,
                                                                        DDMA_ADDRESS_RANGE_BASE_DEFAULT_VALUE_0,
                                                                        DDMA_ADDRESS_RANGE_LIMIT_DEFAULT_VALUE_1,
                                                                        DDMA_ADDRESS_RANGE_BASE_DEFAULT_VALUE_1,
                                                                        CMPL_COMPARE_DEFAULT_VALUE,
                                                                        CMD_MASK_DEFAULT_VALUE_3,
                                                                        CMD_MASK_DEFAULT_VALUE_2,
                                                                        CMD_MASK_DEFAULT_VALUE_1,
                                                                        CMD_COMPARE_DEFAULT_VALUE_3,
                                                                        CMD_COMPARE_DEFAULT_VALUE_2,
                                                                        CMD_COMPARE_DEFAULT_VALUE_1,

                                                                        //Add user registers here
                                                                        //     
                                                                        // 

                                                                        //UHFI Registers Continued
                                                                        EXTRA_BITS_FOR_BPI_FLASH,          //INTERNAL_REGISTERS 9  //E.C
                                                                        BDF4_REGISTER_DEFAULT_VALUE,       //INTERNAL_REGISTERS 8
                                                                        BDF3_REGISTER_DEFAULT_VALUE,       //INTERNAL_REGISTERS 7
                                                                        BDF2_REGISTER_DEFAULT_VALUE,       //INTERNAL_REGISTERS 6
                                                                        BDF1_REGISTER_DEFAULT_VALUE,       //INTERNAL_REGISTERS 5
                                                                        CONFIG_REGISTER_DEFAULT_VALUE,     //INTERNAL_REGISTERS 4
                                                                        REPLACE_BUS_DEVICE_FUNCTION_VALUE, //INTERNAL_REGISTERS 3
                                                                        STATUS_REGISTER_DEFAULT_VALUE,     //INTERNAL_REGISTERS 2    
                                                                        FPGA_PROJECT_NAME_REGISTER_VALUE,  //INTERNAL_REGISTERS 1
                                                                        FPGA_VERSION_REGISTER_VALUE        //INTERNAL_REGISTERS 0
                                                                      }
    

   , parameter [LB_NUM_OF_AGENTS-1:0][31:0] LB_AGENTS_BASE_ADDR = {
                                                                  PHANTOM_BASE_ADDR,  //must always be the first in the list

                                                                  //Add base addresses of user specific LB agents here 
                                                                  //
                                                                  //

                                                                  //UHFI Internal LB Agents Base Addresses 
                                                                  GTX_LOCAL_BASE_ADDR,
                                                                  SB_MB_OUT_BASE_ADDR,               
                                                                  SB_MB_IN_BASE_ADDR,
                                                                  RF_BASE_ADDR               
                                                                }
        
   , parameter [LB_NUM_OF_AGENTS-1:0][31:0] LB_AGENTS_SIZE = {   
                                                             PHANTOM_SIZE,  //must always be the first in the list

                                                             //Add mem sizes of user specific LB agents here
                                                             // 

                                                             //UHFI Internal LB Agent mem sizes 
                                                             GTX_LOCAL_SIZE,
                                                             SB_MB_OUT_SIZE,
                                                             SB_MB_IN_SIZE,
                                                             RF_SIZE
                                                            }

    
  //Ordering of completion enable 
  //, parameter ORDERED_COMPL_EN = 1
  , parameter ORDERED_COMPL_EN = 0

  //If PASSTHRU_BUS_NUM is set to 1, we do not set bus number = 0 in direct
  //mode transactions targetting the DUT
  , parameter PASSTHRU_BUS_NUM = 1

  //IM will generate tag from 80h to ffh
  , parameter IM_DS_DMA_BUFFER_TAG_80_TO_FF = 0

  //sb out mailbox interrupt is supported 
  , parameter SB_MB_OUT_INTR_SUPPORT = 0

  , parameter [7:0] DIRECT_MODE_HOST_SAI_VALUE = 8'h01
  , parameter [14:0] DIRECT_MODE_HOST_SRC_ID_VALUE = 15'h0
  , parameter IOSF_UHFI_TTIF_PORT_EN = 1 //uru
  , parameter BYPASS_SHUFFLER = 1
// Registers File Table
//
// 
//+------------------+---------+------------+------+---------------+----------------------------------------+
//|   | Access       | Address | Valid Bits | Type | Default Value | Description                            |
//+---+--------------+---------+------------+------+---------------+----------------------------------------+
//| 0 |Host          |0x000    | [63:0]     | RO   | FPGA_VERSION  | FPGA Version                           |
//+---+--------------+---------+------------+------+---------------+----------------------------------------+
//| 1 |Host          |0x008    | [63:0]     | RO   | PROJECT_NAME  | FPGA PROJECT NAME                      |
//+---+--------------+---------+------------+------+---------------+----------------------------------------+
//| 2 |FIP / SA IP   |0x010    | [63:0]     | RO   | 0x0           | Status Register(Status of FIP and SA   |
//+---+--------------+---------+------------+------+---------------+----------------------------------------+
//| 3 |Host          |0x018    | [63:0]     | RW   | 0x0           | REPLACE_BUS_DEVICE_FUNCTION            |     
//+---+--------------+---------+------------+------+---------------+----------------------------------------+
//| 4 |Host          |0x020    | [63:0]     | RW   | 0x0           | Config Register                        |
//+---+--------------+---------+------------+------+---------------+----------------------------------------+
//| 5 |Host          |0x028    | [63:0]     | RW   | 0x0           | BDF1_REGISTER                          |
//+---+--------------+---------+------------+------+---------------+----------------------------------------+
//| 6 |Host          |0x030    | [63:0]     | RW   | 0x0           | BDF2_REGISTER                          |
//+---+--------------+---------+------------+------+---------------+----------------------------------------+
//| 7 |Host          |0x038    | [63:0]     | RW   | 0x0           | BDF3_REGISTER                          |
//+---+--------------+---------+------------+------+---------------+----------------------------------------+
//| 8 |Host          |0x040    | [63:0]     | RW   | 0x0           | BDF4_REGISTER                          |
//+---+--------------+---------+------------+------+---------------+----------------------------------------+
//| 9 |Host          |0x048    | [63:0]     | RW   | 0x0           | EXTRA_BITS_FOR_BPI_FLASH             |     //E.C
//+---+--------------+---------+------------+------+---------------+----------------------------------------+
                
                
                              
//Registers File Out
//+----------------------------------------+
//|      Name               Address        |
//+----------------------------------------+
//| Config Register          [63:0]        |
//+----------------------------------------+
//|                                        |
//+----------------------------------------+
//|                                        |
//+----------------------------------------+
//|                                        |
//+----------------------------------------+
//|                                        |
//+----------------------------------------+


      
                              

