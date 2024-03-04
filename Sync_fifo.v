module fifo #(parameter Depth=8,Width=16)(input rst,clk,write_en,read_en,input [Width-1:0]d_in,output reg[Width-1:0]d_out,output empty,full);
  parameter ptr_width=$clog2(Depth);
  reg [ptr_width:0]rptr;
  reg [ptr_width:0]wptr;
  reg [Width-1:0]storage[Depth-1:0];
  always@(posedge clk or posedge rst) begin

    // rst conditions
    if(rst) begin
      wptr=0;
      rptr=0;
      d_out=0;
    end
  end

  //write condition
  always@(posedge clk) begin
    if(write_en==1 && full==0) begin
      storage[wptr]=d_in;
      wptr=wptr+1;
    end
  end

  //read condition
  always @(posedge clk) begin
    if(read_en ==1 && empty==0) begin
      d_out=storage[rptr];
      rptr=rptr+1;
    end
  end

  //empty condition
  assign empty=(wptr==rptr);
  
  //full condition
  assign full=((wptr[ptr_width]!=rptr[ptr_width]) && (wptr[ptr_width-1:0]==rptr[ptr_width-1:0]));
endmodule
