[org 0x7c00]
[bits 16]

utama:
	cli
	call muat_kernel
	call atur_gdt

	mov eax, cr0
	or eax, 0x01
	mov cr0, eax
	jmp PROT_SEG:init_pm

muat_disk:
	mov ah, 0x02 ; BIOS read sector
	mov al, dh
	mov ch, 0x00 ; silinder
	mov dh, 0x00 ; head
	mov cl, 0x02 ; sector
	int 0x13
	ret

muat_kernel:
	mov ax, POSISI_KERNEL_BELAH_KIRI
	mov es, ax
	mov bx, POSISI_KERNEL_BELAH_KANAN
	mov dh, 15
	jmp muat_disk


%include "gdt.asm"

[bits 32]
init_pm:
	xor eax, eax
	mov ax, 0x10
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ds, ax
	mov ss, ax
	mov ebp, 0x9000
	mov esp, ebp
	jmp POSISI_KERNEL

POSISI_KERNEL_BELAH_KIRI equ 0xffff
POSISI_KERNEL_BELAH_KANAN equ 0x0100
POSISI_KERNEL equ 0x0100_0000
PROT_SEG equ 0x0008
KERNEL_SEG equ 0x0008

times 510 - ($-$$) db 0
dw 0xAA55