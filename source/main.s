.set LED_PIN, 47
.set GPIO_BASE, 0x20200000
.set GPIO_OUT, 1
.set GPIO_IN, 0

.section .init
.globl _start
_start:

// store GPIO controller address in r0
ldr r0, =GPIO_BASE


//next, enable output for pin 47

//mask to clear bits
mov r2, #0b111
lsl r2, #21
//get relevant word, clear the right 3 bits
ldr r1, [r0, #16]
bic r1, r1, r2

//number to write to word
mov r2, #GPIO_OUT
lsl r2, #21
// and add prepared mode
add r1, r2

//now write it back to RAM
str r3, [r0, #16]


// get number to set pin 47
mov r1, #1
lsl r1, #15



//loop for ever
loop$:
	b loop$

// set mode for a GPIO pin. takes pin number (e.g. 47), mode (GPIO_IN/OUT)
gpio_setmode$:
	nop
