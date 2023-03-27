//
// Verilog code for the Test-Bench of the simple inverter
//

//Setup the timescale, use the backtick to specify a pre-processor directive
//The first value is the value of the time unit, the second value is the time resolution
//It is a very good practice to specify the time cale in every module.
`timescale 1ns/100ps

module tb_Inverter();

    reg in;
    wire out;

    //Usually a TB does not require ports! It is not syntetizable hardware.
    //Let's instantiate the DUT (Device Under Test) (sometimes called Module Under Test)
    
    //Inverter DUT(in, out);

    //WARNING! IT IS POSSIBLE TO PASS CONNECTIONS WITH POSITION ARGUMENTS
    //  (ordered port mapping). PLEASE DON'T!!! Too error-prone solution.
    //Please use by-name-port mapping

    Inverter DUT( .X(in), .ZN(out));

    //The syntax is:     .port_name(wire_connected),
    //Then we will add the stimuli and they will be connected to the DUT ports.

    //   -------------------------
    //  |       Main Stimulus     |
    //   -------------------------

    //Let's introduce one of the sequential blocks of Verilog:
    // This is not synthetizable code! This is software-like code.

    initial begin
      //#500 in = 1;    //THIS IS AN IMPLICIT TYPE CASTING from 32-bit integer to bit, dangerous!!
        #500 in = 1'b1; //Explicit recommended way!
        #800 in = 1'b0;
        #250 in = 1'b1;
        #700 in = 1'b0;
        #715 in = 1'b1;
        #500 $finish;
    end

    //#number => These are (non-synthetizable) sequential delays
    //the numbers are multiples of the time unit specified in the timescale directive
    //$finish is a task (similar to Python @macros) and it tells to the simulator to stop

    //Please note that the digital simulator is NOT a mathematical simulator based on ODEs,
    //it is an event-driven simulator. (It's much faster!)
    //The time resolution is the granularity of the 'check for a new event'.

    //Initialization of wires and buses EXPLICITLY (the safe way, recommended!)
    /*
        wire[11:0] number; //12-bit bus
        assign number = 12'b000_0000_0001

        Radix types:
        b->binary; d->decimal; h->hexadecimal; o->octal
    */

endmodule