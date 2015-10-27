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

.globl st_get_timestamp
st_get_timestamp:
	// put the timestamp in r0
	ldr r0, =ST_CL
	ldrd r0, r1, [r0]
	mov pc, lr
