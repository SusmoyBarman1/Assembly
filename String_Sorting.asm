
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.Model small
.Stack
.Data
     msg1 db "Enter the String: $"
     msg2 db 10,13," $"
     var dw ?
     var2 dw ?
     strr db 200 DUP(?)
.Code

main proc
        
        mov ax,@data
        mov ds,ax
        
        mov dx,offset msg1
        mov ah,9
        int 21h
        mov bx,0
        mov si,0
        
    lop:
        mov ah ,1
        int 21h
        mov strr[si],al
        inc bx
        cmp strr[si],0dh
        je end_input
        inc si
        jmp lop
    end_input:
        mov var2,bx
        dec bx
        mov cx,bx
        
    output:
         mov si,0
         
    loop1:
        inc si
        cmp si,cx
        JA loop2
        mov bx,si
        mov di,bx
        dec di
        mov dl,strr[di]
        cmp dl,strr[si]
        JBE loop1
        mov al, dl
        mov bl,strr[si]
        mov strr[di],bl
        mov strr[si],al
        jmp loop1
        
    loop2:
        loop output
        mov ah,9
        mov dx,offset msg2
        int 21h
        mov ah,2
        mov cx,var2
        mov si,0
        
    print:
        mov dl,strr[si]
        int 21h
        inc si
        loop print
        
    EXIT:
        mov ah,4ch
        int 21h
        
    main endp
end main

ret




