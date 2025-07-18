///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_error_tests_3_4_1.sv
// Author:      Dhanwanth
// Date:        2025-06-23
// Description: Illegal transfer detection
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_ALGN_ERROR_TESTS_3_4_1_SV
`define CFS_ALGN_ERROR_TESTS_3_4_1_SV

class cfs_algn_error_tests_3_4_1 extends cfs_algn_test_base;

  `uvm_component_utils(cfs_algn_error_tests_3_4_1)

  function new(string name = "", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    cfs_md_sequence_slave_response_forever resp_seq;
    cfs_algn_virtual_sequence_3_1_3 cfg_seq;
    cfs_algn_virtual_sequence_rx_crt rx_seq;
    cfs_algn_virtual_sequence_rx_err err_seq;
    cfs_algn_vif vif;

    uvm_reg_data_t irq_val;
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

    for (int i = 0; i < 255; i++) begin
      err_seq = cfs_algn_virtual_sequence_rx_err::type_id::create($sformatf("err_seq_%0d", i));
      err_seq.set_sequencer(env.virtual_sequencer);
      void'(err_seq.randomize());
      err_seq.start(env.virtual_sequencer);
    end

    #(100ns);


    // Step 4: Read all fields of the IRQ register
    // env.model.reg_block.IRQ.read(status, irq_val, UVM_FRONTDOOR);
    // `uvm_info("IRQ_READ", $sformatf("IRQ register value = 0x%0h", irq_val), UVM_LOW)
    //
    // env.model.reg_block.IRQ.TX_FIFO_FULL.write(status, 1, UVM_FRONTDOOR);
    //
    // env.model.reg_block.IRQ.read(status, irq_val, UVM_FRONTDOOR);
    // `uvm_info("IRQ_READ", $sformatf("IRQ register value = 0x%0h", irq_val), UVM_LOW)

    #(500ns);

    phase.drop_objection(this, "TEST_DONE");
  endtask

endclass

`endif
