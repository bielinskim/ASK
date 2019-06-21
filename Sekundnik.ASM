JMP Start

DB FA
DB A
DB B6
DB 9E
DB 4E
DB DC
DB FF

Start: 
MOV AL, FB
OUT 02
MOV BL, 02
JMP left

right:
MOV AL,FB
OUT 02 
MOV AL,B
OUT 02
MOV AL,9F
OUT 02
MOV AL,4F
OUT 02
MOV AL,DD
OUT 02
MOV AL,FD
OUT 02
MOV AL,8B
OUT 02
MOV AL,FF
OUT 02
MOV AL,DF
OUT 02

MOV DL, [BL]
CMP DL, FF
JNZ left
JZ Start

left:
MOV AL, [BL]
OUT 02
INC BL

JMP right

end_label:
END




; abcdegf
; -0 - FB
; -1 - B
; -2 - B7
; -3 - 9F
; -4 - 4F
; -5 - DD
; -6 - FD
; -7 - 8B
; -8 - FF
; -9 - DF

; 0- - FA
; 1- - A
; 2- - B6
; 3- -9E
; 4- - 4E
; 5- - DC
;FC 8A FG DG
