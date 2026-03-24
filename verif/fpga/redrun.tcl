 #################### Sequence to starts I2C device address 0x0 register read #####
#reset assertion and deassertion fo fresh start
reset -assert physs_func_rst_raw_n
reset -assert i_reset
reset -deassert i_reset
reset -deassert physs_func_rst_raw_n

#Disable IC_ENABLE to write into other registers
vapb setword -instance physs_eth.phy_i2c_vapb_master -address 0x6c -data 0x0
vapb getword -instance physs_eth.phy_i2c_vapb_master -address 0x6c
#Enable master mode, standard speed in IC_CON register
vapb setword -instance physs_eth.phy_i2c_vapb_master -address 0 -data 0x43
vapb getword -instance physs_eth.phy_i2c_vapb_master -address 0
#Write to IC_TAR for I2C slave address in [9:0]
vapb setword -instance physs_eth.phy_i2c_vapb_master -address 0x4 -data 0xA0
vapb getword -instance physs_eth.phy_i2c_vapb_master -address 0x4
#I2C slave read access  IC_SS_SCL_HCNT 
vapb setword -instance physs_eth.phy_i2c_vapb_master -address 0x14 -data 0x6
vapb getword -instance physs_eth.phy_i2c_vapb_master -address 0x14
##I2C slave read access IC_SS_SCL_LCNT 
vapb setword -instance physs_eth.phy_i2c_vapb_master -address 0x18 -data 0xC
vapb getword -instance physs_eth.phy_i2c_vapb_master -address 0x18
##I2C slave read access IC_FS_SPKLEN 
vapb setword -instance physs_eth.phy_i2c_vapb_master -address 0xa0 -data 0x1
vapb getword -instance physs_eth.phy_i2c_vapb_master -address 0xa0
####I2C slave read access  IC_SDA_HOLD 
vapb setword -instance physs_eth.phy_i2c_vapb_master -address 0x7c -data 0x0
vapb getword -instance physs_eth.phy_i2c_vapb_master -address 0x7c
##I2C slave read access IC_SDA_SETUP 
vapb setword -instance physs_eth.phy_i2c_vapb_master -address 0x94 -data 0x0
vapb getword -instance physs_eth.phy_i2c_vapb_master -address 0x94
##I2C slave read access  IC_RX_TL 
#vapb setword -instance physs_eth.phy_i2c_vapb_master -address 0x38 -data 0x10
#vapb getword -instance physs_eth.phy_i2c_vapb_master -address 0x38
##I2C slave read access  IC_TX_TL 
#vapb setword -instance physs_eth.phy_i2c_vapb_master -address 0x3c -data 0x10
#vapb getword -instance physs_eth.phy_i2c_vapb_master -address 0x3c
#I2C slave read access  IC_SMBUS_THIGH_MAX_IDLE_COUNT 
vapb setword -instance physs_eth.phy_i2c_vapb_master -address 0xc4 -data 0x04
vapb getword -instance physs_eth.phy_i2c_vapb_master -address 0xc4
#Enable IC_ENABLE to write into other registers
vapb setword -instance physs_eth.phy_i2c_vapb_master -address 0x6c -data 0x01
vapb getword -instance physs_eth.phy_i2c_vapb_master -address 0x6c
#I2C slave write access IC_CMD_DATA 
vapb setword -instance physs_eth.phy_i2c_vapb_master -address 0x10 -data 0x00FF

