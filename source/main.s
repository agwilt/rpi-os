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

mov r0, #LED_PWR
mov r1, #GPIO_HIGH
bl gpio_output

ldr r4, =pattern			// morse pattern to blink
mov r5, #0					// count how far along the pattern we are
ldr r6, =200000				// dot length
morse_loop$:
	mov r0, #1
	lsl r0, r5
	ands r0, r4				// 1 if led on, 0 if off
	beq morse_low$			// b to morse_low if r0 is 0

	mov r0, #LED_OK			// blink LED for r6 microseconds
	mov r1, r6
	bl gpio_blink
	b morse_loop_end$

	morse_low$:				// sleep for r6 microseconds
	mov r0, r6
	bl st_sleep

	morse_loop_end$:
	add r5, #1				// increment counter
	cmp r5, #31				// loop if counter is under max
	bls morse_loop$

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
