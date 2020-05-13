 CPU "8085.TBL"
 HOF "INT8"
 ORG 1000h

        ; COPIAR LOS DATOS EN LAS POSICIONES DE MEMORIA
        XRA A

        ; DIVIDENDO
        MVI A, 0FFh
        STA 1800h
        MVI A, 0FFh
        STA 1801h

        ; DIVISOR
        MVI A, 22h
        STA 1900h
        MVI A, 22h
        STA 1901h

        XRA A

        ; DIRECCIONES DEL DIVIDENDO Y DEL DIVISOR.
        MVI B, 0FFh
        MVI C, 0FFh

        MVI D, 22h
        MVI E, 22h

        ; COMPROBAMOS SI SEE PUEDEN DIVIDIR
        MOV A, B
        CMP D
        JNC POSIC

POSIC:  XRA A           ; PONEMOS EL ACUMULADOR A 0
        STA 1950
        STA 1951
        STA 1952
        STA 1953

        ; RESTAMOS LOS NUMERO DE 16 BITS SUCESIVAMENTE HASTA QUE EL DIVIDENDO
        ; SEA MENOR QUE EL DIVISOR O CERO

        LXI H, 0000h

LOOP:   MOV A, C        ; MOVEMOS EL CONTENIDO DE C AL ACUMULADOR
        SUB E           ; RESTAMOS C - E
        MOV C, A        ; GUARDAMOS EL RESULTADO A C
        MOV A, B        ; MOVEMOS EL CONTENIDO DE B AL ACUMULADOR
        SBB D           ; RESTAMOS B - D
        MOV B, A
        INX H
        MOV A, B
        CMP D
        JC COMPAR2
        JC COMPAR2

COMPAR2:    MOV A, C
            CMP E
            JC RESUELVE
            JNC LOOP

        ; GUARDAR EL COCIENTE Y EL RESTO EN LAS POSICIONES INDICADAS
        ; COCIENTE
RESUELVE:       MOV A, H
                STA 1950h
                MOV A, L
                STA 1951h

        ; RESTO
                MOV A, B
                STA 1952h
                MOV A, C
                STA 1953h
                JMP SALIR
       
SALIR:  END

;BIEN
        
