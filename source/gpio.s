.include "constants.s"

// set mode for a GPIO pin. takes pin number (e.g. 47), mode (GPIO_IN/OUT)
.globl gpio_set_function
gpio_set_function:

	// r0: pin number
	// r1: mode

	// check inputs, exit if any are too high
	cmp r0, #GPIO_MAX_PIN
	cmpls r1, #7
	movhi pc, lr

	// store the GPIO base address in r2
	ldr r2, =GPIO_BASE

	// next, separate pin number to 1's and 10's place
	function_loop$:
		cmp r0, #9
		subhi r0, #10
		addhi r2, #4
		bhi function_loop$

	// r0: pin number in word (0..9)
	// r2: address of relevant word (0..5)
	// r1: function number

	add r0, r0, lsl #1		// multiply r0 by 3 to get offset
	mov r3, #0b111			// mask to bic word

	// shift mask (r3) and function (r1) by offset (r0)
	lsl r3, r0
	lsl r1, r0

	// change word
	ldr r0, [r2]			// load relevant word into r0
	bic r0, r3				// clear relevant 3 bits of word
	add r0, r1				// and add the offset function
	// now write the edited word back to the address
	str r0, [r2]

	//return
	mov pc, lr
