// 4-bit ALU
// op: 000 ADD, 001 SUB, 010 AND, 011 OR, 100 XOR, 101 NOT A, 110 SHL, 111 SHR
module alu (
    input  [3:0] a,
    input  [3:0] b,
    input  [2:0] op,
    output reg [3:0] result,
    output reg carry,
    output zero
);

    always @(*) begin
        carry = 0;
        case (op)
            3'b000: {carry, result} = a + b;
            3'b001: {carry, result} = a - b;   // carry = borrow
            3'b010: result = a & b;
            3'b011: result = a | b;
            3'b100: result = a ^ b;
            3'b101: result = ~a;
            3'b110: {carry, result} = {a, 1'b0};
            3'b111: begin
                result = a >> 1;
                carry  = a[0];
            end
            default: result = 4'b0000;
        endcase
    end

    assign zero = (result == 4'b0000);

endmodule
