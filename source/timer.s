.include "constants.s"

.globl st_sleep
st_sleep:
	// r0: number of μSeconds to sleep

	ldr r1, =ST_CL
	ldr r1, [r1]				// timestamp at start
	add r0, r1					// timestamp at end
	sleep_loop$:
		ldr r1, =ST_CL
		ldr r1, [r1]			// current timestamp
		cmp r1, r0
		blo sleep_loop$			// if current is lower than end, loop

	mov pc, lr


.globl st_get_timestamp
st_get_timestamp:
	// put the timestamp in r0 and r1
	ldr r0, =ST_CL
	ldrd r0, r1, [r0]
	mov pc, lr
