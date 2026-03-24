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


// $Id: //acds/rel/24.1/ip/iconnect/verification/lib/avalon_utilities_pkg.sv#1 $
// $Revision: #1 $
// $Date: 2024/02/01 $
//-----------------------------------------------------------------------------
// =head1 NAME
// avalon_utilities_pkg
// =head1 SYNOPSIS
// Package for shared types and functions
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
// This package contains shared types and functions.
// =cut
`timescale 1ns / 1ns

`ifndef _AVALON_UTILITIES_PKG_
`define _AVALON_UTILITIES_PKG_

package avalon_utilities_pkg;

   function automatic int clog2(
      bit [31:0] Depth
   );
      int	 i= Depth; 
      for(clog2 = 0; i > 0; clog2 = clog2 + 1)
        i = i >> 1;

      return clog2;
   endfunction 

   function automatic int max(
      bit [31:0] one,
      bit [31:0] two
   );     
      if(one > two)
	return one;
      else
	return two;
   endfunction 

   function automatic int lindex(
      bit [31:0] width
   );
      // returns the left index for a vector having a declared width 
      // when width is 0, then the left index is set to 0 rather than -1
      lindex = (width > 0) ? (width-1) : 0;
   endfunction
   
   typedef enum int {
      LOW      = 0,
      HIGH     = 1,
      RANDOM   = 2,  
      UNKNOWN  = 3
   } IdleOutputValue_t;
   
endpackage

`endif
   
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "oSKThnM8R+v4ntG+2nl4bjKssux9ChPCljWQD7sPiJABKN3SNdkywE5Y9jlQ6S14DWhLDzTra8TiIdkRcVVm742z5SsEdsJozy5YbTTLMwLklS7QykQbr47Q0XEb4wjmHRWxsXN/cqp4yvaj0F/T170jVXGQEeG8jGOUpVeKH05OMFZaeFHtsmfkAiMhLD6Ub4coa1nbk3STuGKv7+r8sFY4IhYpZD54s1pA/oHzEkeP54UVhZRQfm4TKrhXPInX1+oUNI6JI3wQgxB26WX2ppa30iizDbcdnw09lVlU/Ak6TLOmlRjKb4fO6BnHCGBP5xWMXoC/PjdNmBSFiiGSkxxZGfGUVToj216jowjMxzdECwk0IqYiT6ZlrkrpssGNqEnoNJC3twL9TO/rYW+t019tbWqPs3WFyIaiCRjRxE8p+HkPMds1EcJI7A735U7IeSCeOEZoHZ6sPZPf5Ig2EXFmi/3z7eDRA+QSXEQQlb53J2fHNDRh393xPNrsa7AXpXOCjEKr3Ta1SoQD464BV0TYsAEerKFmPsFPiZ4hFtX5cfzZ2BcN+PpO10nTDgS2KEAl8NS4RS9mJPULIaWJgmkRax7PTu+j5RRGciFIgkgJVuK1iQLUxnrpVd18xkrBkoSDr8y7SEWIQzaSlU3s1dsajqi+nBlsSO2Rvl3GdcTXBR22Ozx4bOH6JZOSv5sxT1JLXYciNdrdl2MuxnKr578ShGcWFZyoiM2yDbOtIlDe+hZyn3g81VEXGfo2YPKCdZOGgX2UIhce7wQaJiuhsbPw2uTZlFdozDioHsix2R+pv3pHuvzmYklppnnn6a5GoNspKvOkjwkpiCAEL7WqiJ8ZQwyqtrU4rx1RZjsfTz+mQd9f87S6cA3IjO555jTmqdIGlqHzzG7UoWBFKkwhhS3okAoVen5Kwxk0cOfc6ZhsqA7LYbwDM4w2IoN6dOid2KhbVxn+hF25KMI9Bh4kTR32vggpfQpu1AlIJd2/+EdZyJzvxcFNy/A08W+F4BAC"
`endif