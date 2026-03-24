//----------------------------------------------------------------------------------------------------------------------
// Tile              : iosf_p_jem_tracker.vh
// Original Project  : Broxton
// Creation Date     : 2013/09/23
//----------------------------------------------------------------------------------------------------------------------
// Primary Contact   : Andrey Shapkin <andrey.shapkin@intel.com>
// Secondary Contact : Alexander Lyalin <alexander.lyalin@intel.com>
//----------------------------------------------------------------------------------------------------------------------
//
// Description:
//
//----------------------------------------------------------------------------------------------------------------------


`ifndef __T_IOSF_P_JEM
`define __T_IOSF_P_JEM

// define your data structures that need to be sent to SW side
// each of the fields of the struct will be available by SW


typedef struct packed{
    logic        dir;
    logic [1:0]  cmd_mfmt;
    logic [4:0]  cmd_mtype;
    logic [3:0]  cmd_mtc;
    logic [9:0]  cmd_mlength;
    logic [15:0] cmd_mreqid;
    logic [7:0]  cmd_mtag;
    logic [3:0]  cmd_mlbe;
    logic [3:0]  cmd_mfbe;
    logic [63:0] cmd_maddr; // FIXME
    logic [15:0] cmd_msrcid;
    logic [15:0] cmd_mdestid;
    logic         cmd_mrs;
    logic         cmd_mep;
    logic         cmd_mido;
    logic         cmd_mns;
    logic         cmd_mro;
    logic [7:0]   cmd_msai;
    logic [1:0]  gnt_rtype;
    logic [3:0]  gnt_chid;
    logic [7:0]  mstr_reqid;
} t_iosf_p_jem_mreq;

typedef struct packed{
    logic        dir;
    logic        cmd_tput;
    logic [3:0]  cmd_tchid;
    logic [1:0]  cmd_trtype;
    logic [1:0]  cmd_tfmt;
    logic [4:0]  cmd_ttype;
    logic [3:0]  cmd_ttc;
    logic [9:0]  cmd_tlength;
    logic [15:0] cmd_treqid;
    logic [7:0]  cmd_ttag;
    logic [3:0]  cmd_tlbe;
    logic [3:0]  cmd_tfbe;
    logic [63:0] cmd_taddr;
    logic [15:0] cmd_tsrcid;
    logic [15:0] cmd_tdestid;
    logic         cmd_trs;
    logic         cmd_tep;
    logic         cmd_tido;
    logic         cmd_tns;
    logic         cmd_tro;
    logic [7:0]   cmd_tsai;
    logic [7:0]  tgt_reqid;
} t_iosf_p_jem_treq;

typedef struct packed{
    logic         dir;
    logic         data_mvalid;
    logic [511:0] mdata;
    logic [7:0]   mdata_width;
    logic         mdata_last;
    logic [12:0]  mdata_id;
} t_iosf_p_jem_mdata;

typedef struct packed{
    logic         dir;
    logic         data_tvalid;
    logic [511:0] tdata;
    logic [7:0]   tdata_width;
    logic         tdata_last;
    logic [12:0]  tdata_id;
} t_iosf_p_jem_tdata;

`endif  //__T_IOSF_P_JEM
