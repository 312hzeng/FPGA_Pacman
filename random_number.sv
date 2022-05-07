module lfsr (
	output  logic  [7:0] out     ,  // Output of the counter
   input   logic       enable  ,  // Enable  for counter
   input   logic       clk     ,  // clock input
   input   logic       reset      // reset input
   );
 
    logic        linear_feedback;
  assign linear_feedback =  ! (out[7] ^ out[3]);
  
  always_ff @(posedge clk)
  if (reset) begin // active high reset
    out <= 8'b0 ;
  end else if (enable) begin
    out <= {out[6],out[5],
            out[4],out[3],
            out[2],out[1],
            out[0], linear_feedback};
  end 
  
  endmodule // End Of Module counter