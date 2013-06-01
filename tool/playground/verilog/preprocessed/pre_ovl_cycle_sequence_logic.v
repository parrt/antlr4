// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.

  parameter NC0 = (necessary_condition == OVL_TRIGGER_ON_MOST_PIPE);
  parameter NC1 = (necessary_condition == OVL_TRIGGER_ON_FIRST_PIPE);
  parameter NC2 = (necessary_condition == OVL_TRIGGER_ON_FIRST_NOPIPE);

  // Guarded parameters for num_cks < 2 (which is bad usage - see warning in top-level file)
  parameter NUM_CKS_1 = (num_cks > 0) ? (num_cks - 1) : 0;
  parameter NUM_CKS_2 = (num_cks > 1) ? (num_cks - 2) : 0;
  parameter LSB_1     = (num_cks > 1) ?            1  : 0;


//------------------------------------------------------------------------------
// SHARED CODE
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
// ASSERTION
//------------------------------------------------------------------------------
  wire fire_2state = 1'b0;
  wire fire_xcheck = 1'b0;



//------------------------------------------------------------------------------
// COVERAGE
//------------------------------------------------------------------------------
  wire fire_cover = 1'b0;
