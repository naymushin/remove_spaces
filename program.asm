; Program code for removing all spaces from string
; in a memory and printing result on the screen
ASSUME CS:MYCODE
    
    MYDATA SEGMENT
        FIRSTLINE   DB  "TEST TEST TEST 1", 0
    MYDATA ENDS
    
    MYCODE SEGMENT
        MYSTART:
        
        MOV AX, 0B800H  ; start of memory page
        MOV ES, AX
        MOV DI, 0

        MOV AX, MYDATA
        MOV DS, AX
        MOV SI, OFFSET FIRSTLINE
    
        MOV AH, 0EH     ; changes color of text to yellow
write:
        MOV AL, DS:[SI] ; read character
        cmp     AL, 20h ; compare with space
        jne     Print   ; if not space - print
        jmp     Space   ; skip printing code – we don’t print space
Print:
        MOV ES:[DI], AX            
        ADD DI, 2       ; for printing purpose 1 character holds 2 memory cells (2 bytes)
Space:
        ADD SI, 1       ; in memory character are stored in single memory cell (1 byte)
    
        CMP AL, 0
        JNZ write
                        ; block for screen freezing
        MOV AX, 0
outer:      
        MOV DX, 0
inner:      
        INC DX
        JNZ inner
        INC AX
        JNZ outer
                                        
        MOV AX, 4c00H   ; exit in DOS
        INT 21H         ; DOS call, stop program

    MYCODE ENDS

END MYSTART