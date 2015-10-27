.include "constants.s"

// set mode for a GPIO pin. takes pin number (e.g. 47), mode (GPIO_IN/OUT)
.globl gpio_setmode
gpio_setmode:
	// r0: pin number
	// r1: mode
	mov pc, lr
