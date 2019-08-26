module light_tb();
reg clk,reset,left,right,hazard,brake;
wire [5:0] lights;

light dut(
  .clk(clk),
  .reset(reset),
  .left(left),
  .right(right),
  .hazard(hazard),
  .brake(brake),
  .lights(lights)
);

initial begin
  clk=0;
  forever #10 clk=~clk;
end
initial begin
  reset=0;
  left=1;
  right=0;
  hazard=1;
  brake=0;
  #100;
  brake=1;
  hazard=0;
  #500;$stop;
end
endmodule
  