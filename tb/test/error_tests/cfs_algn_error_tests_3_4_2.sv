///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_error_tests_3_4_2.sv
// Author:      Dhanwanth
// Date:        2025-06-23
// Description: Illegal write - write to status register which is read-only
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_ALGN_ERROR_TESTS_3_4_2_SV
`define CFS_ALGN_ERROR_TESTS_3_4_2_SV

class cfs_algn_error_tests_3_4_2 extends cfs_algn_test_base;

  `uvm_component_utils(cfs_algn_error_tests_3_4_2)

  function new(string name = "", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    cfs_md_sequence_slave_response_forever resp_seq;
    cfs_algn_virtual_sequence_3_1_3 cfg_seq;
    cfs_algn_virtual_sequence_rx_crt rx_seq;
    cfs_algn_virtual_sequence_rx_err err_seq;
    cfs_algn_vif vif;

    uvm_reg_data_t reg_val;
    uvm_status_e status;
    uvm_reg_field irq_fields[$];

    phase.raise_objection(this, "TEST_START");

    #(100ns);

    // Fork forever slave responder
    fork
      begin
         resp_seq = cfs_md_sequence_slave_response_forever::type_id::create(
            "resp_seq"
        );
        resp_seq.start(env.md_tx_agent.sequencer);
      end
    join_none

    cfg_seq = cfs_algn_virtual_sequence_3_1_3::type_id::create("cfg_seq");
    cfg_seq.set_sequencer(env.virtual_sequencer);
    cfg_seq.start(env.virtual_sequencer);

    // Step 2: Wait a bit before sending traffic
    vif = env.env_config.get_vif();
    repeat (50) @(posedge vif.clk);

    env.model.reg_block.STATUS.write(status, 32'h00000004, UVM_FRONTDOOR);
    env.model.reg_block.STATUS.read(status, reg_val, UVM_FRONTDOOR);
    ////////////////////////////////////////////////////////////////////////
    // If you observe the log you will notice that the write into the status
    // register will not take place because it is an illegal write. If we
    // uncomment the respective uvm_info_key we will see that its a illegal
    // write
    ///////////////////////////////////////////////////////////////////////
    #(100ns);

    #(500ns);

    phase.drop_objection(this, "TEST_DONE");
  endtask

endclass

`endif
