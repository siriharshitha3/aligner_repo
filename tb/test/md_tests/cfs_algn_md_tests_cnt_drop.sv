///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_test_random_rx_err.sv
// Author:      Cristian Florin Slav
// Date:        2025-02-12
// Description: Random test which sends only illegal MD RX transactions
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_ALGN_MD_TESTS_CNT_DROP_SV
`define CFS_ALGN_MD_TESTS_CNT_DROP_SV

class cfs_algn_md_tests_cnt_drop extends cfs_algn_test_random;

  `uvm_component_utils(cfs_algn_md_tests_cnt_drop)

  function new(string name = "", uvm_component parent);
    super.new(name, parent);

    num_md_rx_transactions = 300;

    cfs_algn_virtual_sequence_rx::type_id::set_type_override(
        cfs_algn_virtual_sequence_rx_err::get_type());
  endfunction

endclass

`endif
