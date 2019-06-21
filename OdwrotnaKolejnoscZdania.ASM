JMP start
db 10
db 20

org 10 ;obsluga przerwania zegara
iret

org 20
CLI
push al
pushf


in 07
CMP AL, D
JZ entr
JMP char
back:
popf
pop al
STI
iret

start:
STI
MOV BL, C0
MOV CL, D0
out 07

idle:
nop
nop
nop
JMP idle

char:
MOV [BL], AL
INC BL
JMP back

entr:
SUB BL, 1

enter:
MOV DL, [BL]
CMP DL, 5F
JZ wypisz
PUSH DL 
CMP BL, C0                     
JZ wypisz
DEC BL
JNZ enter


wypisz:
POP DL
CMP DL, 00
JZ wstaw_
MOV [CL], DL
INC CL
JNZ wypisz

wstaw_:
DEC BL
MOV AL, 5F
MOV [CL], AL
MOV AL, 00
INC CL
JMP enter

end_label:
END