gdt_descriptor:
	dw 0xFFFF
	dd LOKASI_GDT

atur_gdt:
	lgdt [gdt_descriptor]
	mov edi, LOKASI_GDT

	; tabel pertama
	mov eax, 0x00
	mov [edi], eax
	mov [edi+4], eax
	add edi, 0x08

	; tabel kedua
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

	; tabel ketiga : Script kernel
	mov eax, 0x10004FFF
	mov [edi], eax
	mov al, 00000000b
	mov [edi+4], al
	mov al, 10011010b
	mov [edi+5], al
	mov al, 01000000b
	mov [edi+6], al
	mov al, 00000000b
	mov [edi+7], al
	add edi, 0x08

	; tabel keempat : Stack kernel
	mov eax, 0x50004FFF
	mov [edi], eax
	mov al, 00000000b
	mov [edi+4], al
	mov al, 10010010b
	mov [edi+5], al
	mov al, 01000000b
	mov [edi+6], al
	mov al, 00000000b
	mov [edi+7], al
	add edi, 0x08

	; tabel kelima : Data lainnya
	mov eax, 0xA0004FFF
	mov [edi], eax
	mov al, 00000000b
	mov [edi+4], al
	mov al, 10010010b
	mov [edi+5], al
	mov al, 01000000b
	mov [edi+6], al
	mov al, 00000000b
	mov [edi+7], al
	add edi, 0x08

	; tabel keenam : VGA Buffer
	mov eax, 0x0000FFFF
	mov [edi], eax
	mov al, 00001010b
	mov [edi+4], al
	mov al, 10010010b
	mov [edi+5], al
	mov al, 01000001b
	mov [edi+6], al
	mov al, 00000000b
	mov [edi+7], al
	ret


LOKASI_GDT equ 0x0080000