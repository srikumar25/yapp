`define DATA_WIDTH 	8
`define ADDR		8	

`timescale 1ns/1ns

module yapp_dut(clk,reset,
                in_data,in_data_vld,in_suspend,
                data_0,data_vld_0,suspend_0,
                data_1,data_vld_1,suspend_1,
                data_2,data_vld_2,suspend_2,
                hdata_in,hdata_out,haddr,hen,hw_rd,
                error);

                
  input clk,reset,in_data_vld;
  input [`DATA_WIDTH-1:0] in_data;
  input suspend_0,suspend_1,suspend_2;
  input [`DATA_WIDTH-1:0] hdata_in;
  input [`ADDR-1:0] haddr;
  input hen,hw_rd;
  
  output reg in_suspend;
  output reg [7:0] data_0,data_1,data_2;
  output reg data_vld_0,data_vld_1,data_vld_2;
  output reg error;
  output reg [7:0] hdata_out;
   
  reg [7:0] data_0r,data_1r,data_2r;
  reg [7:0] H,Hr;
  reg [2:0] cs,ns;
  reg [7:0] MAXPKTSIZE,MAXPKTSIZE_r,ROUTER_EN,ROUTER_EN_r;
  
  always@(posedge clk or negedge reset)
    begin
      if(!reset)
        begin
        MAXPKTSIZE_r <= 0;
        ROUTER_EN_r <= 0;
      end
    else
      begin
      MAXPKTSIZE_r <= MAXPKTSIZE;
      ROUTER_EN_r <= ROUTER_EN;
      end 
    end
  
  always@(posedge clk or negedge reset)
    begin
    if(!reset)
      error <= 0;
    else if(MAXPKTSIZE >= (cs == 1 && Hr[7:2]))  
       error <= 1;
     else if (cs == 0)
       error <= 0;
     end
       
    
    always@*
      begin
        MAXPKTSIZE = MAXPKTSIZE_r;
        ROUTER_EN  = ROUTER_EN_r;
      
        if(hen && hw_rd && haddr == 0)
         MAXPKTSIZE = hdata_in;
       else if(hen && hw_rd && haddr == 1)
         ROUTER_EN = hdata_in;
       else if(hen && !hw_rd && haddr == 0)
         hdata_out = MAXPKTSIZE_r;
       else if(hen && !hw_rd && haddr == 1)
         hdata_out = ROUTER_EN_r;
      end
  
  always@(posedge clk or negedge reset)
    begin
      if(!reset)
        begin
          cs <= 0;
          Hr <= 0;
          data_0r <= 'h0;
          data_1r <= 'h0;
          data_2r <= 'h0;
        end
      else
        begin
          cs <= ns;
          Hr <= H;
          data_0r <= data_0;
          data_1r <= data_1;
          data_2r <= data_2;
        end
      end
    
    always@*
      begin
        ns = cs;
        in_suspend = 0;
        H = Hr;
        data_0 = data_0r;
        data_1 = data_1r;
        data_2 = data_2r;
        
        if(ROUTER_EN_r)begin
        case(cs)
          0: begin 
            data_vld_0 = 0;
            data_vld_1 = 0;
            data_vld_2 = 0;
            
            if(in_data_vld)
              begin
              H = in_data;
              ns = 1;
              end
            end
            
          1: begin
            case(H[1:0])
              0: begin
                data_0 = in_data; 
                data_vld_0 = in_data_vld;
                in_suspend = suspend_0;
                if(~in_data_vld)
                  ns = 2;
              end
              1: begin
                data_1 = in_data;
                data_vld_1 = in_data_vld;
                in_suspend = suspend_1;
                if(~in_data_vld)
                  ns = 2;
              end
              2: begin
                data_2 = in_data;
                data_vld_2 = in_data_vld;
                in_suspend = suspend_2;
                if(~in_data_vld)
                  ns = 2;
              end
              3: begin
                data_vld_0 = 0;
                data_vld_1 = 0;
                data_vld_2 = 0;
                if(~in_data_vld)
                  ns = 2;
              end
            endcase
          end
            
            2: begin
          case(H[1:0])
              0: begin
                data_0 = in_data;
                ns = 0;
              end
              1: begin
                data_1 = in_data;
                ns = 0;
              end
              2: begin
                data_2 = in_data;
                ns = 0;
              end
              3: ns = 0;
            endcase
          end
        endcase
      end      
      end
                        
endmodule     

