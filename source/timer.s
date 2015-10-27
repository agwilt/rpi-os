.include "constants.s"

.globl sleep
sleep:
	// r0: number of μSeconds to sleep

	// I'm making a quick "old" version just to have something here. The rest is for tomorrow.
	sleep_wait$:
		sub r0, #1
		cmp r0, #0
		bne sleep_wait$

	mov pc, lr
