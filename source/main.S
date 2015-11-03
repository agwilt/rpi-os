#include "constants.h"

.section .init
.globl _start
_start:
b main


.section .text
main:
mov sp,#0x8000

//enable output for the ACT LED pin
mov r0, #LED_ACT				// set pin number
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

loop$:
	mov r0, #LED_ACT
	mov r1, r6
	bl gpio_blink

	// s
	ldr r0, =letter_s
	mov r1, r6
	bl morse

	// o
	ldr r0, =letter_o
	mov r1, r6
	bl morse

	// s
	ldr r0, =letter_s
	mov r1, r6
	bl morse

	// and pause
	ldr r0, =1000000
	bl st_sleep

	b loop$



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
		add r1, r5, r5			// r1 = 2*counter
		lsr r0, r1				// shift pattern to the right so important pair is at right
		and r0, r6				// clear the rest of the bits
		// r0 now contains the 'character' code
		cmp r0, #0				// return if code is 00
		b morse_end$

		//mul r1, r7, r0			// blink duration is code*base duration
		mov r1, r7
		mov r0, #LED_ACT
		bl gpio_blink

		//loop end stuff
		add r5, #1				// increment counter
		add r0, r7, r7, lsl #1	// r0 = 3*duration
		bl st_sleep

		b morseloop$

	morse_end$:
		add r0, r7, r7, lsl #1
		bl st_sleep

		pop {r7}
		pop {r6}
		pop {r5}
		pop {r4}
		pop {pc}



.section .data

.align 2
letters:
letter_a:	.int 0b00000000000000000000000000001101
letter_b:	.int 0b00000000000000000000000001010111
letter_c:	.int 0b00000000000000000000000001110111
letter_d:	.int 0b00000000000000000000000000010111
letter_e:	.int 0b00000000000000000000000000000001
letter_f:	.int 0b00000000000000000000000001110101
letter_g:	.int 0b00000000000000000000000000011111
letter_h:	.int 0b00000000000000000000000001010101
letter_i:	.int 0b00000000000000000000000000000101
letter_j:	.int 0b00000000000000000000000011111101
letter_k:	.int 0b00000000000000000000000000110111
letter_l:	.int 0b00000000000000000000000001011101
letter_m:	.int 0b00000000000000000000000000001111
letter_n:	.int 0b00000000000000000000000000000111
letter_o:	.int 0b00000000000000000000000000111111
letter_p:	.int 0b00000000000000000000000001111101
letter_q:	.int 0b00000000000000000000000011011111
letter_r:	.int 0b00000000000000000000000000011101
letter_s:	.int 0b00000000000000000000000000010101
letter_t:	.int 0b00000000000000000000000000000011
letter_u:	.int 0b00000000000000000000000000110101
letter_v:	.int 0b00000000000000000000000011010101
letter_w:	.int 0b00000000000000000000000000111101
letter_x:	.int 0b00000000000000000000000011010111
letter_y:	.int 0b00000000000000000000000011110111
letter_z:	.int 0b00000000000000000000000001011111
