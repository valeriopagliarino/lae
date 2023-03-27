//
// Verilog code for the Test-Bench of the simple inverter
//

module tb_Inverter();
    //Usually a TB does not require ports! It is not syntetizable hardware.
    //Let's instantiate the DUT (Device Under Test) (sometimes called Module Under Test)
    Inverter DUT(...);

    //Then we will add the stimuli and they will be connected to the DUT ports.

endmodule