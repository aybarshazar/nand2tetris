// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Pseudocode:

// MAIN_LOOP:
//   kbd_value = pressed_key
//   if kbd_value == 0 goto CLEAR
//   if kbd_value != 0 goto BLACKEN
//   goto MAIN_LOOP
// BLACKEN:
//   addr = 16384 (start address of screen)
//   last_screen_addr = 24575 (last address of screen)
//
//   BLACKEN_LOOP:
//     if addr > last_screen_addr goto MAIN_LOOP
//     RAM[addr] = -1 (1111 1111 1111 1111)
//     addr = addr + 1
//     goto BLACKEN_LOOP
// CLEAR:
//   addr = 16384 (start address of screen)
//   last_screen_addr = 24575 (last address of screen)
//
//   CLEAR_LOOP:
//     if addr > last_screen_addr goto MAIN_LOOP
//     RAM[addr] = 0 (0000 0000 0000 0000)
//     addr = addr + 1
//     goto CLEAR_LOOP


(MAIN_LOOP)
  @KBD
  D = M

  @CLEAR
  D ; JEQ // jump to clear if keyboard register is zero (no key is pressed)

  @BLACKEN
  D ; JNE // jump to blacken if keyboard register is not zero (key is pressed)

  @MAIN_LOOP
  0 ; JMP // jump to MAIN_LOOP

(END)

(BLACKEN)
  @SCREEN
  D = A
  @addr
  M = D // addr = 16384, base address of the screen

  @24575
  D = A // D = 24575, last register address of screen, keyboard starts at 24576
  @last_screen_addr
  M = D

  (BLACKEN_LOOP)
    @last_screen_addr
    D = M
    @addr
    D = D - M // calculate last_screen_addr - addr

    @MAIN_LOOP
    D ; JLT // jump to MAIN_LOOP if (last_screen_addr - addr) < 0

    @addr
    A = M
    M = -1 // RAM[addr] = 1111 1111 1111 1111

    @addr
    D = M
    M = D + 1 // addr = addr + 1

    @BLACKEN_LOOP
    0 ; JMP // jump to BLACKEN_LOOP

(CLEAR)
  @SCREEN
  D = A
  @addr
  M = D // addr = 16384, base address of the screen

  @24575
  D = A // D = 24575, last register address of screen, keyboard starts at 24576
  @last_screen_addr
  M = D

  (CLEAR_LOOP)
    @last_screen_addr
    D = M
    @addr
    D = D - M // calculate last_screen_addr - addr

    @MAIN_LOOP
    D ; JLT // jump to MAIN_LOOP if (last_screen_addr - addr) < 0

    @addr
    A = M
    M = 0 // RAM[addr] = 0000 0000 0000 0000

    @addr
    D = M
    M = D + 1 // addr = addr + 1

    @CLEAR_LOOP
    0 ; JMP // jump to CLEAR_LOOP
