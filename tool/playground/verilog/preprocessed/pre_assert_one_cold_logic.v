// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.

  wire [width-1:0] test_expr_i = ~test_expr;
  wire [width-1:0] test_expr_i_1 = test_expr_i - {{width-1{1'b0}},1'b1};
  wire inactive_val=(inactive==`OVL_ALL_ONES)?1'b1:1'b0;


