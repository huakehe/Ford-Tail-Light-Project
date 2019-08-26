module dim(
  input dimclk,ctrl,clk,reset,left,right,hazard,brake,
  //input [5:0] lights,
  output reg [5:0] led=6'b000000
  );
  wire [5:0] b;
  reg [5:0] c=6'b000000;
  
  light out(.clk(clk),.reset(reset),.left(left),.right(right),.hazard(hazard),.brake(brake),.lights(b));
  
  always @(posedge dimclk)begin
  
  if(~ctrl) begin
  c<=b;
  led<=c;
  
  end
  else begin
     c<=b;
    if(b[5]==0) begin c[5]<=~c[5];end
    if(b[4]==0)  begin c[4]<=~c[4];end
    if(b[3]==0)  begin c[3]<=~c[3];end
    if(b[2]==0)  begin c[2]<=~c[2];end
    if(b[1]==0)  begin c[1]<=~c[1];end
    if(b[0]==0)   begin c[0]<=~c[0];end
   
    led<=c;
  end
 end 
endmodule







module light(
input clk,reset,left,right,hazard,brake,
output reg [5:0]lights = 6'b000000
);
 
 parameter IDLE= 0; 
 parameter IL= 7; 
 parameter IR= 14;
 parameter L3=3;  
 parameter L2=2;   
 parameter L1=1;   
 parameter Lb3 = 6; 
 parameter Lb2 = 5;  
 parameter Lb1 = 4;  
 parameter R1=8;    
 parameter R2=9;     
 parameter R3=10;     
 parameter Rb3 = 13; 
 parameter Rb2 = 12;   
 parameter Rb1 = 11;   
 parameter All=15;
    
  reg [3:0]x = 4'd0000;

