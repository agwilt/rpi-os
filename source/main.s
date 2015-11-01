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
ldr r6, =200000				// base duration
add r5, r4, r4, lsl #1		// r5 = 3*r4

loop$:
	// s
	ldr r0, =s
	bl morse



morse:
	// r0: pattern
	// r1: base duration
	push {lr}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	mov r4, r0				// pattern
	mov r5, #0				// counter
	mov r6, #0b11			// mask
	mov r7, r1				// base duration

	morseloop$:
		mov r0, r4				// pattern in r0
		add r1, r5, r5			// r2 = 2*counter
		lsr r0, r1				// shift pattern to the right so important pair is aat right
		and r0, r6				// clear the rest of the bits
		// r0 now contains the 'character' code
		cmp r0, #0				// return if code is 00
		b morse_end$

		mul r1, r7, r0			// blink duration is code*base duration
		mov r0, #LED_OK
		bl gpio_blink

		//loop end stuff
		add r5, #1

	morse_end$:
		pop {r7}
		pop {r6}
		pop {r5}
		pop {r4}
		pop {pc}



.section .data

.align 2
s:
	.int 0b00000000000000000000000000010101
.align 2
o:
	.int 0b00000000000000000000000000111111
