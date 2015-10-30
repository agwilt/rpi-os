.include "constants.s"

.section .init
.globl _start
_start:
b main


.section .text
main:
mov sp,#0x8000

//enable output for the OK LED pin
mov r0, #LED_OK				// set pin number
mov r1, #GPIO_OUT			// set pin function
bl gpio_set_function

//enable output for the PWR LED pin
mov r0, #LED_PWR			// set pin number
mov r1, #GPIO_OUT			// set pin function
bl gpio_set_function

//loop for ever
loop$:

	/* both off */

	mov r0, #LED_PWR
	mov r1, #GPIO_LOW
	bl gpio_output

	mov r0, #LED_OK
	mov r1, #GPIO_LOW
	bl gpio_output

	ldr r0,=100000
	bl sleep

	/* OK on */

	mov r0, #LED_OK
	mov r1, #GPIO_HIGH
	bl gpio_output

	ldr r0,=100000
	bl sleep

	/* both on */

	mov r0, #LED_PWR
	mov r1, #GPIO_HIGH
	bl gpio_output

	ldr r0,=100000
	bl sleep

	/* PWR on */

	mov r0, #LED_OK
	mov r1, #GPIO_LOW
	bl gpio_output

	ldr r0,=100000
	bl sleep

	b loop$
