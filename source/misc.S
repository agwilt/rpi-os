#include "constants.h"

.globl misc_morse_pattern
misc_morse_pattern:
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

	morse_loop$:
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

		b morse_loop$

	morse_end$:
	add r0, r7, r7, lsl #1	// sleep for 3*base between charaters
	bl st_sleep

	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {pc}
