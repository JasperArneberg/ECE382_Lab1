;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file

;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section
            .retainrefs                     ; Additionally retain any sections
                                            ; that have references to current
                                            ; section
program:	.byte		0x18,0x33,0x12
ADD_OP:   	.equ    	0x11
SUB_OP: 	.equ		0x22
MUL_OP: 	.equ		0x33
CLR_OP:		.equ		0x44
END_OP:		.equ		0x55
max_val:	.equ		255
zero:		.equ		0

			.data
results:	.space		40					;40 bytes fo memory in RAM
			.text							;back to ROM

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer
;-------------------------------------------------------------------------------
                                            ; Main loop here
;-------------------------------------------------------------------------------

initialize:
	mov		#program,	R8					;R8 is ROM pointer
	mov		#results,	R9					;R9 is RAM pointer
	mov.b	@R8+,		R6					;store first operand and increase ROM pointer
	mov.b	#zero,		R11

read2:
	mov.b	@R8+,		R5					;R5 holds op code
	mov.b	@R8+,		R7					;R7 holds second operand

testOp:
	cmp.b	#ADD_OP,	R5
	jz 		addOp
	cmp.b	#SUB_OP,	R5
	jz 		subOp
	cmp.b	#MUL_OP,	R5
	jz 		mulOp
	cmp.b	#CLR_OP,	R5
	jz 		clrOp
	jmp 	end								;equal to END_OP or there is an error

addOp:
	add.b	R7,			R6
	jnc		write2RAM

	mov.b	#max_val,	R6					;carry flag, set R6 to max value of 255
	jmp 	write2RAM

subOp:
	sub		R7,			R6
	jge 	write2RAM

	mov.b	#zero,		R6					;negative answers not allowed, store 0 instead
	jmp 	write2RAM

mulOp:
	cmp		#zero,		R7
	jz		exit_mul_loop					;jump once R7 counts down to 0
	dec		R7
	add.b	R6,			R11					;store result in R11 temporarily
	jnc		mulOp

	mov.b	#max_val,	R11					;value now exceeds limit, store 255

exit_mul_loop:
	mov.b	R11,		R6
	jnc		write2RAM						;somehow test to see if overflow error
	jmp		write2RAM

clrOp:
	mov.b	R7,			R6					;first operand is now the second operand
	mov.b	#zero,		0(R9)				;store 0 to next RAM location
	inc		R9
	jmp 	read2

write2RAM:
	mov.b	R6,			0(R9)
	inc		R9
	jmp 	read2

end:
	jmp		end								;infinite loop

;-------------------------------------------------------------------------------
;           Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect 	.stack

;-------------------------------------------------------------------------------
;           Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
