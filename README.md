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

##Objective
The objective of this lab was to develop a calculator in the assembly programming language. This involved implementing a variety of elements such as instruction sets, addressing modes, and status flags. Overall, it demonstrated how high-level programs could be developed in assembly.

##Debugging
Several errors were encountered during the debugging process. One of the trickiest ones to solve was that the program and constants were originally stored after the watchdog timer was reset. This led to errors, but not every time, so it was very difficult to figure out what the problem was. Eventually, the problem was fixed after inspecting examples of code in class.

While implementing multiplication functionality, another error was encountered. The carry bit was never cleared before performing a bit rotation instruction. This led to wildly inaccurate answers.

##Testing
The code was tested with a variety of instructions gradually increasing in complexity. At first simple commands were executed to test the individual aspects of the code. For example:

```
Program: 0x12, 0x11, 0x14
Result: 0x26
```

After sufficient testing of the individual aspects, the code on the website was tested as well. It was verified to be correct:

####Basic Functionality: Addition, subtraction, and clear
This functionality required getting values from ROM and then adding, subtracting, or clearing based off of the value of the op code.
```
Program: 0x11, 0x11, 0x11, 0x11, 0x11, 0x44, 0x22, 0x22, 0x22, 0x11, 0xCC, 0x55
Result: 0x22, 0x33, 0x00, 0x00
```

####B Functionality: Store minimum and maximum values 
This required recognizing situations when the minimum or maximum values could be exceeded. In these cases, a conditional jump to the store_max or store_min command was called.
```
Program: 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0xDD, 0x44, 0x08, 0x22, 0x09, 0x44, 0xFF, 0x22, 0xFD, 0x55
Result: 0x22, 0x33, 0x44, 0xFF, 0x00, 0x00, 0x00, 0x02
```

####A Functionality: Multiplication in O(log n)
At first, this functionality was accomplished in O(n), and the solution was simple. Accomplishing O(log n) was very difficult. Ultimately, bits were rotated in the operands and jumps were executed conditional on the c status flag.
```
Program: 0x22, 0x11, 0x22, 0x22, 0x33, 0x33, 0x08, 0x44, 0x08, 0x22, 0x09, 0x44, 0xff, 0x11, 0xff, 0x44, 0xcc, 0x33, 0x02, 0x33, 0x00, 0x44, 0x33, 0x33, 0x08, 0x55
Result: 0x44, 0x11, 0x88, 0x00, 0x00, 0x00, 0xff, 0x00, 0xff, 0x00, 0x00, 0xff
```

#Conclusion
This lab was a challenge to complete. It incorporated nearly all of the concepts covered so far in class and served as a good learning experience.

#Documentation
None.
