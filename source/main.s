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

// switch on power pin
mov r0, #LED_PWR
mov r1, #GPIO_HIGH
bl gpio_output

// now for the morse stuff
ldr r4, =200000				// duration
add r5, r4, r4, lsl #1		// r5 = 3*r4

loop$:

	//S
	mov r0, #LED_ACT
	mov r1, r4
	bl gpio_blink
	mov r0, r4
	bl st_sleep

	mov r0, #LED_ACT
	mov r1, r4
	bl gpio_blink
	mov r0, r4
	bl st_sleep

	mov r0, #LED_ACT
	mov r1, r4
	bl gpio_blink

	mov r0, r5
	bl st_sleep

	//O
	mov r0, #LED_ACT
	mov r1, r5
	bl gpio_blink
	mov r0, r4
	bl st_sleep

	mov r0, #LED_ACT
	mov r1, r5
	bl gpio_blink
	mov r0, r4
	bl st_sleep

	mov r0, #LED_ACT
	mov r1, r5
	bl gpio_blink

	mov r0, r5
	bl st_sleep

	//S
	mov r0, #LED_ACT
	mov r1, r4
	bl gpio_blink
	mov r0, r4
	bl st_sleep

	mov r0, #LED_ACT
	mov r1, r4
	bl gpio_blink
	mov r0, r4
	bl st_sleep

	mov r0, #LED_ACT
	mov r1, r4
	bl gpio_blink

	mov r0, r5
	bl st_sleep

	b loop$

	
/*
//loop for ever
loop$:

	// both off

	mov r0, #LED_PWR
	mov r1, #GPIO_LOW
	bl gpio_output

	mov r0, #LED_OK
	mov r1, #GPIO_LOW
	bl gpio_output

	ldr r0,=200000
	bl st_sleep

	// OK on

	mov r0, #LED_OK
	mov r1, #GPIO_HIGH
	bl gpio_output

	ldr r0,=200000
	bl st_sleep

	// both on

	mov r0, #LED_PWR
	mov r1, #GPIO_HIGH
	bl gpio_output

	ldr r0,=200000
	bl st_sleep

	// PWR on

	mov r0, #LED_OK
	mov r1, #GPIO_LOW
	bl gpio_output

	ldr r0,=200000
	bl st_sleep

	b loop$
*/

.section .data

.align 2
pattern:
	.int 0b11111111101010100010001000101010
