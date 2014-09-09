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


program:	.byte
;-------------------------------------------------------------------------------
                                            ; Main loop here
;-------------------------------------------------------------------------------

	;store first value to R6
	;increase ROM pointer

read2:
	;move op to R5
	;increase ROM pointer

	;mov second value to R7
	;increase ROM pointer

testOp:
	;test = END_OP
	;jz end
	;compare to ADD_OP
	;jz addOp
	;compare to SUB_OP
	;jz subOp
	;compare to CLR_OP
	;jz clearOp
	;jmp end				;error!

clearOp:
	;mov 0 to R6
	;jmp write2RAM

addOp:
	;add R7 to R6
	;jmp write2RAM

subOp:
	;sub R7 from R6

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
