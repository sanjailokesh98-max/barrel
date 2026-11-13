`timescale 1ns/1ps

module barrel_shifter #(
    parameter WIDTH = 8
)(
    input  wire [WIDTH-1:0] data_in,
    input  wire [$clog2(WIDTH)-1:0] shift_amt,
    input  wire [2:0] shift_op,
    output reg  [WIDTH-1:0] data_out
);

    // Shift Operation Encoding
    localparam LSL = 3'b000;   // Logical Shift Left
    localparam LSR = 3'b001;   // Logical Shift Right
    localparam ASR = 3'b010;   // Arithmetic Shift Right
    localparam ROL = 3'b011;   // Rotate Left
    localparam ROR = 3'b100;   // Rotate Right

    always @(*) begin
        case (shift_op)

            // Logical Shift Left
            LSL:
                data_out = data_in << shift_amt;

            // Logical Shift Right
            LSR:
                data_out = data_in >> shift_amt;

            // Arithmetic Shift Right
            ASR:
                data_out = $signed(data_in) >>> shift_amt;

            // Rotate Left
            ROL:
                data_out = (data_in << shift_amt) |
                           (data_in >> (WIDTH - shift_amt));

            // Rotate Right
            ROR:
                data_out = (data_in >> shift_amt) |
                           (data_in << (WIDTH - shift_amt));

            // Default
            default:
                data_out = data_in;

        endcase
    end

endmodule

