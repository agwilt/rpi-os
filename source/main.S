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

// switch off act pin
mov r0, #LED_ACT
mov r1, #GPIO_LOW
bl gpio_output


// now for the morse stuff
ldr r6, =200000				// base duration

loop$:
	// s
	ldr r2, =letter_s
	ldr r0, [r2]
	mov r1, r6
	bl morse

	// o
	ldr r2, =letter_o
	ldr r0, [r2]
	mov r1, r6
	bl morse

	// s
	ldr r2, =letter_s
	ldr r0, [r2]
	mov r1, r6
	bl morse

	// and pause
	add r0, r6, r6, lsl #1
	lsl r0, #1				// r0 is 6*base_duration
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
		mov r1, #0
		add r1, r5, r5			// r1 = 2*counter
		lsr r0, r1				// shift pattern to the right so important pair is at right
		ands r0, r6				// clear the rest of the bits
		// r0 now contains the 'character' code

		beq morse_end$

		mul r1, r7, r0			// blink duration is code*base duration
		mov r0, #LED_ACT
		bl gpio_blink

		//loop end stuff
		add r5, #1				// increment counter
		mov r0, r7				// sleep for base_duration
		bl st_sleep

		b morseloop$

	morse_end$:
	add r0, r7, r7, lsl #1	// sleep for 3*base between charaters
	bl st_sleep

	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {pc}



.section .data

.align 2
letters:
letter_a:	.word 0b00000000000000000000000000001101
letter_b:	.word 0b00000000000000000000000001010111
letter_c:	.word 0b00000000000000000000000001110111
letter_d:	.word 0b00000000000000000000000000010111
letter_e:	.word 0b00000000000000000000000000000001
letter_f:	.word 0b00000000000000000000000001110101
letter_g:	.word 0b00000000000000000000000000011111
letter_h:	.word 0b00000000000000000000000001010101
letter_i:	.word 0b00000000000000000000000000000101
letter_j:	.word 0b00000000000000000000000011111101
letter_k:	.word 0b00000000000000000000000000110111
letter_l:	.word 0b00000000000000000000000001011101
letter_m:	.word 0b00000000000000000000000000001111
letter_n:	.word 0b00000000000000000000000000000111
letter_o:	.word 0b00000000000000000000000000111111
letter_p:	.word 0b00000000000000000000000001111101
letter_q:	.word 0b00000000000000000000000011011111
letter_r:	.word 0b00000000000000000000000000011101
letter_s:	.word 0b00000000000000000000000000010101
letter_t:	.word 0b00000000000000000000000000000011
letter_u:	.word 0b00000000000000000000000000110101
letter_v:	.word 0b00000000000000000000000011010101
letter_w:	.word 0b00000000000000000000000000111101
letter_x:	.word 0b00000000000000000000000011010111
letter_y:	.word 0b00000000000000000000000011110111
letter_z:	.word 0b00000000000000000000000001011111
