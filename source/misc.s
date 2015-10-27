.include "constants.s"

// Miscellaneous functions
.globl sleep
sleep:

	// r0: time
	sleep_wait$:
		sub r2, #1
		cmp r2, #0
		bne sleep_wait$

	mov pc, lr
