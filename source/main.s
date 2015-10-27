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

	mov r0, #LED_OK
	mov r1, #GPIO_HIGH
	bl gpio_output

	mov r0,#0x3F0000
	bl sleep


	/* switch off */

	mov r0, #LED_OK
	mov r1, #GPIO_LOW
	bl gpio_output

	mov r0,#0x3F0000
	bl sleep

	b loop$
