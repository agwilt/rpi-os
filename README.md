# ServOS

[![Join the chat at https://gitter.im/agwilt/rpi-os](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/agwilt/rpi-os?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

A bare metal system to (ultimately) control servos, though at the moment it can only do stuff like blink and morse.

For now, I'm assuming a Raspberry Pi B+, though I'll try to make this portable later.

The code is under [`source/`](source/), and the binaries under [`build/`](build/).
For a rough plan, see [TODO](TODO.md)

A Video:  
[![Blink!](http://img.youtube.com/vi/yJaX_SZM4kE/0.jpg)](https://www.youtube.com/watch?v=yJaX_SZM4kE)

**Source files:**
* [`main.S`](source/main.S): the main file (containg `_start`)
* [`misc.S`](source/misc.S): miscellaneous subroutines
* [`gpio.S`](source/gpio.S): subroutines for GPIO stuff
* [`timer.S`](source/timer.S): system timer subroutines
* [`constants.h`](source/constants.h): useful constants for the assembler
