JMP start
db 10
db 00
db 20

org 10  ; obsluga przerwania zegara
iret

org 20
CLI
push al
pushf

in 08
CMP AL, 08
JZ add
CMP AL, 0D
JZ equals
MOV [BL], AL
INC BL
popf
pop al
STI
iret

start:
STI
MOV BL, C0
out 08

idle:
nop
nop
nop
JMP idle

add:
MOV CL, 2B
MOV [BL], CL
MOV CL, 00
INC BL
popf
pop al
STI
iret

equals:
MOV CL, 3D
MOV [BL], CL
MOV CL, 00
CALL 70

INC BL
popf
pop al
STI
iret

ORG 70
MOV DL, [C1]
CMP DL, 2B
JZ ; wstawic warunek dla liczby jednocyfrowej
SUB DL, 30
MOV CL

ret

end_label;
END
