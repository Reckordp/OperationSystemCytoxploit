gdt_descriptor:
	dw 0x0020
	dd LOKASI_GDT

atur_gdt:
	lgdt [gdt_descriptor]
	mov edi, LOKASI_GDT

	; tabel pertama
	mov eax, 0x00
	mov [edi], eax
	mov [edi+4], eax
	add edi, 0x08

	; tabel kedua : Script
	mov eax, 0x0000FFFF
	mov [edi], eax
	mov al, 00000000b
	mov [edi+4], al
	mov al, 10011010b
	mov [edi+5], al
	mov al, 11001111b
	mov [edi+6], al
	mov al, 00000000b
	mov [edi+7], al
	add edi, 0x08

	; tabel ketiga : Data
	mov eax, 0x0000FFFF
	mov [edi], eax
	mov al, 00000000b
	mov [edi+4], al
	mov al, 10010010b
	mov [edi+5], al
	mov al, 11001111b
	mov [edi+6], al
	mov al, 00000000b
	mov [edi+7], al
	add edi, 0x08
	ret

LOKASI_GDT equ 0x0008000