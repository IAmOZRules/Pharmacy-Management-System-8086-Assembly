.model small
.stack 100h             ; will reserve a memory block of 100h for stack
.data                                                       

banner1 db  ' ____  __ __  ____ ____  ___ ___  ____ $'
banner2 db  '|    \|  |  |/    |    \|   |   |/    |$'
banner3 db  '|  o  )  |  |  o  |  D  ) _   _ |  o  |$'
banner4 db  '|   _/|  _  |     |    /|  \_/  |     |$'
banner5 db  '|  |  |  |  |  _  |    \|   |   |  _  |$'
banner6 db  '|  |  |  |  |  |  |  .  \   |   |  |  |$'
banner7 db  '|__|  |__|__|__|__|__|\_|___|___|__|__|$'

greetS          db ' Welcome to the Pharma - A Pharmacy Management System !$'
nlineCurV       db 13, 10, "$"
crudProgS       db ' A Massive Waste of Time$'
creditsProgS    db ' By IAmOZRules$'
nameArr         db 20 dup('$') 
str1            db ' Please enter your name: $' 
str2            db 13,10,'string op is:$'
thanku          db 13,10,' Thank you for coming $',
itemS           db ' ---------------- Drug List ----------------- $' 
simpleLinDw     db ' -------------------------------------------- $'
ordRace         db '| Enter 1 to order a Racetal       - 150 rs  |$'
ordNapro        db '| Enter 2 to order a Naproxen      - 250 rs  |$'
ordAmit         db '| Enter 3 to order a Amitriptyline - 350 rs  |$'
ordVove         db '| Enter 4 to order a Voveran       - 100 rs  |$'
printRec        db '| Enter 5 to print the receipt               |$'
delOrd          db '| Enter 6 to delete the order                |$'
saveFile        db '| Enter 7 to save your order to a file       |$'
noMore          db '| Enter 8 to exit this application           |$'
ordFullS        db ' ------- Sorry you cannot order more! ------- $'
wrgOpS          db ' --------- Incorrect option selected -------- $'
ordSumS         db ' -------------- ORDER RECEIPT --------------- $'   
totAmS          db ' Your total bill is = Rs.$'
saveMsg         db ' Your bill has been saved to ORDER.TXT$'
inputPrompt     db ' Please enter your choice: $' 
added           db ' Added to bill: Rs. $'

totNoS          db ' Total Items x $'
race            db ' Racetal x $'
napro           db ' Naproxen  x $'
Amit            db ' Amitriptyline x $'  
vove            db ' Voveran x $' 
ordDelS         db 'Your order has been deleted. What would you like to have this time?$'
totPriceV       dw 0      ;var for total price of all ordered items
totItemsV       dw '0'    ;no of total items  

qOfRace         dw '0'    ;Quantity of Racetal ordered
qOfNapro        db '0'    ;Quantity of Naproxen ordered
qOfAmit         db '0'    ;Quantity of Amitriptyline ordered
qOfVove         db '0'    ;Quantity of Voveran  ordered

endl            db ' |$'
filename        db "order.txt", 0
handler         dw ?
name db         'Name: $'

;code starts here!!
.code

main proc           ;main function
mov ax,@data       
mov ds,ax
     
mov ah,2 
mov dl, 07    
int 21h
int 21h
int 21h

lea dx, banner1
call print
lea dx, nlineCurV
call print

lea dx, banner2
call print
lea dx, nlineCurV
call print

lea dx, banner3
call print
lea dx, nlineCurV
call print

lea dx, banner4
call print
lea dx, nlineCurV
call print

lea dx, banner5
call print
lea dx, nlineCurV
call print

lea dx, banner6
call print
lea dx, nlineCurV
call print

lea dx, banner7
call print
lea dx, nlineCurV
call print
lea dx, nlineCurV
call print


lea dx, crudProgS
call print

lea dx, nlineCurV
call print

lea dx, creditsProgS
call print

lea dx, nlineCurV
call print
call print

lea dx, greetS    
call print

lea dx, nlineCurV
call print
call print

lea dx, str1
call print 

mov ah, 10         ;string input sub routine defined
lea dx, nameArr        ;getting offset address of array
mov nameArr, 20         ;set array size 
int 21h

;-------------------------------------------------------------

mainmen:   
           
mov ah,2 
mov dl, 07     ;beep sound
int 21h

lea dx, nlineCurV
call print

call print     
lea dx, itemS   
call print               
lea dx, nlineCurV
call print

lea dx, ordRace   
call print       
lea dx, nlineCurV
call print

