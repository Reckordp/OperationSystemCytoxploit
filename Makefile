BOOT_FOLDER=Bootloader/
KERNEL_FOLDER=Kernel/src/

BOOT_BIN=Bootloader/boot.o
KERNEL_BIN=Kernel/build/kernel.o
EMULATOR=qemu-system-i386
MERGER=cat
CC=nasm -f bin

all: OS_binary
	$(EMULATOR) -fda OS_binary

$(BOOT_BIN):
	$(CC) Bootloader/boot.asm -o $(BOOT_BIN) -I$(BOOT_FOLDER)

$(KERNEL_BIN):
	$(CC) Kernel/src/kernel.asm -o $(KERNEL_BIN) -I$(KERNEL_FOLDER)

OS_binary: $(BOOT_BIN) $(KERNEL_BIN)
	$(MERGER) $(BOOT_BIN) $(KERNEL_BIN) > OS_binary

clean:
	rm -rf OS_binary
	rm -rf $(BOOT_BIN)
	rm -rf $(KERNEL_BIN)