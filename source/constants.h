#define RPIBPLUS



// GPIO stuff first

#define GPIO_MAX_PIN		53
// GPIO addresses
#ifdef RPI2
	#define GPIO_BASE		0x3F200000
	#define GPSET0			0x3F20001C
	#define GPCLR0			0x3F200028
#else
	#define GPIO_BASE		0x20200000
	#define GPSET0			0x2020001C
	#define GPCLR0			0x20200028
#endif

// Misc
#if defined( RPIBPLUS ) || defined( RPI2 )
	#define GPIO_HIGH		1
	#define GPIO_LOW		0
#else
	#define GPIO_HIGH		0
	#define GPIO_LOW		1
#endif

#define GPIO_IN				0
#define GPIO_OUT			1

// Pins
#if defined( RPIBPLUS ) || defined( RPI2 )
	#define LED_ACT			47
	#define LED_PWR			35
#else
	#define LED_ACT			16
	#define LED_PWR			54				// invalid pin, since PWD is hardwired
#endif

#define LED_OK			LED_ACT



//Timer
#ifdef RPI2
	#define ST_BASE			0x20003000		// base timer address
	#define ST_CL			0x20003004		// counter
	#define ST_CL1			0x20003008
	#define ST_C0			0x2000300c		// comparison registers
	#define ST_C1			0x20003010
	#define ST_C2			0x20003014
	#define ST_C3			0x20003018
// no idea
#else
	#define ST_BASE			0x20003000
	#define ST_CL			0x20003004
	#define ST_CL1			0x20003008
	#define ST_C0			0x2000300c
	#define ST_C1			0x20003010
	#define ST_C2			0x20003014
	#define ST_C3			0x20003018
#endif
#define ST_CS			ST_BASE     
#define ST_CL0			ST_CL      
