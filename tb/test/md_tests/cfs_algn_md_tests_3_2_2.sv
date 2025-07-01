///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_md_tests_3_2_2.sv
// Author:      Auto-generated
// Date:        2025-06-27
// Description: Test to validate behavior for interleaved legal/illegal RX packets
///////////////////////////////////////////////////////////////////////////////

`ifndef CFS_ALGN_MD_TESTS_3_2_2_SV
`define CFS_ALGN_MD_TESTS_3_2_2_SV

class cfs_algn_md_tests_3_2_2 extends cfs_algn_test_base;

  `uvm_component_utils(cfs_algn_md_tests_3_2_2)

  function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    cfs_algn_virtual_sequence_reg_config cfg_seq;
    cfs_algn_virtual_sequence_rx_crt legal_seq;
    cfs_algn_virtual_sequence_rx_err illegal_seq;
    cfs_md_sequence_slave_response_forever resp_seq;
    cfs_algn_vif vif;

    uvm_status_e status;
    uvm_reg_data_t cnt_drop_val;
    int legal_count = 0;
    int illegal_count = 0;

    phase.raise_objection(this, "TEST_START");
    $display("Hellooooooo1111");
    // Step 0: Start slave responder to consume TX packets
    fork
      begin
        resp_seq = cfs_md_sequence_slave_response_forever::type_id::create("resp_seq");
        resp_seq.start(env.md_tx_agent.sequencer);
      end
    join_none
    $display("Hellooooooo2222");
    // Step 1: Configure IRQEN register and other regs
    cfg_seq = cfs_algn_virtual_sequence_reg_config::type_id::create("cfg_seq");
    cfg_seq.set_sequencer(env.virtual_sequencer);
    cfg_seq.start(env.virtual_sequencer);

    // Step 2: Clear CNT_DROP
    // env.model.reg_block.CTRL.CLR.write(status, 1, UVM_FRONTDOOR);
    $display("Hellooooooo3333");
    // Step 3: Wait for DUT to stabilize
    vif = env.env_config.get_vif();
    repeat (20) @(posedge vif.clk);
    $display("Hellooooooo4444");
    // Step 4.1: Send 5 legal packets
    for (int i = 0; i < 5; i++) begin
      legal_seq = cfs_algn_virtual_sequence_rx_crt::type_id::create($sformatf("legal1_%0d", i));
      legal_seq.set_sequencer(env.virtual_sequencer);
      void'(legal_seq.randomize());
      legal_seq.start(env.virtual_sequencer);
      legal_count++;
    end

    // Step 4.2: Send 5 illegal packets
    for (int i = 0; i < 5; i++) begin
      illegal_seq = cfs_algn_virtual_sequence_rx_err::type_id::create($sformatf("illegal_%0d", i));
      illegal_seq.set_sequencer(env.virtual_sequencer);
      void'(illegal_seq.randomize());
      illegal_seq.start(env.virtual_sequencer);
      illegal_count++;
    end

    // Step 4.3: Send 5 more legal packets
    for (int i = 0; i < 5; i++) begin
      legal_seq = cfs_algn_virtual_sequence_rx_crt::type_id::create($sformatf("legal2_%0d", i));
      legal_seq.set_sequencer(env.virtual_sequencer);
      void'(legal_seq.randomize());
      legal_seq.start(env.virtual_sequencer);
      legal_count++;
    end

    #(500ns);  // Let DUT process everything

    // Step 5: Read CNT_DROP
    env.model.reg_block.STATUS.CNT_DROP.read(status, cnt_drop_val, UVM_FRONTDOOR);

    `uvm_info("3_2_2", $sformatf("Total legal packets sent:   %0d", legal_count), UVM_MEDIUM)
    `uvm_info("3_2_2", $sformatf("Total illegal packets sent: %0d", illegal_count), UVM_MEDIUM)
    `uvm_info("3_2_2", $sformatf("CNT_DROP register value:    %0d", cnt_drop_val), UVM_MEDIUM)

    if (cnt_drop_val != illegal_count)
      `uvm_error("3_2_2", $sformatf(
                 "CNT_DROP mismatch! Expected %0d, got %0d", illegal_count, cnt_drop_val))

    phase.drop_objection(this, "TEST_DONE");
  endtask

endclass

`endif