lea dx, ordNapro    
call print          
lea dx, nlineCurV
call print

lea dx, ordAmit    
call print          
lea dx, nlineCurV
call print

lea dx, ordVove
call print
lea dx, nlineCurV
call print

lea dx, printRec     
call print
lea dx, nlineCurV
call print

lea dx, delOrd    
call print
lea dx, nlineCurV
call print

lea dx, saveFile    
call print
lea dx, nlineCurV
call print

lea dx, noMore 
call print
lea dx, nlineCurV
call print

lea dx, simpleLinDw
call print 
lea dx, nlineCurV
call print

lea dx, nlineCurV
call print
lea dx, inputPrompt
call print

mov ah,1                 ;user input required
int 21h                 
mov bl,al               

lea dx, nlineCurV
call print

lea dx, nlineCurV
call print

  ;now compare
mov al,bl               
cmp al,'1'              ;for racetal label
je racetalfun               
cmp al,'2'              ;for Naproxen label
je naprofun                
cmp al,'3'              ;for Amitriptyline label
je amitfun
cmp al, '4'             ;for voveran label
je vovefun               
cmp al,'5'              ;for display label
je displayord                 
cmp al,'6'              ;for delete order label
je delt
cmp al,'7'
je write
cmp al,'8'
je leaveMe                                  

lea dx, wrgOpS          ;when none of the above options selected, it means
                        ;user entered value other than first 6 so we handle
                        ;the error by prompting wrong order msg
call print

lea dx, nlineCurV
call print
 

jmp mainmen             

;-------------------------------------------------------------
print:                  ;label to print dx content  
    mov     ah, 9                               
    int     21h        
    ret
    ;main proc ends
main endp

;-------------------------------------------------------------

racetalfun proc            ; racetalfun func
lea dx, added
call print
cmp totItemsV,'4'         
jle race1             
lea dx, ordFullS
call print                 
jmp mainmen

ret
racetalfun endp

race1:                ;label to display price of one racetalfun
mov ax,150              
add totPriceV, ax         

        mov dx, 1         
        add dx,48       
        mov ah,2        
        int 21h
        mov dx, 0d
        int 21h
        mov dx, 5
        add dx, 48
        mov ah, 2
        int 21h
        mov dx, 0d
        int 21h
        mov dx, 0
        add dx, 48
        mov ah, 2
        int 21h
        lea dx, nlineCurV        
                

inc totItemsV              

inc qOfRace                 

jmp mainmen 

;-------------------------------------------------------------

naprofun proc               ;Naproxen function
lea dx, added
call print
cmp totItemsV,'4'
jle napro1
lea dx, ordFullS
call print
jmp mainmen

ret 

naprofun endp
    
napro1:               ;label to dsiplay price of one Naproxen
mov ax,250              
add totPriceV, ax         

    mov dx, 2         
    add dx,48       
    mov ah,2        
    int 21h
    mov dx, 0d
    int 21h
    mov dx, 5
    add dx, 48
    mov ah, 2
    int 21h
    mov dx, 0d
    int 21h
    mov dx, 0
    add dx, 48
    mov ah, 2
    int 21h
    lea dx, nlineCurV



inc totItemsV
inc qOfNapro
jmp mainmen

;-------------------------------------------------------------

amitfun proc             ;Amitriptyline function
lea dx, added
call print

cmp totItemsV,'4'
jle amit1 

lea dx, ordFullS
call print

jmp mainmen

ret

amitfun endp

amit1:              ;label to display price of 1 Amitriptyline
mov ax,350              
add totPriceV, ax         

mov dx, 3         
add dx,48       
mov ah,2        
int 21h
mov dx, 0d
int 21h
mov dx, 5
add dx, 48
mov ah, 2
int 21h
mov dx, 0d
int 21h
mov dx, 0
add dx, 48
mov ah, 2
int 21h
lea dx, nlineCurV

inc totItemsV
inc qOfAmit
jmp mainmen

;-------------------------------------------------------------

vovefun proc               ;voveran function
lea dx, added
call print
cmp totItemsV,'4'
jle vove1
lea dx, ordFullS
call print
jmp mainmen

ret 

vovefun endp
    
vove1:               ;label to dsiplay price of one voveran
mov ax,100              
add totPriceV, ax         

mov dx, 1         
add dx,48       
mov ah,2        
int 21h
mov dx, 0d
int 21h
mov dx, 0
add dx, 48
mov ah, 2
int 21h
mov dx, 0d
int 21h
mov dx, 0
add dx, 48
mov ah, 2
int 21h
lea dx, nlineCurV



