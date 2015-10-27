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
	add r0, r0, lsl #1		// multiply r0 by 3 to get offset
	mov r3, #0b111			// create mask to bic word
	// shift mask and function
	lsl r3, r0
	lsl r1, r0

	ldr r0, [r2]			// load relevant word into r0
	bic r0, r0, r3			// clear relevant 3 bits of word
	// r0: BICed value of relevant word
	// r1: function number (000..111)
	// r2: address of relevant word
	// r3: mask
	add r0, r1
	// now write the edited word back
	str r0, [r2]


	//return
	mov pc, lr
