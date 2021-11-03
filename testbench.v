`timescale 1ns / 1ps

module testbench(

    );
        reg reset;
        reg clk;
        wire[7:0] sigOut; 
        FSK fsk(clk,sigOut);
        FSKdemodule fskdemodule(clk,sigOut);
        
        initial begin
            reset = 1;
            clk = 1;
            #100 reset = 0;
        end
        
        always #50 clk = ~clk;    
endmodule
