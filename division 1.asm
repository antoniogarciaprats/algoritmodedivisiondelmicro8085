CPU "8085.TBL"
HOF "INT8"
ORG 1000H


       LDA 1800H   ; (1800) -> A   |
       MOV B,A     ; A -> B        |  CARGA EL DIVIDENDO EN BC
       LDA 1801H   ; (1801) -> A   |
       MOV C,A     ; A -> C        |

       LDA 1900H   ; (1900) -> A   | 
       MOV D,A     ; A -> D        |  CARGA EL DIVISOR EN DE
       LDA 1901H   ; (1901) -> A   |
       MOV E,A     ; A -> E        |
 
       MVI M,00H   ; 0000H -> (HL) |  INICIALIZACION A 0 EL COCIENTE

SIGUE: MOV A,C     ; C -> A        |
       SUB E       ; A - E -> A    |  RESTAMOS LA PARTE BAJA
       MOV C,A     ; A -> C        |
       
       MOV A,B     ; B -> A        |    
       SBB D       ; A -D -CY -> A |  RESTAMOS LA PARTE ALTA
       MOV B,A     ; A -> B        |

       INX H       ; HL + 1 -> HL  |  INCREMENTAMOS EL COCIENTE

       MOV A,B     ; B -> A        |  COMPARAMOS LA PARTE ALTA DEL RESTO CON EL DIVISOR
       CMP D       ; COMPARACION   |

       JZ PBAJA    ; SALTO COND. SI CERO (Z=1)        | SI SON IGUALES MIRAMOS LA PARTE BAJA

       JC FIN      ; SALTO COND. SI ACARREO (CY=1)    | SI ES MENOR EL RESTO QUE EL DIVISOR 
                   ;	                              | TERMINA	
 
       JMP SIGUE   ; SALTO INCOND. | EL RESTO ES MAYOR O IGUAL QUE EL DIVISOR	 

PBAJA: MOV A,C     ; C -> A        |  COMPARAMOS LA PARTE BAJA DEL RESTO Y DEL DIVISOR
       CMP E       ; COMPARACION   |

¿?jnc  JNC FIN     ; SALTO COND. SI NO ACARREO (CY=0) | SI ES MENOR EL RESTO TERMINA 
o jc
       JMP SIGUE   ; SALTO INCOND. |  EL RESTO ES MAYOR O IGUAL QUE EL DIVISOR

FIN:   MOV A,H     ; H -> A        |
       STA 1950H   ; A -> (1950)   |  GUARDAMOS EL COCIENTE
       MOV A,L     ; L -> A        |
       STA 1951H   ; A -> (1951)   |

       MOV A,B     ; B -> A        | 
       STA 1952H   ; A -> (1952)   |  GUARDAMOS EL RESTO
       MOV A,C     ; C -> A        |
       STA 1953H   ; A -> (1953)   |

       END;

; DIVISION DE 16 BITS
;
; dividendo 1800-01, divisor 1900-01, cociente 1950-51, resto 1952-53
; si la division no se puede efectuar las p.m. del resultado seria 0




