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
;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


program:	.byte	0x14,	0x11,	0x12
ADD_OP:   	.equ    0x11
SUB_OP: 	.equ	0x22
MUL_OP: 	.equ	0x33
CLR_OP:		.equ	0x44
END_OP:		.equ	0x55
;-------------------------------------------------------------------------------
                                            ; Main loop here
;-------------------------------------------------------------------------------

	mov		#program,	R8
	mov.b	@R8+,	R6						;store first operand and increase ROM pointer

read2:
	mov.b	@R8+,	R5						;store op to R5, increase ROM pointer
	mov.b	@R8+,	R7						;store second operand

	mov.b 	#ADD_OP,	R10

testOp:
	cmp.b	#ADD_OP,	R5
	jz addOp
	cmp.b	#SUB_OP,	R5
	jz subOp
	cmp.b	#MUL_OP,	R5
	jz mulOp
	cmp.b	#CLR_OP,	R5
	jz clrOp
	jmp end									;equal to END_OP or there is an error

addOp:
	;add R7 to R6
	;jmp write2RAM

subOp:
	;sub R7 from R6
	;jmp write2RAM

mulOp:
	;mult R7 and R6
	;jmp write2RAM

clrOp:
	;mov 0 to R6
	;jmp write2RAM

write2RAM:
	;store R6 to RAM location
	;increase RAM pointer
	;jmp Read2

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
