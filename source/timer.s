.include "constants.s"

.globl sleep
sleep:
	// r0: number of μSeconds to sleep

	ldr r2, =ST_CL
	ldr r2, [r2]				// timestamp at start
	sleep_loop$:
		ldr r1, =ST_CL
		ldr r1, [r1]			// current timestamp
		sub r1, r1, r2			// r1 = current - start = time elapsed
		cmp r1, r0
		bls sleep_loop$			// if current is lower than end, loop

	mov pc, lr


.globl st_get_timestamp
st_get_timestamp:
	// put the timestamp in r0 and r1
	ldr r0, =ST_CL
	ldrd r0, r1, [r0]
	mov pc, lr
