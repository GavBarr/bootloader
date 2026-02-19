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

	mov [boot_drive], dl
	
	mov si, dap
	mov ah, 0x42
	mov dl, [boot_drive]
	int 0x13
	jc err
	
	jmp 0x7E00 ;stage 2
	;jmp $ ;hang

err:
	mov ah, 0x0E ;teletype mode
        mov al, dl
        int 0x10

	jmp $ ;hang because of the error

boot_drive:
	db 0

dap:
	db 0x10 ;total size of DAP is 16 bytes
	db 0x00 ; reserved as 0
	dw 0x04; define word, number of sectors to read
	dw 0x7E00 ;offset
	dw 0x00 ;segment to load into
	dq 0x01 ;LBA start sector

times 510 - ($ - $$) db 0 ;essentially filling the remaing available bytes with 0s
dw 0xAA55 ;boot signature for the BIOS to recognize
	
