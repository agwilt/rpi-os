.include "constants.s"

.section .init
.globl _start
_start:

//enable output for the OK LED pin
mov r0, #LED_OK				// set pin number
mov r1, #GPIO_OUT			// set pin function
bl gpio_set_function

//loop for ever
loop$:

	/* switch on */
	//str r1,[r0,#32]

	mov r0, #LED_OK
	mov r1, #GPIO_HIGH
	bl gpio_output

	mov r2,#0x3F0000
	wait1$:
		sub r2,#1
		cmp r2,#0
		bne wait1$

	/* switch off */
	//str r1,[r0,#44]

	mov r0, #LED_OK
	mov r1, #GPIO_LOW
	bl gpio_output

	mov r2,#0x3F0000
	wait2$:
		sub r2,#1
		cmp r2,#0
		bne wait2$

	b loop$
