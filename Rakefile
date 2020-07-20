BOOTLOADER = "Bootloader/boot"
KERNEL = "Kernel/build/kernel.bin"

file BOOTLOADER do
	Dir.chdir("Bootloader")
	sh("rake boot")
	Dir.chdir("..")
end

file KERNEL do 
	Dir.chdir("Kernel")
	sh("rake comb")
	Dir.chdir("..")
end

file "Cytoxploit" => [BOOTLOADER, KERNEL] do 
	sh("cat Bootloader/boot Kernel/build/kernel.bin > Cytoxploit")
end

task :bersih do
	# rm_f BOOTLOADER
	rm_f KERNEL
	rm_f "Cytoxploit"
end

task default: [:bersih, "Cytoxploit"] do
	# sh("qemu-system-i386 -vga virtio -full-screen -fda Cytoxploit")
	# sh("qemu-system-i386 -vga virtio -fda Cytoxploit")
	sh("qemu-system-i386 -fda Cytoxploit")
end