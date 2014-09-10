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

##Debugging
Several errors were encountered during the debugging process. One of the trickiest ones to solve was that the program and constants were originally stored after the watchdog timer was reset. This led to errors, but not every time, so it was very difficult to figure out what the problem was. Eventually, the problem was fixed after inspecting examples of code in class.

##Testing
The code was tested with a variety of commands gradually increasing in complexity. At first simple commands were executed to test the idnividual aspects of the code. For example:

```
Program: 0x12, 0x11, 0x14
Result: 0x26
```

The code available on the website was tested as well, and it was verified to be correct:

Basic Functionality:
```
Program: 0x11, 0x11, 0x11, 0x11, 0x11, 0x44, 0x22, 0x22, 0x22, 0x11, 0xCC, 0x55
Result: 0x22, 0x33, 0x00, 0x00
```

B Functionality:
```
Program: 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0xDD, 0x44, 0x08, 0x22, 0x09, 0x44, 0xFF, 0x22, 0xFD, 0x55
Result: 0x22, 0x33, 0x44, 0xFF, 0x00, 0x00, 0x00, 0x02
```

A Functionality:
```
Program: 0x22, 0x11, 0x22, 0x22, 0x33, 0x33, 0x08, 0x44, 0x08, 0x22, 0x09, 0x44, 0xff, 0x11, 0xff, 0x44, 0xcc, 0x33, 0x02, 0x33, 0x00, 0x44, 0x33, 0x33, 0x08, 0x55
Result: 0x44, 0x11, 0x88, 0x00, 0x00, 0x00, 0xff, 0x00, 0xff, 0x00, 0x00, 0xff
```


#Demonstrations
| Functionality | Witness | Date | Time |
| :--: | :--: | :--: | :----: |
| Basic | ______ | date | time |
| B Functionality | ______ | date | time |
| A Functionality | ______ | date | time ||

#Documentation
None.
