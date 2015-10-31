.set GPIO_BASE, 0x20200000		// start of the GPIO registers
.set GPIO_MAX_PIN, 53
.set GPSET0, 0x2020001c			// first pin setting word
.set GPCLR0, 0x20200028			// first pin clearing word

.set GPIO_HIGH, 0
.set GPIO_LOW, 1
.set GPIO_IN, 0
.set GPIO_OUT, 1


.set LED_ACT, LED_OK
.set LED_OK, 16
.set LED_PWR, 54				// invalid pin: PWR isn't controllable

.set ST_BASE, 0x20003000		// base address for the system timer
.set ST_CS, ST_BASE				// system timer control/status
.set ST_CL, 0x20003004			// counter
.set ST_CL0, ST_CL				// counter lower 32 bits
.set ST_CL1, 0x20003008			// counter higher 32 bits
.set ST_C0, 0x2000300c			// 0th comparison register
.set ST_C1, 0x20003010
.set ST_C2, 0x20003014
.set ST_C3, 0x20003018
