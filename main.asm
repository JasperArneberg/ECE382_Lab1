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
program:	.byte		0x14,	0x11,	0x12,	0x22,	0x20,	0x55
ADD_OP:   	.equ    	0x11
SUB_OP: 	.equ		0x22
MUL_OP: 	.equ		0x33
CLR_OP:		.equ		0x44
END_OP:		.equ		0x55
results:	.equ		0x0200					;location of RAM

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
	jmp 	write2RAM

subOp:
	sub		R7,			R6
	jmp 	write2RAM

mulOp:
	;mult R7 and R6
	;jmp write2RAM

clrOp:
	mov.b	0x00,		R6
	jmp 	write2RAM

write2RAM:
	mov.b	R6,			0(R9)
	inc		R9
	jmp 	read2

end:
	jmp		end		;infinite loop

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
