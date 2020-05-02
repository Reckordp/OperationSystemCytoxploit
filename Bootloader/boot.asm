[org 0x7c00]

mov [BOOT_PANGKAL], dl
jmp utama

%include "gdt.asm"

[bits 16]

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
	cli
	lgdt [gdt_descriptor]
	mov eax, cr0
	or eax, 0x1
	mov cr0, eax
	jmp CODE_SEG:init_pm
	hlt

[bits 32]
init_pm:
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ebp, 0x90000
	mov esp, ebp
	jmp POSISI_KERNEL
	hlt

BOOT_PANGKAL db 0
POSISI_KERNEL equ 0x1000

times 510 - ($-$$) db 0
dw 0xaa55