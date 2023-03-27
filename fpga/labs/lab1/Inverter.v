//
// Verilog code for a simple inverter
//
/*
    LAE 2023 (Please note that VHDL does not support multi-line comments!!)
    - Please note that Verilog is case-sensitive (like C), while VHDL is not (like ADA).
    - With a few exceptions, each module will be placed in a different file (like)
      classes in C++. The names will be CamelCased.
    - INDENTATION: ALWAYS DONE WITH 4 TABS!
*/

//This construct is used for simulation
`timescale 1ps/1ps

/*
module Inverter(X, ZN);   //Verilog-95
    input X;
    output ZN;
    //The ports are considered by default as wire, if reg is not specified.
    //A port can be configured as inout.
    
endmodule
*/

module Inverter(   //Verilog-2001
    input X,
    output ZN
    );
    //The ports are considered by default as wire, if reg is not specified.
    //A port can be configured as inout.

    //Let's to a continuous assignment, since X and ZN (the output) are both "wire"s

    assign ZN = !X;  // ! is the logical not.
    
endmodule


// Simulation is performed using a test-bench. A test-bench is a module istantiating the
// DUT (device under test) that is the module that we would like to test.
// Usually the TB is stored in another Verilog source file.


//Notes: hardware implementation of INOUT:
//  Tri-state output buffer (low, high, high-Z) in parallel with input buffer
//  To be used as input, configure the output buffer as high-Z

//Verilog natively provides four logic values: 
/*
  -> 1, 0, X, Z 
  X = "unknown", logic value well-defined, but unknown
  Z = high-Z state, electric value not well-defined

  Please note that in VHDL, to include X,Z etc... the external library
  IEEE.std_logic_1164.all is required. This library introduces 9 states:
  -> "don't care state" X-.
  -> "unassigned" U.
  -> "weak high"
  -> "weak low"
  etc...
*/

//Simulation
/*
  The most common simulation type is digital waveform V(t).
  Color codes for Vivado XSIM:
  -> X (red)
  -> 1 / 0 (green) with plotted value
  -> Z (blue)
*/

//Verilog Data Types
/*
  - Nets:
    - WIRE "wire"
    - REGISTERS "reg"
    - supply0
    - supply1
    - triand
    - trior
    - tri
    - ...

  WARNING! A "reg" does not mean that a flip-flop is inferred!
           it is up to the synthetizer.

  "wire" are assigned using a "continuous assignment". It means
  that the output of the wire is automatically updated as the input changes,
  (asyncronously) without requiring clock cycles, only propagation delay.

  assign a = b

  Operations such as

  sum = sum + 1

  are possible if and only if the sum is a register, because it does require
  memory to store the value. BUT it doesn't mean that a flip-flop is 
  automatically inferred. It is possible to make combinatory logic using "reg"!
  (In System Verilog this ambiguity is solved by introducing the "logic" type.)

  Assignments are generally evaluated IN PARALLEL, with the exception of
  the procedural blocks: 'initial' and 'always'

  The default of input and output nets is "wire", but is recommended to specify!
  The input is always "wire", because it is a driven signal.
  The output can be either a "wire" or a "reg", depending on the implementation.
*/

//SCALARS AND BUSES
/*
  wire X
  This is a scalar

  wire [N:0] Y
  This is a BIG endian bus

  wire [0:N] Z
  This is a small endian bus

  These are packed arrays! They can be sliced as
  reg [31:0] Z;
  Z[31:16]
  Z[15:0]
  This can be used to split and merge data buses

  HERE WE WILL USE BIG ENDIAN!!!

  scalars can be concatenated to form a bus by using {} curly brackets
  wire [15:0] X;
  wire [15:0] Y;
  wire  [31:0] Z;
  assign Z = {X,Y};

*/

//LOGIC INVERSION
/*
  Let's consider a 5-bit bus 
  reg [4:0] myBus;
  Containing [1,0,1,0,1]

  There is a difference between the LOGICAL operation,
  it means asking if the number of the bus is equal to, for example, 6
  myBus != 6    (! is the logical NOT)
  and inverting the logic state of each bit of the bus
  ~myBus        (~ is the bit-wise NOT)

*/