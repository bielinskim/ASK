JMP start
db 10
db 20
db 00

org 10  ; obsluga przerwania zegara
iret

org 20
CLI
push al
pushf

in 07
CMP AL, 08
JZ backspace
CMP AL, D
JZ enter
JMP chars
back:
popf
pop al
STI
iret

start:
STI
MOV BL, C0
out 07

idle:
nop
nop
nop
JMP idle

chars:
MOV [BL], AL
INC BL
JMP back

backspace:
CMP BL, C0
JZ back
DEC BL
MOV CL, 00
MOV [BL], CL
JMP back

enter: 
CMP BL, F0
JNS back
CMP BL, C0
JZ newenter
CMP BL, D0
JZ newenter  
CMP BL, E0
JZ newenter 

DIV BL, 10
MUL BL, 10

JMP back

newenter:
ADD BL, 10
JMP back

end_label:
END
