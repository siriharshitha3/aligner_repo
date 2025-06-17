///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_env.sv
// Author:      Cristian Florin Slav
// Date:        2023-06-27
// Description: Environment class.
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_ALGN_ENV_SV
  `define CFS_ALGN_ENV_SV

              class cfs_algn_env#(int unsigned ALGN_DATA_WIDTH = 32) extends uvm_env;

    //APB agent handler
    cfs_apb_agent apb_agent;

    //MD RX agent handler
    cfs_md_agent_master#(ALGN_DATA_WIDTH) md_rx_agent;

    //MD TX agent handler
    cfs_md_agent_slave#(ALGN_DATA_WIDTH) md_tx_agent;

    `uvm_component_param_utils(cfs_algn_env#(ALGN_DATA_WIDTH))

    function new(string name = "", uvm_component parent);
      super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      apb_agent = cfs_apb_agent::type_id::create("apb_agent", this);

      md_rx_agent = cfs_md_agent_master#(ALGN_DATA_WIDTH)::type_id::create("md_rx_agent", this);
      
      begin
        cfs_md_agent_config_slave#(ALGN_DATA_WIDTH) agent_config = cfs_md_agent_config_slave#(ALGN_DATA_WIDTH)::type_id::create("agent_config", this);
        
        agent_config.set_stuck_threshold(100);
        
        uvm_config_db#(uvm_ext_pkg::uvm_ext_agent_config#(.VIRTUAL_INTF(virtual cfs_md_if#(ALGN_DATA_WIDTH))))::set(this, "md_tx_agent", "agent_config", agent_config);
      end
      
      md_tx_agent = cfs_md_agent_slave#(ALGN_DATA_WIDTH)::type_id::create("md_tx_agent", this);
    endfunction
    
  endclass

`endif
