`timescale 1ns/1ps

module blink_tb ();

localparam blink = 8;

reg clk = 1'b0;
wire a;

blink #(.blink_time(blink)) dut (
  .clock(clk),
  .voltage(a)
);

always #5 clk = ~clk;

initial begin
  $dumpfile("blink_tb.vcd");
  $dumpvars(0, blink_tb);
end

initial begin
    $monitor("time = %0t ns,  voltage = %b", $time, a);
end


initial begin
  #900;
  $display("Simulation finished at 100 times", $time);
  $finish;
end

endmodule