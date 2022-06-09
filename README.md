# Natalius SOC - 8 bit RISC Processor for video games

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)

| :exclamation: Important Note            |
|-----------------------------------------|

## Description
Natalius is a compact, capable and fully embedded 8 bit RISC processor core described 100% in Verilog. This processor includes a very tiny VGA Controller suitable for VideoGames :)

The instruction memory is implemented in two BlockRAM Memories, it stores 2048 instructions, each instruction has a width of 16 bits (2048x16). Each instruction takes 3 clock cycles to be executed.

## Features

1. 8 Bit ALU
2. 8x8 Register File
3. 2048x16 Instruction Memory
4. 32x8 Ram Memory
5. 16x11 Stack Memory
6. Three CLK/Instruction
7. Carry and Zero flags
8. No operation Instruction (nop)
9. 8 bit Address Port (until 256 Peripherals)
10. LDI, LDM, STM (Memory Access Instructions)
11. CMP, ADD, ADI, SUB (Arithmetic Instructions)
12. AND, OOR, XOR, NOP, SL0, SL1, SR0, SR1, RRL, RRR (Logical Instructions)
13. JMP, JPZ, JNZ, JPC, JNC, CSR, RET, CSZ, CNZ, CSC, CNC (Flow Control Instructions)
