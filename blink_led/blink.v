module blink (
  input clock,
  output reg voltage = 1'b0
);

parameter blink_time = 13499999;
reg [24:0] counter = 25'b0 ;
reg flag = 1'b0;

always @(posedge clock) begin
  if (counter == blink_time) begin
    counter <= 25'b0;
    flag <= 1'b1; 
  end
  else begin
    counter <= counter + 1'b1; 
    flag <= 1'b0;
  end
end

always @(posedge clock) begin
  if (flag) begin
    voltage <= ~voltage;
  end
  else begin
    voltage <= voltage;
  end
end

endmodule