#include "constants.h"

.section .init
.globl _start
_start:
b main


.section .text
main:
mov sp, #0x8000

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
ldr r4, =150000				// base duration

loop$:
	// a
	mov r0, #65
	bl letter_to_pattern$
	mov r1, r4
	bl misc_morse_pattern

	// n
	mov r0, #78
	bl letter_to_pattern$
	mov r1, r4
	bl misc_morse_pattern

	// d
	mov r0, #68
	bl letter_to_pattern$
	mov r1, r4
	bl misc_morse_pattern

	// r
	mov r0, #82
	bl letter_to_pattern$
	mov r1, r4
	bl misc_morse_pattern

	// e
	mov r0, #69
	bl letter_to_pattern$
	mov r1, r4
	bl misc_morse_pattern

	// a
	mov r0, #65
	bl letter_to_pattern$
	mov r1, r4
	bl misc_morse_pattern

	// s
	mov r0, #83
	bl letter_to_pattern$
	mov r1, r4
	bl misc_morse_pattern

	// and pause
	add r0, r4, r4, lsl #1
	lsl r0, #1				// r0 is 6*base_duration
	bl st_sleep

	b loop$

letter_to_pattern$:
	// r0: ascii code for letter
	// This function takes a letter and translates it to an pattern for misc_morse_pattern

	// first check value a bit
	cmp r0, #97
	subge r0, #32			// convert to lower case if >= 'a'
	cmp r0, #90
	movgt pc, lr			// return if greater than 'Z'
	subs r0, #65
	movmi pc, lr			// return if < 'A'

	sub r0, #65
	lsl r0, #2				// multiply offset by 4 (bytes)
	// r0 now contains the offset of the (upper case) letter from 'A'
	ldr r1, =letters		// address of letters in r1
	add r1, r0				// move forward by offset r0
	ldr r0, [r1]			// and return value

	// return
	mov pc, lr

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