inc totItemsV
inc qOfVove
jmp mainmen
;-------------------------------------------------------------

displayord proc               ;function to display the order

lea dx, nlineCurV
call print 

lea dx, ordSumS
call print
lea dx, nlineCurV
call print 

lea dx, race
call print

mov dx,qOfRace
mov ah,2
int 21h

lea dx, nlineCurV
call print

lea dx, napro
call print


mov dl,qOfNapro
mov ah,2
int 21h

lea dx, nlineCurV
call print


lea dx, Amit
call print

mov dl,qOfAmit
mov ah,2
int 21h

lea dx, nlineCurV
call print

lea dx, vove
call print

mov dl,qOfVove
mov ah,2
int 21h

lea dx, nlineCurV
call print

lea dx, totNoS
call print

mov dx,totItemsV
mov ah,2
int 21h

lea dx, nlineCurV
call print


lea dx, simpleLinDw
call print 

lea dx, nlineCurV
call print

lea dx, totAmS                    
call print

mov ax, totPriceV

mov dx,0
mov bx,10
mov cx,0
totalpush:
        div bx
        push dx
        mov dx,0
    
        inc cx
        cmp ax,0
       jne totalpush
   
totalprint:
        pop dx
        add dx,48
        mov ah,2
        int 21h
loop totalprint 



lea dx, nlineCurV
call print
lea dx, simpleLinDw
call print 
 
lea dx, nlineCurV
call print 

jmp mainmen

ret

displayord endp

;-------------------------------------------------------------

delt proc          ;proc for deleting the order
mov qOfRace,'0'
mov qOfNapro,'0'
mov qOfAmit,'0'
mov qOfVove, '0'
mov totPriceV,0

mov totItemsV,'0'

lea dx, ordDelS
call print

lea dx, nlineCurV
call print

jmp mainmen
 
ret

delt endp

;-------------------------------------------------------------

write proc              ; proc to write output to file

; create file
mov ah, 3ch
mov cx, 0
mov dx, offset filename
int 21h

; preserve file handler returned
mov handler, ax

; write to file

lea dx, race            ; ds:dx -> data to write
mov bx, handler         ; file handle
mov cx, 11              ; number of bytes to write
mov ah, 40h             ; WRITE TO FILE OR DEVICE
int 21h    

mov ah, 40h
mov bx, handler
mov cx, 1
mov dx, offset qOfRace
int 21h

lea dx, endl
mov bx, handler
mov cx, 2
mov ah, 40h
int 21h

mov ah, 40h
mov bx, handler
mov cx, 12
mov dx, offset napro
int 21h

mov ah, 40h
mov bx, handler
mov cx, 1
mov dx, offset qOfNapro
int 21h

lea dx, endl
mov bx, handler
mov cx, 2
mov ah, 40h
int 21h

mov ah, 40h
mov bx, handler
mov cx, 17
mov dx, offset Amit
int 21h

mov ah, 40h
mov bx, handler
mov cx, 1
mov dx, offset qOfAmit
int 21h

lea dx, endl
mov bx, handler
mov cx, 2
mov ah, 40h
int 21h

mov ah, 40h
mov bx, handler
mov cx, 11
mov dx, offset vove
int 21h

mov ah, 40h
mov bx, handler
mov cx, 1
mov dx, offset qOfVove
int 21h

lea dx, endl
mov bx, handler
mov cx, 2
mov ah, 40h
int 21h

lea dx, totNoS
mov bx, handler
mov cx, 15
mov ah, 40h
int 21h

lea dx, totItemsV
mov bx, handler
mov cx, 1
mov ah, 40h
int 21h

lea dx, endl
mov bx, handler
mov cx, 2
mov ah, 40h
int 21h

lea dx, totAmS
mov bx, handler
mov cx, 30
mov ah, 40h
int 21h

lea dx, totPriceV
mov bx, handler
mov cx, 4
mov ah, 40h
int 21h

; close file
mov ah, 3eh
mov bx, handler
int 21h

lea dx, nlineCurV
call print

lea dx, saveMsg
call print

lea dx, nlineCurV
call print

lea dx, nlineCurV
call print

lea dx, simpleLinDw
call print

call leaveMe
    
ret          
write endp

leaveMe proc

lea dx, thanku
call print

lea dx, nameArr+2
call print

mov ah,2 
mov dl, 07              ;3 beep sounds to end the program
int 21h
int 21h 
int 21h

mov ah,4ch              ;end label to terminate the program
int 21h 
    
ret
leaveMe endp

end main