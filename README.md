ECE382_Lab1
===========

Lab 1: Building a Calculator

C3C Jasper Arneberg  
M5 ECE 382
Capt Trimble  

#Prelab
A rough outline for the calculator was developed prior to writing any code. The flow chart below shows how the basic functionality is implemented.

![alt text](https://github.com/JasperArneberg/ECE382_Lab1/blob/master/prelab_flowchart.jpg?raw=true "Prelab Flowchart")

To start the process, pseudocode was developed to solve this problem:
```
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
```

#Lab


#Demonstrations
| Functionality | Witness | Date | Time |
| :--: | :--: | :--: | :----: |
| Basic | ______ | date | time |
| B Functionality | ______ | date | time |
| A Functionality | ______ | date | time ||

#Documentation
None.
