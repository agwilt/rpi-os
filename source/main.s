.section .init
.globl _start
_start:

mov r0, #3

loop$:
	b loop$
