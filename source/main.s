.set LED_PIN, 47
.set GPIO_BASE, 0x20200000

.section .init
.globl _start
_start:

// sore GPIO controller address in r0
ldr r0, =GPIO_BASE

// next, enable output for pin 47 (001 is output, 000 input)
mov r1, #1
lsl r1, #21
// 4th set of GPIO words (GPIO_BASE+16 bytes)
str r1, [r0, #16]

// get number to set pin 47
mov r1, #1
lsl r1, #15

//loop for ever
loop$:
	b loop$
