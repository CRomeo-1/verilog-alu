`timescale 1ns/1ps

module alu_tb;
    reg  [3:0] a, b;
    reg  [2:0] op;
    wire [3:0] result;
    wire carry, zero;

    integer errors = 0;

    alu uut (.a(a), .b(b), .op(op), .result(result), .carry(carry), .zero(zero));

    task check(input [3:0] exp_result, input exp_carry);
        begin
            #10;
            if (result !== exp_result || carry !== exp_carry) begin
                $display("FAIL op=%b a=%d b=%d -> result=%d carry=%b (expected %d, %b)",
                         op, a, b, result, carry, exp_result, exp_carry);
                errors = errors + 1;
            end else
                $display("PASS op=%b a=%d b=%d -> result=%d carry=%b zero=%b",
                         op, a, b, result, carry, zero);
        end
    endtask

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);

        op = 3'b000; a = 5;  b = 3;  check(8, 0);    // add
        op = 3'b000; a = 12; b = 7;  check(3, 1);    // add with overflow
        op = 3'b001; a = 9;  b = 4;  check(5, 0);    // sub
        op = 3'b001; a = 3;  b = 5;  check(14, 1);   // sub with borrow
        op = 3'b010; a = 4'b1100; b = 4'b1010; check(4'b1000, 0);
        op = 3'b011; a = 4'b1100; b = 4'b1010; check(4'b1110, 0);
        op = 3'b100; a = 4'b1100; b = 4'b1010; check(4'b0110, 0);
        op = 3'b101; a = 4'b1100; b = 0;       check(4'b0011, 0);
        op = 3'b110; a = 4'b1011; b = 0;       check(4'b0110, 1);
        op = 3'b111; a = 4'b1011; b = 0;       check(4'b0101, 1);
        op = 3'b001; a = 6;  b = 6;  check(0, 0);    // zero flag

        if (errors == 0) $display("\nAll tests passed");
        else $display("\n%0d tests failed", errors);
        $finish;
    end
endmodule
