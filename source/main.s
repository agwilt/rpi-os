.set LED_PIN, 47
.set GPIO_BASE, 0x20200000
.set GPIO_OUT, 1
.set GPIO_IN, 0

.section .init
.globl _start
_start:

// store GPIO controller address in r0
ldr r0, =GPIO_BASE

/* enable GPIO output for pin 47*/
/* first we move 1 into r1. Then we shift it left, to get a nice, high number */
mov r1,#1
/* 21: 7x3. It's the 7th set of 3 bits */
lsl r1,#21
/* And it's the word that starts at GPIO+16 bytes */
str r1,[r0,#16]


/*
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
*/

// get number to set pin 47
mov r1, #1
lsl r1, #15



//loop for ever
loop$:

	/* switch on */
	str r1,[r0,#32]
	mov r2,#0x3F0000

	wait1$:
		sub r2,#1
		cmp r2,#0
		bne wait1$

	/* switch off */
	str r1,[r0,#44]
	mov r2,#0x3F0000

	wait2$:
		sub r2,#1
		cmp r2,#0
		bne wait2$

	b loop$

// set mode for a GPIO pin. takes pin number (e.g. 47), mode (GPIO_IN/OUT)
gpio_setmode$:
	nop
