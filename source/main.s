.section .init
.globl _start
_start:

// sore GPIO controller address in r0
ldr r0,=0x20200000
