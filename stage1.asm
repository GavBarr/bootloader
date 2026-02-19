[org 0x7C00] ;BIOS always loads the MBR to 0x7C00, essentially needed for hardware
[bits 16] ;16 bit mode

start:
	cli ;clear interrupts
	xor ax, ax ;zeroes out the segment registers
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7C00 ;sets stack pointer, growing down away from the bootloader
	sti ;enable interrupts
	jmp display_msg
	
	jmp $ ;hang

display_msg:
	mov ah, 0x0E ;teletype mode
        mov al, 'G'
        int 0x10

        mov ah, 0x0E ;teletype mode
        mov al, 'O'
        int 0x10
        mov ah, 0x0E ;teletype mode
        mov al, 'O'
        int 0x10

        mov ah, 0x0E ;teletype mode
        mov al, 'S'
        int 0x10

        mov ah, 0x0E ;teletype mode
        mov al, 'E'
        int 0x10

	ret

times 510 - ($ - $$) db 0 ;essentially filling the remaing available bytes with 0s
dw 0xAA55 ;boot signature for the BIOS to recognize
	
