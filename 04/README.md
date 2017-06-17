Machine language

Key concepts: Op codes, mnemonics, binary machine language, symbolic machine language, assembly, low-level arithmetic, logical, addressing, branching, and I/O commands, CPU emulation, low-level programming.

Assembly language (symbolic code) --- Translate (Assembler) ---> Machine language (binary code) --- Execute --->

- Binary code vs Symbolic mnemonics

- Memory: Memory[address], RAM[address], M[address]
- Processor: CPU
- Registers
  - D register: stores: data values
  - A register: stores: data values, addresses in data memory, addresses in instruction memory
    - M: Refers to the memory word whose address is the current value of the A register
    - Whenever we need to make an operation on the memory, we should first set the A register to select
    the required memory location.
- A instructions
  - Sets the A register to a value
  - Side effect: RAM[A] becomes the selected RAM register
- C instructions (dest = comp ; jump)
  - Computes the value of comp
  - Stores the result in dest
  - If the boolean expression (comp jump 0) is true, jumps to execute the instruction stored in
  ROM[A] (i.e. set A register to a value)
- Pointers
  - Variables that store memory addresses are called pointers
  - Hack pointer logic: Whenever we have to access memory using a pointer, we need an instruction like A=M



Examples:

@21 // sets the A register to 21, selects RAM[21] (i.e. Memory[A] - M) as a side effect

@3
D = M // D = Memory[3] (content of A is 3, M is Memory[A])

@5
D = D - A  // D = D - 5 (content of A is 5)

// Pointers
// RAM[arr+i] = -1
@arr
D = M
@i
A = D + M
M = -1

- Hack machine language program for multiplication
- Hack machine language program that blackens the screen on key press and clears the screen otherwise
