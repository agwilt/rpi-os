.include "constants.s"

.section .init
.globl _start
_start:

//enable output for pin 47
mov r0, #47
mov r1, #GPIO_OUT
bl gpio_set_function

// get number to set pin 47
mov r1, #1
lsl r1, #15

// store GPIO controller address in r0
ldr r0, =GPIO_BASE


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
