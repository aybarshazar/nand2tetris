// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Pseudocode:

//   num = R0
//   times = R1
//   i = 1
//   sum = 0
//   if num == 0 goto STOP
//   if times == 0 goto STOP
// LOOP:
//   if i > times goto STOP
//   sum = sum + R0
//   i = i + 1
//   goto LOOP
// STOP:
//   R2 = sum

@R0
D = M
@num
M = D // num = R0

@R1
D = M
@times
M = D // times = R1

@i
M = 1 // i = 1

@sum
M = 0 // sum = 0

@num
D = M
@STOP
D ; JEQ // return sum immediately (which is zero) if num (R0) is zero

@times
D = M
@STOP
D ; JEQ // return sum immediately (which is zero) if times (R1) is zero

(LOOP)
  @times
  D = M
  @i
  D = D - M // calculate times - i

  @STOP
  D ; JLT // jump to STOP if (times - i) < 0

  @R0
  D = M
  @sum
  M = D + M // sum = sum + R0

  @i
  M = M + 1 // i = i + 1

  @LOOP
  0 ; JMP // jump to LOOP

(STOP)
  @sum
  D = M
  @R2
  M = D // R2 = sum

(END)
  @END
  0 ; JMP // jump to END, infinite loop
