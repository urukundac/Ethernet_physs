
//-----------------------------------------------------------------------------------------------------
//                              Copyright (c) LSI CORPORATION, 2007.
//                                      All rights reserved.
//
// This software and documentation constitute an unpublished work and contain valuable trade secrets
// and proprietary information belonging to LSI CORPORATION ("LSI").  None of the foregoing material
// may be copied, duplicated or disclosed without the express written permission of LSI.
//
// The use of this software, documentation, methodologies and other information associated herewith,
// is governed exclusively by the associated license agreement(s).  Any use, modification or
// publication inconsistent with such license agreement(s) is an infringement of the copyright in
// this material and a misappropriation of the intellectual property of LSI.
//
// LSI EXPRESSLY DISCLAIMS ANY AND ALL WARRANTIES CONCERNING THIS SOFTWARE AND DOCUMENTATION, INCLUDING
// ANY WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR ANY PARTICULAR PURPOSE, AND WARRANTIES OF
// PERFORMANCE, AND ANY WARRANTY THAT MIGHT OTHERWISE ARISE FROM COURSE OF DEALING OR USAGE OF TRADE,
// NO WARRANTY IS EITHER EXPRESS OR IMPLIED WITH RESPECT TO THE USE OF THE SOFTWARE OR DOCUMENTATION.
//
// Under no circumstances shall LSI be liable for incidental, special, indirect, direct or consequential
// damages or loss of profits, interruption of business, or related expenses which may arise from use of
// this software or documentation, including but not limited to those resulting from defects in software
// and/or documentation, or loss or inaccuracy of data of any kind.
//-----------------------------------------------------------------------------------------------------
// Version and Release Control Information:
//
// File Name:     IW_logb2.svh
// File Revision: $Revision: 1.3 $
// Created by:    Steve Pollock
// Updated by:    $Author: spollock $ $Date: Fri Mar 22 16:27:02 2013 $
//-----------------------------------------------------------------------------------------------------
// IW_logb2
//
// This function returns the integer part of the base 2 logarithm for the input.
//
//-----------------------------------------------------------------------------------------------------

// reuse-pragma beginAttr FunctionDefinition
// set x 0
// for {set i 0} {$i < 32} {incr i} {
//   if { $d >> $i } {
//     set x $i
//   }
// }
// return $x
// reuse-pragma endAttr
function integer IW_logb2;
 input  [31:0]  d;
 integer        i;	// spyglass disable W121 -- This i is okay
 integer        x;	// spyglass disable W121 -- This x is okay
 begin

  x=0; for (i=0; i<32; i=i+1) if (|(d >> i)) x=i; IW_logb2=x; // spyglass disable W244

 end
endfunction

//-----------------------------------------------------------------------------------------------------
// Change History:
//
// $Log: IW_logb2.svh.rca $
// 
//  Revision: 1.3 Fri Mar 22 16:27:02 2013 spollock
//  Moved change log to the end of the file. -sjp
// 
//  Revision: 1.2 Tue Jan 22 18:04:12 2013 mpp
//  Initial axxia version. -sjp
// 
//  Revision: 1.1.13.4.1.1 Wed Nov  9 13:02:02 2011 spollock
//  Added lint pragma for latest spyglass. -sjp
// 
//  Revision: 1.1.13.4 Wed Jun 15 17:38:31 2011 spollock
//  Added lint pragma for latest spyglass. -sjp
// 
//  Revision: 1.1.13.3 Mon Mar  7 14:10:28 2011 mrb
//  *** empty comment string ***
// 
//  Revision: 1.1 Fri Feb 15 17:13:38 2008 mpp
//  Initial version for Nuevo. -sjp
//
//-----------------------------------------------------------------------------------------------------
