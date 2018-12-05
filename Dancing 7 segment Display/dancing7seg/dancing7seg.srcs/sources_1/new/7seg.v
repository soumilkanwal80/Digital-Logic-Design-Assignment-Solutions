module seg7decimal(
    input clk,
    input clr,
    output reg [6:0] seg,
    output reg [3:0] an,
    output wire dp, 
    input BTNR, 
    input BTNL, 
    input BTNC
	 );
	 
	 
wire [1:0] s;	 
reg [3:0] digit;
wire [3:0] aen;
reg [19:0] clkdiv;

assign dp = 1;
assign s = clkdiv[19:18];
assign aen = 4'b1111; // all turned off initially

parameter state1 = 7'b0111111;
parameter state2 = 7'b0011101;
parameter state3 = 7'b0011110;
parameter state4 = 7'b1011100;
parameter state5 =  7'b0111100;

reg[6:0] current_state = state1;
reg[6:0] next_state = state2;

reg[2:0] counter = 3'b000;

reg[26:0] one_sec_counter = 0;

reg l, r, c;

always @(posedge clk)
begin
    if(BTNL == 1 | BTNC == 1 | BTNR == 1)
    begin
        one_sec_counter = 0;
        counter = 0;
    end
    if(counter<5)
    begin
        if(one_sec_counter == 27'b11111111111111111111111111)
        begin
            one_sec_counter = 0;
            counter = counter + 1;
        end
        else
            one_sec_counter = one_sec_counter + 1;
    end
        
    else
    begin
        if(one_sec_counter == 27'b01111111111111111111111111)
        begin
            one_sec_counter = 0;
            counter = 5;
        end
        
        else
            one_sec_counter = one_sec_counter + 1;
    end
    
end



always @(posedge clk)
begin
if(BTNL == 1)
begin
   // current_state = state1;
  
    l = 1;
    c = 0;
    r = 0;
end

if(BTNR == 1)
begin
    //current_state = state1;
    l = 0;
    c = 0;
    r = 1;
end;

if(BTNC == 1)
begin
    //current_state = state1;
    l = 0;
    c = 1;
    r = 0;
end
end


always @(posedge clk)
begin
    case(current_state)
    state1:
        begin
        if(l == 1 && r == 0)
            next_state = state2;
        else if(l == 0 && r == 1)
            next_state = state2;
        else
            next_state = state1;
        end
    
    state2:
    begin
    if(l == 1 && r == 0)
        next_state = state3;
    else if(l == 0 && r == 1)
        next_state = state5;
    else
        next_state = state1;
    end
    
    state3:
    begin
    if(l == 1 && r == 0)
        next_state = state4;
    else if(l == 0 && r == 1)
        next_state = state2;
    else
        next_state = state1;
    end
    
    state4:
    begin
    if(l == 1 && r == 0)
        next_state = state5;
    else if(l == 0 && r == 1)
        next_state = state3;
    else
        next_state = state1;
    end
    
    state5:
    begin
    if(l == 1 && r == 0)
        next_state = state2;
    else if(l == 0 && r == 1)
        next_state = state4;
    else
        next_state = state1;
    end
    
    default: next_state = state1;
    endcase
end   



always @(posedge clk)
begin
    if(one_sec_counter == 0)
    begin
    
       if(BTNC == 1 | BTNL == 1 | BTNR == 1)
            current_state = state1;
       else
            current_state = next_state;
        
    end
end    
    
always @ (posedge clk)
begin
    //if(one_sec_counter == 0)
    //begin
        seg = current_state;  
    //end
end




always @(*)begin
an=4'b1110;

end


//clkdiv

always @(posedge clk or posedge clr) begin
if ( clr == 1)
clkdiv <= 0;
else
clkdiv <= clkdiv+1;
end


endmodule
