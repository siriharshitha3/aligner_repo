///////////////////////////////////////////////////////////////////////////////
// File:        cfs_apb_reset_handler.sv
// Author:      Cristian Florin Slav
// Date:        2023-10-29
// Description: APB reset handler interface class.
///////////////////////////////////////////////////////////////////////////////

`ifndef CFS_APB_RESET_HANDLER_SV
`define CFS_APB_RESET_HANDLER_SV

  interface class cfs_apb_reset_handler;

  //Function to handle the reset
  pure virtual
    function void handle_reset(uvm_phase phase);
  endclass

`endif

