.include "constants.s"

.globl sleep
sleep:
	// r0: number of μSeconds to sleep

	/*
	// I'm making a quick "old" version just to have something here. The rest is for tomorrow.
	sleep_wait$:
		sub r0, #1
		cmp r0, #0
		bne sleep_wait$
	*/

	/*
	// It's now after tomorrow, but let's do this!
	ldr r1, =ST_CL0				// timestamp at start
	add r1, r0					// timestamp at end
	sleep_loop$:
		ldr r2, =ST_CL0			// current timestamp
		cmp r2, r1
		blt sleep_loop$			// if current is lower than end, loop
	*/

	push {lr}
	mov r2, r0					// delay
	bl st_get_timestamp
	mov r3, r0					// start timestamp

	sleep_loop$:
		bl st_get_timestamp		// current timestamp in r0+r1
		sub r1, r0, r3
		cmp r1, r2
		bls sleep_loop$

	pop {pc}


.globl st_get_timestamp
st_get_timestamp:
	// put the timestamp in r0 and r1
	ldr r0, =ST_CL
	ldrd r0, r1, [r0]
	mov pc, lr
