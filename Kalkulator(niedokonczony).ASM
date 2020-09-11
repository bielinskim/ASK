JMP start ; przeskocz na 'start:'
; Urzadzenia np. zegar, klawiatura, klawiatura numeryczna generuja tzw. przerwania gdy np. nacisniemy klawisz. 
; Przerwania maja swoj kod, np. przerwanie nacisniecia klawisza na klawiaturze ma kod 03
; To znaczy ze kod wskaze komorke pamieci 03, czyli w tym przypadku bedzie to 'db 20'(zgadza sie nie liczac komentarzy i pustych linii)
; 'db 20' z kolei wskazuje w ktorej komorce zaczyna sie obsluga przerwania, w tym przypadku bedzie to 20

db 10 ; adres obslugi przerwania zegara, nic z tym nie robimy, ale obsluzyc trzeba
db 00 ; adres obslugi przerwania klawiatury
db 20 ; adres obslugi przerwania klawiatury numerycznej

org 10  ; obsluga przerwania zegara
iret

org 20 ; obsluga przerwania klawiatury numerycznej
CLI ; czyszczenie flagi I - wylaczenie przerwan, zeby zapobiec wielobieznosci
; odkladamy rejestr al i flagi na stos, zeby ich przypadkiem nie zmodyfikowac wykonujac obsluge przerwania
push al
pushf

in 08 ; wczytanie znaku z klawiatury i zapisanie go do rejestru al
CMP AL, 08 ; sprawdzamy czy znak '+'
JZ add ; jesli tak to skok do 'add:'
CMP AL, 0D ; sprawdzamy czy znak '='
JZ equals ; jesli tak to skok do 'equals:'
; jezeli nic z powyzszych to kontynuujemy
MOV [BL], AL ; bl przechowuje adres kursora na ekranie, wiec wstawiamy do komorki o adresie bl wczytany znak
INC BL ; zwiekszamy adres bl - przestawiamy kursor na kolejne miejsce
; po skonczonej obsludze pobieramy flagi i rejestr al ze stosu
popf 
pop al
STI ; ponowne ustawienie flagi - wlaczenie przerwan
iret ; wracamy z procedury

start:
STI
MOV BL, C0 ; przekazanie adresu poczatku ekranu do wypisywania znakow
out 08 ; pokazanie klawiatury numerycznej

; program, gdy nie ma przerwan do obsluzenia - nic nie robi, czeka
idle:
nop
nop
nop
JMP idle

; obsluga dodawania
add:
MOV CL, 2B ; przenosimy wartosc heks. kodu ascii znaku + do komorki cl
MOV [BL], CL ; przeniesienie jej do komorki o adresie bl - czyli wypisanie na ekran
MOV CL, 00 ; czyscimy rejestr cl
INC BL ; zwiekszamy adres bl - przestawiamy kursor na kolejne miejsce
; wyjasnione wczesniej
popf
pop al
STI
iret

; to samo co w przypadku add tylko dla znaku =
equals:
MOV CL, 3D
MOV [BL], CL
MOV CL, 00
; wywolanie procedury obslugujacej dodawanie dwoch liczb
CALL 70
; wyjasnione wczesniej
INC BL
popf
pop al
STI
iret

; procedura obslugujaca dodawanie - nic tu prawie nie ma, na tym skonczylem
ORG 70
MOV DL, [C1]
CMP DL, 2B
JZ ; wstawic warunek dla liczby jednocyfrowej
SUB DL, 30
MOV CL

ret

end_label;
END