always @(posedge clk) 
    if(reset)begin
 x<=IDLE;
 lights<=6'b000000;
 end
    else begin
    case (x)
      //IDLE
      0: 
          if((brake)&(hazard)) begin x<=All;lights<=6'b111111;end
          else  if(hazard)    begin x<=All;lights<=6'b111111;end
         
          else if((~brake)&(~hazard)&(~left)&(~right))begin x<=IDLE;lights<=6'b000000;end
          else if((~brake)&(~hazard)&(~left)&(right)) begin x<=R1; lights<=6'b000100; end
          else if((~brake)&(~hazard)&(left)&(~right)) begin x<=L1; lights<=6'b001000; end
          else if((~brake)&(~hazard)&(left)&(right))  begin x<=All; lights<=6'b111111; end
          else if((brake)&(~hazard)&(~left)&(~right)) begin x<=All; lights<=6'b111111; end
         
          else if((brake)&(~hazard)&(~left)&(right))  begin x<=Rb1; lights<=6'b111100; end
          else if((brake)&(~hazard)&(left)&(~right)) begin x<=Lb1; lights<=6'b001111; end
          else if((brake)&(~hazard)&(left)&(right)) begin x<=All; lights<=6'b111111; end
           else if ((left)&(right)) begin x<=All;lights<=6'b111111;end
          else begin x<=IDLE; lights<=6'b000000; end
             
      7: //IL,
         
          //
          if((brake)&(hazard)) begin x<=All;lights<=6'b111111;end
          else  if(hazard)    begin x<=All;lights<=6'b111111;end
          else if((~brake)&(~hazard)&(~left)&(~right))begin x<=IDLE;lights<=6'b000000;end
          else if((~brake)&(~hazard)&(~left)&(right)) begin x<=R1; lights<=6'b000100; end
          else if((~brake)&(~hazard)&(left)&(~right)) begin x<=L1; lights<=6'b001000; end
          else if((~brake)&(~hazard)&(left)&(right))  begin x<=All; lights<=6'b111111; end
          else if((brake)&(~hazard)&(~left)&(~right)) begin x<=All; lights<=6'b111111; end
          else if((brake)&(~hazard)&(~left)&(right))  begin x<=Rb1; lights<=6'b111100; end
          else if((brake)&(~hazard)&(left)&(~right)) begin x<=Lb1; lights<=6'b001111; end
          else if((brake)&(~hazard)&(left)&(right)) begin x<=All; lights<=6'b111111; end
          else begin x<=IL; lights<=6'b000111; end
             
    
          
       10: //R3
         
          //
          if((brake)&(hazard)) begin x<=All;lights<=6'b111111;end
          else  if(hazard)    begin x<=All;lights<=6'b111111;end
          else if((~brake)&(~hazard)&(~left)&(~right))begin x<=IDLE;lights<=6'b000000;end
          else if((~brake)&(~hazard)&(~left)&(right)) begin x<=IDLE; lights<=6'b000000; end
          else if((~brake)&(~hazard)&(left)&(~right)) begin x<=L1; lights<=6'b001000; end
          else if((~brake)&(~hazard)&(left)&(right))  begin x<=All; lights<=6'b111111; end
          else if((brake)&(~hazard)&(~left)&(~right)) begin x<=All; lights<=6'b111111; end
         
          else if((brake)&(~hazard)&(~left)&(right))  begin x<=IR; lights<=6'b111000; end
          else if((brake)&(~hazard)&(left)&(~right)) begin x<=Lb1; lights<=6'b001111; end
          else if((brake)&(~hazard)&(left)&(right)) begin x<=All; lights<=6'b111111; end
          else begin x<=R3; lights<=6'b000111; end
          
     14: //IR
          if((brake)&(hazard)) begin x<=All;lights<=6'b111111;end
          else  if(hazard)    begin x<=All;lights<=6'b111111;end
          else if((~brake)&(~hazard)&(~left)&(~right))begin x<=IDLE;lights<=6'b000000;end
          else if((~brake)&(~hazard)&(~left)&(right)) begin x<=R1; lights<=6'b000100; end
          else if((~brake)&(~hazard)&(left)&(~right)) begin x<=L1; lights<=6'b001000; end
          else if((~brake)&(~hazard)&(left)&(right))  begin x<=All; lights<=6'b111111; end
          else if((brake)&(~hazard)&(~left)&(~right)) begin x<=All; lights<=6'b111111; end
         
          else if((brake)&(~hazard)&(~left)&(right))  begin x<=Rb1; lights<=6'b111100; end
          else if((brake)&(~hazard)&(left)&(~right)) begin x<=Lb1; lights<=6'b001111; end
          else if((brake)&(~hazard)&(left)&(right)) begin x<=All; lights<=6'b111111; end
          else begin x<=IR; lights<=6'b111000; end
          
     3: //L3 
         
          //
          if((brake)&(hazard)) begin x<=All;lights<=6'b111111;end
          else  if(hazard)    begin x<=All;lights<=6'b111111;end
          else if((~brake)&(~hazard)&(~left)&(~right))begin x<=IDLE;lights<=6'b000000;end
          else if((~brake)&(~hazard)&(~left)&(right)) begin x<=R1; lights<=6'b000100; end
          else if((~brake)&(~hazard)&(left)&(~right)) begin x<=IDLE; lights<=6'b000000; end
          else if((~brake)&(~hazard)&(left)&(right))  begin x<=All; lights<=6'b111111; end
          else if((brake)&(~hazard)&(~left)&(~right)) begin x<=All; lights<=6'b111111; end
         
          else if((brake)&(~hazard)&(~left)&(right))  begin x<=Rb1; lights<=6'b111100; end
          else if((brake)&(~hazard)&(left)&(~right)) begin x<=IL; lights<=6'b000111; end
          else if((brake)&(~hazard)&(left)&(right)) begin x<=All; lights<=6'b111111; end
          else begin x<=L3; lights<=6'b111000; end
          
      1: //L1
            if((brake)&(hazard)) begin x<=All;lights<=6'b111111;end
          else  if(hazard)    begin x<=All;lights<=6'b111111;end
          else if((~brake)&(~hazard)&(~left)&(~right))begin x<=IDLE;lights<=6'b000000;end
          else if((~brake)&(~hazard)&(~left)&(right)) begin x<=R1; lights<=6'b000100; end
          else if((~brake)&(~hazard)&(left)&(~right)) begin x<=L2;lights<=6'b011000; end
          else if((~brake)&(~hazard)&(left)&(right))  begin x<=All; lights<=6'b111111; end
          else if((brake)&(~hazard)&(~left)&(~right)) begin x<=All; lights<=6'b111111; end
         
          else if((brake)&(~hazard)&(~left)&(right))  begin x<=Rb1; lights<=6'b111100; end
          else if((brake)&(~hazard)&(left)&(~right)) begin x<=Lb2; lights<=6'b011111; end
          else if((brake)&(~hazard)&(left)&(right)) begin x<=All; lights<=6'b111111; end
          else begin x<=L1; lights<=6'b001000; end
            
                
      2: //L2
           if((brake)&(hazard)) begin x<=All;lights<=6'b111111;end
          else  if(hazard)    begin x<=All;lights<=6'b111111;end
          else if((~brake)&(~hazard)&(~left)&(~right))begin x<=IDLE;lights<=6'b000000;end
          else if((~brake)&(~hazard)&(~left)&(right)) begin x<=R1; lights<=6'b000100; end
          else if((~brake)&(~hazard)&(left)&(~right)) begin x<=L3; lights<=6'b111000; end
          else if((~brake)&(~hazard)&(left)&(right))  begin x<=All; lights<=6'b111111; end
          else if((brake)&(~hazard)&(~left)&(~right)) begin x<=All; lights<=6'b111111; end
         
          else if((brake)&(~hazard)&(~left)&(right))  begin x<=Rb1; lights<=6'b111100; end
          else if((brake)&(~hazard)&(left)&(~right)) begin x<=Lb3; lights<=6'b111111; end
          else if((brake)&(~hazard)&(left)&(right)) begin x<=All; lights<=6'b111111; end
          else begin x<=L2; lights<=6'b011000; end
      
      4: //Lb1
          
           if((brake)&(hazard)) begin x<=All;lights<=6'b111111;end
          else  if(hazard)    begin x<=All;lights<=6'b111111;end
          else if((~brake)&(~hazard)&(~left)&(~right))begin x<=IDLE;lights<=6'b000000;end
          else if((~brake)&(~hazard)&(~left)&(right)) begin x<=R1; lights<=6'b000100; end
          else if((~brake)&(~hazard)&(left)&(~right)) begin x<=L2; lights<=6'b011000; end
          else if((~brake)&(~hazard)&(left)&(right))  begin x<=All; lights<=6'b111111; end
          else if((brake)&(~hazard)&(~left)&(~right)) begin x<=All; lights<=6'b111111; end
         
          else if((brake)&(~hazard)&(~left)&(right))  begin x<=Rb1; lights<=6'b111100; end
          else if((brake)&(~hazard)&(left)&(~right)) begin x<=Lb2; lights<=6'b011111; end
          else if((brake)&(~hazard)&(left)&(right)) begin x<=All; lights<=6'b111111; end
          else begin x<=Lb1; lights<=6'b001111; end
            
      5: //Lb2
          if((brake)&(hazard)) begin x<=All;lights<=6'b111111;end
          else  if(hazard)    begin x<=All;lights<=6'b111111;end
          else if((~brake)&(~hazard)&(~left)&(~right))begin x<=IDLE;lights<=6'b000000;end
          else if((~brake)&(~hazard)&(~left)&(right)) begin x<=R1; lights<=6'b000100; end
          else if((~brake)&(~hazard)&(left)&(~right)) begin x<=L3; lights<=6'b111000; end
          else if((~brake)&(~hazard)&(left)&(right))  begin x<=All; lights<=6'b111111; end
          else if((brake)&(~hazard)&(~left)&(~right)) begin x<=All; lights<=6'b111111; end
         
          else if((brake)&(~hazard)&(~left)&(right))  begin x<=Rb1; lights<=6'b111100; end
          else if((brake)&(~hazard)&(left)&(~right)) begin x<=Lb3; lights<=6'b111111; end
          else if((brake)&(~hazard)&(left)&(right)) begin x<=All; lights<=6'b111111; end
          else begin x<=Lb2; lights<=6'b011111; end
       
       6: //Lb3, 
          
           if((brake)&(hazard)) begin x<=All;lights<=6'b111111;end
          else  if(hazard)    begin x<=All;lights<=6'b111111;end
          else if((~brake)&(~hazard)&(~left)&(~right))begin x<=IDLE;lights<=6'b000000;end
          else if((~brake)&(~hazard)&(~left)&(right)) begin x<=R1; lights<=6'b000100; end
          else if((~brake)&(~hazard)&(left)&(~right)) begin x<=IDLE; lights<=6'b000000; end
          else if((~brake)&(~hazard)&(left)&(right))  begin x<=All; lights<=6'b111111; end
          else if((brake)&(~hazard)&(~left)&(~right)) begin x<=All; lights<=6'b111111; end
         
          else if((brake)&(~hazard)&(~left)&(right))  begin x<=Rb1; lights<=6'b111100; end
          else if((brake)&(~hazard)&(left)&(~right)) begin x<=IR; lights<=6'b000111; end
          else if((brake)&(~hazard)&(left)&(right)) begin x<=All; lights<=6'b111111; end
          else begin x<=Lb3; lights<=6'b111111; end
          
       
      13: //Rb3 
          if((brake)&(hazard)) begin x<=All;lights<=6'b111111;end
          else  if(hazard)    begin x<=All;lights<=6'b111111;end
          else if((~brake)&(~hazard)&(~left)&(~right))begin x<=IDLE;lights<=6'b000000;end
          else if((~brake)&(~hazard)&(~left)&(right)) begin x<=IDLE; lights<=6'b000000; end
          else if((~brake)&(~hazard)&(left)&(~right)) begin x<=L1; lights<=6'b001000; end
          else if((~brake)&(~hazard)&(left)&(right))  begin x<=All; lights<=6'b111111; end
          else if((brake)&(~hazard)&(~left)&(~right)) begin x<=All; lights<=6'b111111; end
         
          else if((brake)&(~hazard)&(~left)&(right))  begin x<=IR; lights<=6'b111000; end
          else if((brake)&(~hazard)&(left)&(~right)) begin x<=Lb1; lights<=6'b001111; end
          else if((brake)&(~hazard)&(left)&(right)) begin x<=All; lights<=6'b111111; end
          else begin x<=Rb3; lights<=6'b111111; end
          
       
       15://ALL
          if((brake)&(hazard)) begin x<=All;lights<=6'b111111;end
          else  if(hazard)    begin x<=IDLE;lights<=6'b000000;end
        
          else if((~brake)&(~hazard)&(~left)&(~right))begin x<=IDLE;lights<=6'b000000;end
          else if((~brake)&(~hazard)&(~left)&(right)) begin x<=R1; lights<=6'b000100; end
          else if((~brake)&(~hazard)&(left)&(~right)) begin x<=L1; lights<=6'b001000; end
          else if((~brake)&(~hazard)&(left)&(right))  begin x<=IDLE; lights<=6'b000000; end
          else if((brake)&(~hazard)&(~left)&(~right)) begin x<=All; lights<=6'b111111; end
         
          else if((brake)&(~hazard)&(~left)&(right))  begin x<=Rb1; lights<=6'b111100; end
          else if((brake)&(~hazard)&(left)&(~right)) begin x<=Lb1; lights<=6'b001111; end
          else if((brake)&(~hazard)&(left)&(right)) begin x<=All; lights<=6'b111111; end
            else if((left)&(right))begin x<=IDLE;lights<=6'b000000;end
          else begin x<=All; lights<=6'b111111; end
          
        
     8 : //R1
           
             if((brake)&(hazard)) begin x<=All;lights<=6'b111111;end
          else  if(hazard)    begin x<=All;lights<=6'b111111;end
          else if((~brake)&(~hazard)&(~left)&(~right))begin x<=IDLE;lights<=6'b000000;end
          else if((~brake)&(~hazard)&(~left)&(right)) begin x<=R2; lights<=6'b000110; end
          else if((~brake)&(~hazard)&(left)&(~right)) begin x<=L1; lights<=6'b001000; end
          else if((~brake)&(~hazard)&(left)&(right))  begin x<=All; lights<=6'b111111; end
          else if((brake)&(~hazard)&(~left)&(~right)) begin x<=All; lights<=6'b111111; end
         
          else if((brake)&(~hazard)&(~left)&(right))  begin x<=Rb2; lights<=6'b111110; end
          else if((brake)&(~hazard)&(left)&(~right)) begin x<=Lb1; lights<=6'b001111; end
          else if((brake)&(~hazard)&(left)&(right)) begin x<=All; lights<=6'b111111; end
          else begin x<=R1; lights<=6'b000100; end
          
      9: //R2 
         
           if((brake)&(hazard)) begin x<=All;lights<=6'b111111;end
          else  if(hazard)    begin x<=All;lights<=6'b111111;end
          else if((~brake)&(~hazard)&(~left)&(~right))begin x<=IDLE;lights<=6'b000000;end
          else if((~brake)&(~hazard)&(~left)&(right)) begin x<=R3; lights<=6'b000111; end
          else if((~brake)&(~hazard)&(left)&(~right)) begin x<=L1; lights<=6'b001000; end
          else if((~brake)&(~hazard)&(left)&(right))  begin x<=All; lights<=6'b111111; end
          else if((brake)&(~hazard)&(~left)&(~right)) begin x<=All; lights<=6'b111111; end
         
          else if((brake)&(~hazard)&(~left)&(right))  begin x<=Rb3; lights<=6'b111111; end
          else if((brake)&(~hazard)&(left)&(~right)) begin x<=Lb1; lights<=6'b001111; end
          else if((brake)&(~hazard)&(left)&(right)) begin x<=All; lights<=6'b111111; end
          else begin x<=R2; lights<=6'b000110; end
     11: //Rb1
          if((brake)&(hazard)) begin x<=All;lights<=6'b111111;end
          else  if(hazard)    begin x<=All;lights<=6'b111111;end
          else if((~brake)&(~hazard)&(~left)&(~right))begin x<=IDLE;lights<=6'b000000;end
          else if((~brake)&(~hazard)&(~left)&(right)) begin x<=R2; lights<=6'b000110; end
          else if((~brake)&(~hazard)&(left)&(~right)) begin x<=L1; lights<=6'b001000; end
          else if((~brake)&(~hazard)&(left)&(right))  begin x<=All; lights<=6'b111111; end
          else if((brake)&(~hazard)&(~left)&(~right)) begin x<=All; lights<=6'b111111; end
         
          else if((brake)&(~hazard)&(~left)&(right))  begin x<=Rb2; lights<=6'b111110; end
          else if((brake)&(~hazard)&(left)&(~right)) begin x<=Lb1; lights<=6'b001111; end
          else if((brake)&(~hazard)&(left)&(right)) begin x<=All; lights<=6'b111111; end
          else begin x<=Rb1; lights<=6'b111100; end
          
      12: //Rb2
           if((brake)&(hazard)) begin x<=All;lights<=6'b111111;end
          else  if(hazard)    begin x<=All;lights<=6'b111111;end
          else if((~brake)&(~hazard)&(~left)&(~right))begin x<=IDLE;lights<=6'b000000;end
          else if((~brake)&(~hazard)&(~left)&(right)) begin x<=R3; lights<=6'b000111; end
          else if((~brake)&(~hazard)&(left)&(~right)) begin x<=L1; lights<=6'b001000; end
          else if((~brake)&(~hazard)&(left)&(right))  begin x<=All; lights<=6'b111111; end
          else if((brake)&(~hazard)&(~left)&(~right)) begin x<=All; lights<=6'b111111; end
         
          else if((brake)&(~hazard)&(~left)&(right))  begin x<=Rb3; lights<=6'b111111; end
          else if((brake)&(~hazard)&(left)&(~right)) begin x<=Lb1; lights<=6'b001111; end
          else if((brake)&(~hazard)&(left)&(right)) begin x<=All; lights<=6'b111111; end
          else begin x<=Rb2; lights<=6'b111110; end
      default: x<=0;
  endcase
  
  end


endmodule