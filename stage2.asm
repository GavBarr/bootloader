[org 0x7E00]
[bits 16] ;16 bit mode

start:
	mov ah, 0x0E ;teletype mode
        mov al, 'G'
        int 0x10
	jmp $

gdt_start:
          
gdt_null:
        dq 0x00

gdt_code:
        dw 0xFFF ;limit low
        dw 0x000 ;base low
        db 0x00  ;base mid
        db 0x9A  ;access
        db 0xCF  ;granularity
        db 0x00  ;base_high

gdt_data:
        dw 0xFFF
        dw 0x000
        db 0x00
        db 0x92
        db 0xCF
        db 0x00

gdt_end:


gdt_descriptor:
        dw gdt_end - gdt_start - 1
        dd gdt_start

