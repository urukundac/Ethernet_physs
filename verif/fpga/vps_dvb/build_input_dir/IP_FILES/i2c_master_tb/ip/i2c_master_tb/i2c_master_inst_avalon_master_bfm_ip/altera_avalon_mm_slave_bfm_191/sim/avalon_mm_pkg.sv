// (C) 2001-2024 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/rel/24.1/ip/iconnect/verification/lib/avalon_mm_pkg.sv#1 $
// $Revision: #1 $
// $Date: 2024/02/01 $
//-----------------------------------------------------------------------------
// =head1 NAME
// avalon_mm_pkg
// =head1 SYNOPSIS
// Package for shared Avalon MM component types.
//-----------------------------------------------------------------------------
// =head1 COPYRIGHT
// Copyright (c) 2008 Altera Corporation. All Rights Reserved.
// The information contained in this file is the property of Altera
// Corporation. Except as specifically authorized in writing by Altera 
// Corporation, the holder of this file shall keep all information 
// contained herein confidential and shall protect same in whole or in part 
// from disclosure and dissemination to all third parties. Use of this 
// program confirms your agreement with the terms of this license.
//-----------------------------------------------------------------------------
// =head1 DESCRIPTION
// This package contains shared non-parameterized type definitions.
// =cut
`timescale 1ns / 1ns

`ifndef _AVALON_MM_PKG_
`define _AVALON_MM_PKG_

package avalon_mm_pkg;
   import verbosity_pkg::*;
   
   // Transaction request types
   typedef enum int {      // public 
      REQ_READ    = 0,     // Read Request
      REQ_WRITE   = 1,     // Write Request
      REQ_IDLE    = 2      // Idle
   } Request_t;

   // Slave BFM wait state logic operates in one of three distinct modes
   typedef enum int {          
		     WAIT_FIXED = 0,  // default: fixed wait cycles per burst cycle
                     WAIT_RANDOM = 1, // random  min =< wait cycles <= max
		     WAIT_ADDRESSABLE = 2 // fixed wait cycles per command address
                     } SlaveWaitMode_t;

   // Avalon MM transaction response status
   typedef enum logic[1:0] {
      AV_OKAY           = 0,
      AV_RESERVED       = 1,
      AV_SLAVE_ERROR    = 2,
      AV_DECODE_ERROR   = 3
   } AvalonResponseStatus_t;
   
   function automatic string request_string(Request_t request);
      case(request) 
     	REQ_READ: return("read");
     	REQ_WRITE: return("write");
     	REQ_IDLE: return("idle");
     	default: return("INVALID_REQUEST");
      endcase 
   endfunction

endpackage

`endif
   
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "oSKThnM8R+v4ntG+2nl4bjKssux9ChPCljWQD7sPiJABKN3SNdkywE5Y9jlQ6S14DWhLDzTra8TiIdkRcVVm742z5SsEdsJozy5YbTTLMwLklS7QykQbr47Q0XEb4wjmHRWxsXN/cqp4yvaj0F/T170jVXGQEeG8jGOUpVeKH05OMFZaeFHtsmfkAiMhLD6Ub4coa1nbk3STuGKv7+r8sFY4IhYpZD54s1pA/oHzEket7+v/iEdKBvHYT/oFzpW4zJW386bdd+PvFeaCQpmerjeh/YnS0X4/V6GVPqUDFsEH2SS5cKodAhotJMyCArcYIyJIPQmlF5EadycWUQtV483Z699wE0jNKGZMUea8kJvPN5inG+hZ3kgmUJX/bCPekOqKDIGwG8EzuCyXpGkOgMxY1qcG18vevVTNAgYZZJKjweP+P5U9rpWGSJ8qAjBSgiNeaDsuz7Px1Yo4IDAXG3FWTqPBNMXiCQVeCbGtAIMjOF8JTJR5oOaVHdDKCBdmGlFbhKGB59Tiq0wplUTape3BnPm3DVrnEq9XeLmKiwNEIfJu46WVKmZw91Nh3tg4Rk1WF5P/uNRsbILZ9IhbeEXmISdEeFbdkGDWl/aPQ0UNC8OZMci/gl14r/KKtp+PHAsdJcJqfiRZNXj9shxJbk0NQHXhaM0Boz8+lZQFWuz0Jnk4AXAQuMjVGyNFj4d9KfY4zWDsWAFLyf41RleVGvL+dCHqJe7d7FLIcwxCUwXRFeIYeJRDN+gdaK7O0v9l88HhAlrgwd8aBVExejihKTZzJyzAju+oIXEMZrhvrLcuuheEN+kagLSHAaQ7RP4hpL2S79hKJ96C06FT89Q0I5Ir9cpMca7qYOtI56C/xuz0DdIE7CYQ4yilwSsutU9vkLjjV5i6G6JrTgQapy69ivxzSsot+WHoY+ChfTt27LPdnYmobyCqpizoyWk9KhaLPea6pUoV7aFjx1oafPj0I4phCPfww7BhS59wlHlZMMUAmR4zbyI2k45MM5BPa4ax"
`endif