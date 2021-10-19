`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.06.2021 09:12:28
// Design Name: 
// Module Name: approx_mult
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module mult_bth_app_signed( out, x, y );
  parameter wl = 8, vbl = 0;
  output reg signed [wl*2-1:0] out;
  input signed [wl-1:0] x, y;
  //                    x, y
  
  function signed [wl*2-1:0] pp_generator;
    input [2:0] part_x;
    input signed [wl-1:0] y;  
    begin
      case( part_x )
        'b000: pp_generator = 0;
        'b001: pp_generator = y;
        'b010: pp_generator = y;
        'b011: pp_generator = y;
        'b100: pp_generator = 2*y;
        'b101: pp_generator = -2*y;
        'b110: pp_generator = -y;
        'b111: pp_generator = 0;
      endcase
    end
  endfunction
  
  reg [wl*2-1:0] pp [0:wl/2-1];
  reg [2:0] part_x;
  integer i, j;
  
  always @*
  begin
    pp[0] = pp_generator( {x[1], x[0], 1'b0}, y ); 
    for( i = 1; i <= wl/2-1; i = i + 1 )
    begin
      part_x[0] = x[i*2-1]; part_x[1] = x[i*2]; part_x[2] = x[i*2+1];
      pp[i] = pp_generator( part_x, y ) << 2*i;
    end
    
    for( i = 0; i <= wl/2-1; i = i + 1 )
      for( j = 0; j <= vbl - 1; j = j + 1 )
        pp[i][j] = 1'b0;
  end
  
  always @*
  begin
    out = 0;
    for( i = 0; i <= wl/2-1; i = i + 1 )
      out = out + pp[i];
  end
endmodule