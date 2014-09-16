;-------------------------------------------------------------------------------
; Lab 1: Calculator
; C2C Jasper T. Arneberg
; T5 ECE 382
; Capt Trimble
;
; Documentation: None
;
; Description: This program is a calculator. It reads instructions from ROM and
; puts the results into RAM. TestOp makes the program counter jump to the appropriate
; location of the matching operation. The addition operation simply adds the two
; operands and jumps to write2RAM. The subtraction operation likewise calculates
; the difference of two operands. The clear instruction clears the first operand.
; Without the clear instruction, the program uses the result from the last operation
; as the first operand in the next one.

; Finally, the multiplication operation stores the product of the two operands. This is
; accomplished in an O(log n) fashion. To accomplish this, the operation makes use of
; the bitshift_loop, which effectively doubles the first operand a specified number of
; times and adds it to a intermediate result register. This register is then added to
; the cumulative result register after each bitshift_loop is exited.
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file

;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section
            .retainrefs                     ; Additionally retain any sections
                                            ; that have references to current
                                            ; section
program:	.byte		0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0xDD, 0x44, 0x08, 0x22, 0x09, 0x44, 0xFF, 0x22, 0xFD, 0x55
ADD_OP:   	.equ	   	0x11
SUB_OP: 	.equ		0x22
MUL_OP: 	.equ		0x33
CLR_OP:		.equ		0x44
END_OP:		.equ		0x55
max_val:	.equ		255
zero:		.equ		0

			.data
results:	.space		40					;40 bytes of memory in RAM
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

read2:
	mov.b	@R8+,		R5					;R5 holds op code
	mov.b	@R8+,		R7					;R7 holds second operand

testOp:										;match the op code
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
	jc		store_max						;maximum is reached
	jmp		write2RAM

subOp:
	sub		R7,			R6
	jn		store_min						;negative answers not allowed, store 0 instead
	jmp 	write2RAM

mulOp:										;O(log n)
	clr		R11								;placeholder register
	clr		R12								;intermediate result
	clr		R13								;cumulative result

mul_loop:									;4x5 = 4*2^0 + 4*2^2  ; 5 = 0101  ; second operand has 1 at placeholder 0 and 2
	add.b	R12,		R13					;add intermediate result from bitshift_loop to cumulative result
	jc		store_max
	clr		R12								;result from each iteration of mul_loop
	tst.b	R7
	jz		exit_mul_loop					;once second operand reaches 0, exit multiplication

	mov.b	R11,		R14					;copy of placeholder for use in bitshift_loop
	inc.b	R11								;increase for the next loop's place
	clrc
	rrc.b	R7								;cut second operand in half
	jnc		mul_loop

	add.b	R6,			R12					;first operand into temporary result register

bitshift_loop:								;double first operand the number of times equal to the placeholder value, store to R12
	tst		R14
	jz 		mul_loop
	clrc
	rlc.b	R12
	jc		store_max
	dec.b	R14
	jmp		bitshift_loop

exit_mul_loop:
	mov.b	R13,		R6					;put final product into R6
	jmp		write2RAM

clrOp:
	mov.b	R7,			R6					;first operand is now the second operand
	mov.b	#zero,		0(R9)				;store 0 to next RAM location
	inc		R9
	jmp 	read2

store_min:
	clr		R6
	jmp		write2RAM

store_max:
	mov.b	#max_val,	R6					;carry flag, set R6 to max value of 255

write2RAM:
	mov.b	R6,			0(R9)
	inc		R9
	jmp 	read2							;back to the top

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
