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

	// r0: pin number
	// r1: function
	// r2: GPIO_BASE

	// next, separate pin number to 1's and 10's place
	function_loop$:
		cmp r0, #9
		subhi r0, #10
		addhi r2, #4
		bhi function_loop$

	// r0: pin number in word (0..9)
	// r2: address of relevant word (0..5)
	// r1: function number
	// now change the word
	add r0, r0, lsl #1		// multiply r0 by 3
	lsl r1, r0				// shift code left to correct position
	str r1, [r2]


	//return
	mov pc, lr
