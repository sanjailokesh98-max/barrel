`timescale 1ns/1ps

module tb_barrel_shifter;

    reg  [7:0] data_in;
    reg  [2:0] shift_amt;
    reg  [2:0] shift_op;
    wire [7:0] data_out;

    barrel_shifter #(8) DUT (
        .data_in(data_in),
        .shift_amt(shift_amt),
        .shift_op(shift_op),
        .data_out(data_out)
    );

    initial begin
        data_in = 8'b10110011;

        // Logical Left Shift by 2
        shift_amt = 2;
        shift_op  = 3'b000;
        #10;

        // Logical Right Shift by 2
        shift_op = 3'b001;
        #10;

        // Arithmetic Right Shift by 2
        shift_op = 3'b010;
        #10;

        // Rotate Left by 2
        shift_op = 3'b011;
        #10;

        // Rotate Right by 2
        shift_op = 3'b100;
        #10;

        $finish;
    end

    initial begin
        $monitor("Time=%0t Data=%b Shift=%0d Op=%b Output=%b",
                  $time, data_in, shift_amt, shift_op, data_out);
    end

endmodule
