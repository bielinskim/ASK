JMP start  ; przeskocz na 'start:'
; Urzadzenia np. zegar, klawiatura, klawiatura numeryczna generuja tzw. przerwania gdy np. nacisniemy klawisz. 
; Przerwania maja swoj kod, np. przerwanie nacisniecia klawisza na klawiaturze ma kod 03
; To znaczy ze kod wskaze komorke pamieci 03, czyli w tym przypadku bedzie to 'db 20'(zgadza sie nie liczac komentarzy i pustych linii)
; 'db 20' z kolei wskazuje w ktorej komorce zaczyna sie obsluga przerwania, w tym przypadku bedzie to 20


db 10 ; adres obslugi przerwania zegara, nic z tym nie robimy, ale obsluzyc trzeba
db 20 ; adres obslugi przerwania klawiatury
db 00 ; nwm

; obsluga przerwania zegara
org 10  
iret

; obsluga przerwania klawiatury
org 20
CLI ; czyszczenie flagi I - wylaczenie przerwan, zeby zapobiec wielobieznosci
; odkladamy rejestr al i flagi na stos, zeby ich przypadkiem nie zmodyfikowac wykonujac obsluge przerwania
push al 
pushf

in 07 ; wczytanie znaku z klawiatury i zapisanie go do rejestru al
CMP AL, 08 ; sprawdzamy czy znak nie jest backspace
JZ backspace ; jesli tak to skocz do obslugi backspace
CMP AL, D ; sprawdzamy czy znak nie jest eneterem
JZ enter ; jesli tak to skocz do obslugi entera
JMP chars ; w innym przypadku skocz do obslugi zwyklego znaku
back: ; odnosnik zeby mozna bylo tu skoczyc
; po skonczonej obsludze pobieramy flagi i rejestr al ze stosu
popf 
pop al
STI ; ponowne ustawienie flagi - wlaczenie przerwan
iret ; wracamy z procedury

start:
STI ; wlaczenie przerwan - ustawienie flagi I
MOV BL, C0 ; chyba przekazanie adresu poczatku ekranu do wypisania znakow
out 07 ; pokazanie klawiatury

; program, gdy nie ma przerwan do obsluzenia - nic nie robi, czeka
idle:
nop 
nop
nop
JMP idle

; obsluga znaku
chars: 
MOV [BL], AL ; przenosimy znak do komorki pod adresem BL(aktualna pozycja kursora na ekranie) 
INC BL ; zwiekszamy adres - przestawienie kursora na kolejna komorke
JMP back ; skok do back

; obsluga backspace
backspace:
CMP BL, C0 ; sprawdzamy czy kursor jest na poczatku ekranu
JZ back ; jesli tak to powrot - bo nie ma co do usuniecia
DEC BL ; w przeciwnym razie zmniejszamy adres kursora
MOV CL, 00 ; wkladamy 0 do rejestru CL
MOV [BL], CL ; i czyscimy komorke pod adresem bl
JMP back ; skok do back

enter: 
CMP BL, F0 ; sprawdzamy czy kursor nie jest na koncu ekranu
JNS back
; w przypadku kursor jest na poczatku kolejnych linii trzeba zastosowac inne rozwiazanie, sprawdzamy czy nowa linia, jesli tak to skok do newenter
CMP BL, C0 
JZ newenter
CMP BL, D0
JZ newenter  
CMP BL, E0
JZ newenter 

; ustawiamy adres kursora na nowej linii
DIV BL, 10 ; dzielimy adres przez 10
MUL BL, 10 ; potem mnozymy przez 10

JMP back ; powrot

; w przypadky gdy kursor jest na poczatku linii i nacisniemy enter
newenter:
ADD BL, 10 ; po prostu zwiekszamy adres kursora o 10 - czyli to bedzie kolejna linia
JMP back

end_label:
END
