///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_apb_tests_3_1_1.sv
// Author:      Dhanwanth
// Date:        2025-06-23
// Description: Test that sets IRQEN.MAX_DROP to 1 and validates CNT_DROP count
//              Writing 0 into the cnt drop has no effect whereas write 1 will
//              clear the cnt drop.
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_ALGN_APB_TESTS_3_1_3_SV
`define CFS_ALGN_APB_TESTS_3_1_3_SV

class cfs_algn_apb_tests_3_1_3 extends cfs_algn_test_base;

  `uvm_component_utils(cfs_algn_apb_tests_3_1_3)

  function new(string name = "", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    cfs_md_sequence_slave_response_forever resp_seq;
    cfs_algn_virtual_sequence_3_1_3 cfg_seq;
    cfs_algn_virtual_sequence_rx_crt rx_seq;
    // cfs_algn_virtual_sequence_rx_err rx_err_seq2;
    cfs_algn_vif vif;

    uvm_reg_data_t irq_val;
    uvm_status_e status;
    uvm_reg_field irq_fields[$];

    phase.raise_objection(this, "TEST_START");

    #(100ns);

    // Fork forever slave responder
    fork
      begin
        cfs_md_sequence_tx_ready_block tx_block_seq = cfs_md_sequence_tx_ready_block::type_id::create(
            "tx_block_seq"
        );
        tx_block_seq.start(env.md_tx_agent.sequencer);
      end
    join_none

    cfg_seq = cfs_algn_virtual_sequence_3_1_3::type_id::create("cfg_seq");
    cfg_seq.set_sequencer(env.virtual_sequencer);
    cfg_seq.start(env.virtual_sequencer);

    // Step 2: Wait a bit before sending traffic
    vif = env.env_config.get_vif();
    repeat (50) @(posedge vif.clk);

    // Step 3: Send 20 illegal RX packets
    for (int i = 0; i < 10; i++) begin
      rx_seq = cfs_algn_virtual_sequence_rx_crt::type_id::create($sformatf("rx_seq_%0d", i));
      rx_seq.set_sequencer(env.virtual_sequencer);
      void'(rx_seq.randomize());
      rx_seq.start(env.virtual_sequencer);
    end

    #(100ns);


    // Step 4: Read all fields of the IRQ register
    env.model.reg_block.IRQ.read(status, irq_val, UVM_FRONTDOOR);
    `uvm_info("IRQ_READ", $sformatf("IRQ register value = 0x%0h", irq_val), UVM_LOW)

    env.model.reg_block.IRQ.TX_FIFO_FULL.write(status, 1, UVM_FRONTDOOR);

    env.model.reg_block.IRQ.read(status, irq_val, UVM_FRONTDOOR);
    `uvm_info("IRQ_READ", $sformatf("IRQ register value = 0x%0h", irq_val), UVM_LOW)
    //
    // /////////////////////////////////////////////////////////////////////////////////////////////////////////
    //     // Step 4: Set CLR to 1 to clear the cnt_drop (or) set it to 0 to view
    //     // that there is no effect on the cnt_drop
    //     env.model.reg_block.CTRL.CLR.write(status, 0, UVM_FRONTDOOR);
    // /////////////////////////////////////////////////////////////////////////////////////////////////////////
    //     #(200ns);
    //     //sending traffic again to see how the cnt_drop increments
    //     for (int i = 0; i < 20; i++) begin
    //       rx_err_seq2 =
    //           cfs_algn_virtual_sequence_rx_err::type_id::create($sformatf("rx_err_seq_%0d", i));
    //       rx_err_seq2.set_sequencer(env.virtual_sequencer);
    //       void'(rx_err_seq2.randomize());
    //       rx_err_seq2.start(env.virtual_sequencer);
    //     end

    #(500ns);

    phase.drop_objection(this, "TEST_DONE");
  endtask

endclass

`endif
