[org 0x7c00]

mov [BOOT_PANGKAL], dl
jmp utama

[bits 16]

%include "gdt.asm"

muat_disk:
	mov ah, 0x02 ; BIOS read sector
	mov al, dh
	mov ch, 0x00 ; silinder
	mov dh, 0x00 ; head
	mov cl, 0x02 ; sector
	int 0x13
	ret


muat_kernel:
	mov bx, POSISI_KERNEL
	mov dh, 15
	mov dl, [BOOT_PANGKAL]
	call muat_disk
	ret

utama:
	call muat_kernel
	call atur_gdt
	cli

	mov eax, cr0
	or eax, 0x01
	mov cr0, eax
	jmp PROT_SEG:init_pm

[bits 32]
init_pm:
	xor eax, eax
	mov ax, 0x20
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ds, ax

	mov ax, 0x18
	mov ss, ax
	mov ebp, 0x4FF0
	; mov ebp, 0x9000
	mov esp, ebp

	mov ax, KERNEL_SEG
	mov es, ax
	push ax
	mov eax, dword [es:0x00]
	push eax
	retf

BOOT_PANGKAL db 0
POSISI_KERNEL equ 0x1000
PROT_SEG equ 0x0008
KERNEL_SEG equ 0x0010

times 510 - ($-$$) db 0
dw 0xAA55