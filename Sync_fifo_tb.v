module sync_tb;
  
  parameter Width=16;
  parameter Depth=8;
  
  //Signals
  
  reg clk=0,rst=0,write_en=0,read_en=0;
  reg [Width-1:0] data_in;
  wire full,empty;
  wire [Width-1:0] data_out;
  
  fifo x1(.d_out(data_out),.empty(empty),.full(full),.write_en(write_en),.read_en(read_en),.clk(clk),.rst(rst),.d_in(data_in));
  
  always #10 clk=~clk;
  
  initial begin
    $monitor("%t  data_in=%0d, data_out=%0d rst=%0d write_en=%0d read_en=%0d empty=%0d full=%0d, ",$time, data_in,data_out,rst,write_en,read_en,empty,full,);
    $dumpfile("dump.vcd");
    $dumpvars(1);
    rst=1;
    #20;
    rst=0;
    
    write_en=1; read_en=1;
    data_in=8'hAA;
  
    #100;
   
    data_in=8'hCC;
    #100 ;
    data_in=8'hAB;
        
      #7$finish();
      
  end
 endmodule
