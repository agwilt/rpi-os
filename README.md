# Bare metal assembly project for my Pi

For now, I'm assuming a Raspberry Pi B+, though I'll try to make this portable later.

The code is under `source/`, and the binaries under `build/`.

**Source files:**
* `main.s`: the main file (containg `_start`).
* `gpio.s`: subroutines for GPIO stuff
* `misc.s`: miscellaneous functions
* `constants.s`: useful constants for the assembler
