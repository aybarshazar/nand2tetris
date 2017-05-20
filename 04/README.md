Machine language

Assembly language (symbolic code) --- Translate (Assembler) ---> Machine language (binary code) --- Execute --->

- Binary code vs Symbolic mnemonics

- Memory: Memory[address], RAM[address], M[address]
- Processor: CPU
- Registers
  - D register: stores data values
  - A register: stores data values, addresses in data memory, addresses in instruction memory
    - M: Refers to the memory word whose address is the current value of the A register

Examples:

@3
D = M // D = Memory[3] (content of A is 3, M is Memory[A])

@5
D = D - A  // D = D - 5 (content of A is 5)

- Hack machine language program for multiplication
- Hack machine language program that blackens the screen on key press and clears the screen otherwise
