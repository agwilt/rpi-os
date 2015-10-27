# Bare metal assembly project for my Pi

For now, I'm assuming a Raspberry Pi B+, though I'll try to make this portable later.

The code is under [`source/`](source/), and the binaries under [`build/`](build/).
Fir a rough plan, see [TODO](TODO)

**Source files:**
* [`main.s`](source/main.s): the main file (containg `_start`).
* [`gpio.s`](source/gpio.s): subroutines for GPIO stuff
* [`timer.s`](source/timer.s): system timer subroutines
* [`constants.s`](source/constants.s): useful constants for the assembler
