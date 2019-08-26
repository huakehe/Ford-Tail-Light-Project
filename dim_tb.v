
module dim_tb();
reg clk,reset,left,right,hazard,brake,dimclk,ctrl;
wire [5:0] led;

dim dut(
  .clk(clk),
  .reset(reset),
  .left(left),
  .right(right),
  .hazard(hazard),
  .brake(brake),
  .led(led),
  .dimclk(dimclk),
  .ctrl(ctrl)
);

initial begin
  clk=0;
  forever #10 clk=~clk;
end
initial begin
  dimclk=0;
  forever #0.5 dimclk=~dimclk;
end
initial begin
  ctrl=0;
  reset=0;
  left=0;
  right=1;
  hazard=0;
  brake=0;
  #100;
  brake=0;
  hazard=0;
  #500;$stop;
end
endmodule
  