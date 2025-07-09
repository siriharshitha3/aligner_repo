///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_test_pkg.sv
// Author:      Cristian Florin Slav
// Date:        2023-06-27
// Description: Test package.
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_ALGN_TEST_PKG_SV
`define CFS_ALGN_TEST_PKG_SV 

`include "uvm_macros.svh"
`include "../env/cfs_algn_pkg.sv"

package cfs_algn_test_pkg;
  import uvm_pkg::*;
  import cfs_algn_pkg::*;
  import cfs_apb_pkg::*;
  import cfs_md_pkg::*;

  `include "cfs_algn_test_defines.sv"
  `include "cfs_algn_test_base.sv"
  `include "cfs_algn_test_reg_access.sv"
  `include "cfs_algn_test_random.sv"

  //manual apb tests included below
  `include "../test/apb_tests/cfs_algn_apb_tests_mapped_unmapped.sv"
  `include "../test/apb_tests/cfs_algn_apb_tests_3_1_1.sv"
  `include "../test/apb_tests/cfs_algn_apb_tests_3_1_2.sv"
  `include "../test/apb_tests/cfs_algn_apb_tests_3_1_3.sv"
  `include "../test/apb_tests/cfs_algn_apb_tests_3_1_4.sv"
  `include "../test/apb_tests/cfs_algn_apb_tests_3_1_5.sv"

  //manual md tests included below
  `include "../test/md_tests/cfs_algn_md_tests_random_traffic.sv"
  `include "../test/md_tests/cfs_algn_md_tests_cnt_drop.sv"
  `include "../test/md_tests/cfs_algn_md_tests_3_2_1.sv"
  `include "../test/md_tests/cfs_algn_md_tests_3_2_2.sv"
  `include "../test/md_tests/cfs_algn_md_tests_3_2_3.sv"
  `include "../test/md_tests/cfs_algn_md_tests_3_2_4.sv"

  //manual interrupt tests
  `include "../test/intr_tests/cfs_algn_intr_tests_3_3_1.sv"
  `include "../test/intr_tests/cfs_algn_intr_tests_3_3_2.sv"
  `include "../test/intr_tests/cfs_algn_intr_tests_3_3_3.sv"
  `include "../test/intr_tests/cfs_algn_intr_tests_3_3_4.sv"
  `include "../test/intr_tests/cfs_algn_intr_tests_3_3_5.sv"
  `include "../test/intr_tests/cfs_algn_intr_tests_3_3_7.sv"
  `include "../test/intr_tests/cfs_algn_intr_tests_3_3_8.sv"

  //manual error tests
  `include "../test/error_tests/cfs_algn_error_tests_3_4_1.sv"
  `include "../test/error_tests/cfs_algn_error_tests_3_4_2.sv"
  `include "../test/error_tests/cfs_algn_error_tests_3_4_5.sv"

  //manual power and reset tests
  `include "../test/pwr_rst_tests/cfs_algn_rst_tests_3_5_1.sv"
  `include "../test/pwr_rst_tests/cfs_algn_rst_tests_3_5_2.sv"
endpackage

`endif
