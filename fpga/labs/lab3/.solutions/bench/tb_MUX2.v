//
// Testbench for different MUX implementations.
//
// Luca Pacher - pacher@to.infn.it
// Spring 2020
//


`timescale 1ns / 100ps

module tb_MUX2 ;


   /////////////////////////
   //   clock generator   //
   /////////////////////////

   /*
   parameter real PERIOD = 50.0 ;       // 50 ns clock period declared as Verilog parameter

   reg clk = 1'b0 ;

   always #(PERIOD/2.0) clk = ~ clk ;   // force the toggle each PERIOD/2
   */

   wire clk ;

   ClockGen #(.PERIOD(50.0)) ClockGen (.clk(clk)) ;


   ////////////////////////////////////
   //   2-bits synchronous counter   //
   ////////////////////////////////////

   reg [1:0] count = 2'b00 ;

   always @(posedge clk)
      count <= count + 1'b1 ;           // **WARN: be aware of the casting ! This is count[2:0] <= count[2:0] + 1'b1 !


   /////////////////////////////////
   //   device under test (DUT)   //
   /////////////////////////////////

   reg  select ;
   wire Z;

   MUX2  DUT (.A(count[0]), .B(count[1]), .S(select), .Z(Z)) ;
   //MUX2  DUT (.A(1'b1), .B(1'b1), .S(select), .Z(Z)) ;


   ///////////////////////
   //   main stimulus   //
   ///////////////////////

   initial begin

      #0   select = 1'b1 ;     // initial value at t=0

      #500 select = 1'b0 ;
      #450 select = 1'b1 ;
      #500 select = 1'b0 ;
      #450 select = 1'b1 ;
      
      #500 $finish ;           // stop the simulation
   end


   // text-based simulation output
   initial begin
      $display("\t\t\t\t   time   S   A   B   Z") ;
      $monitor("%d ns   %b   %b   %b   %b",$time, select, count[0], count[1], Z) ;
   end


   // dump waveforms into industry-standard Value Change Dump (VCD) database
   initial begin
      $dumpfile ("waveforms.vcd") ;
      $dumpvars ;
   end

endmodule

