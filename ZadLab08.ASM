JMP Start
DB "chce_"
DB "zaliczyc_"
DB "ask_"
DB "na5_"

Start:
MOV DL, 02
MOV BL, C0
CALL 25


ORG 25
next:
MOV AL, [DL]
INC DL
CMP AL, 35
JNZ next
MOV CL, FF
PUSH CL
JZ stos

stos:

DEC DL
MOV AL, [DL]
PUSH AL
CMP AL, 5F
JZ sprawdz
JNZ stos

sprawdz:
CMP CL, FF
JNZ wypisz
JZ stos

wypisz:
POP CL
MOV [BL], CL
INC BL
JMP sprawdz





end_label:
END