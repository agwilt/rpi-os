.include "constants.s"

// Miscellaneous functions
.globl sleep
sleep:

	// r0: time
	sleep_wait$:
		sub r0, #1
		cmp r0, #0
		bne sleep_wait$

	mov pc, lr
