JMP Start
DB 01
DB 02
DB 03
DB 04
DB 05
DB FF

Start:
MOV DL, 02
CALL 15
next:
INC DL
CALL 15

ORG 15
MOV AL, [DL]
CMP DL, FF
ADD AL, 30
MOV [C0], AL

JNZ next
JZ end_label


end_label:
END