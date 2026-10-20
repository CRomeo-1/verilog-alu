# 4-bit ALU in Verilog

A 4-bit Arithmetic Logic Unit written in Verilog with a testbench. Made for my digital logic / computer architecture practice.

## Operations

| op | Operation | Description |
|---|---|---|
| 000 | ADD | a + b (carry = overflow) |
| 001 | SUB | a - b (carry = borrow) |
| 010 | AND | a & b |
| 011 | OR  | a \| b |
| 100 | XOR | a ^ b |
| 101 | NOT | ~a |
| 110 | SHL | shift a left (carry = bit shifted out) |
| 111 | SHR | shift a right (carry = bit shifted out) |

Flags:
- `carry` - carry / borrow / shifted bit
- `zero` - 1 when the result is 0

## Files
- `alu.v` - the ALU module (combinational, uses `always @(*)` and `case`)
- `alu_tb.v` - testbench that checks every operation and prints PASS / FAIL

## Run the simulation
Using [Icarus Verilog](https://steveicarus.github.io/iverilog/):
```bash
iverilog -o sim alu.v alu_tb.v
vvp sim
```

Output:
```
PASS op=000 a= 5 b= 3 -> result= 8 carry=0 zero=0
PASS op=000 a=12 b= 7 -> result= 3 carry=1 zero=0
PASS op=001 a= 3 b= 5 -> result=14 carry=1 zero=0
...
All tests passed
```

The testbench also writes `alu.vcd`, you can open it in GTKWave to see the waveforms.
