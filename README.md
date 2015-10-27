# Bare metal assembly project for my Pi

For now, I'm assuming a Raspberry Pi B+, though I'll try to make this portable later.

The code is under [`source/`](source/), and the binaries under [`build/`](build/).

**Source files:**
* [`main.s`](source/main.s): the main file (containg `_start`).
* [`gpio.s`](source/gpio.s): subroutines for GPIO stuff
* [`misc.s`](source/misc.s): miscellaneous functions
* [`constants.s`](source/constants.s): useful constants for the assembler
