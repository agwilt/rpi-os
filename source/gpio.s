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
	gpio_set_function_loop$:
		cmp r0, #9
		subhi r0, #10
		addhi r2, #4
		bhi gpio_set_function_loop$

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

.globl gpio_output
gpio_output:

	// r0: pin number
	// r1: state (1 set, 0 clear)

	//exit if number or state are invalid
	cmp r0, #GPIO_MAX_PIN
	cmpls r1, #1
	movhi pc, lr

	// store set/clr base address in r2
	cmp r1, #1
	ldrne r2, =GPCLR0		// state is 0, so clear pin
	ldreq r2, =GPSET0		// state is 1, so set pin

	gpio_output_loop$:
		cmp r0, #31
		subhi r0, #32
		addhi r2, #4
		bhi gpio_output_loop$

	// write (1 << pin) to the address
	mov r1, #1
	lsl r1, r0
	str r1, [r2]

	// return
	mov pc, lr

.globl gpio_blink
gpio_blink:

	// r0: pin number
	// r1: duration

	push {lr}

	// turn on pin
	mov r3, r0				// pin number
	push {r1}				// duration
	mov r1, #GPIO_HIGH
	bl gpio_output

	// wait
	pop {r0}				// duration
	bl sleep

	// turn off pin
	mov r0, r3				// pin number
	mov r1, #GPIO_LOW
	bl gpio_output

	//return
	pop {pc}
