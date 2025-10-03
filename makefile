NASM = nasm
CC = i386-elf-gcc
LD = ld
NASMFLAGS = -f elf32
CFLAGS = -m32 -ffreestanding -O2 -Wall -Wextra

all: myos.iso

kernel.o: kernel.asm
	$(NASM) $(NASMFLAGS) -o $@ $<

kernel_c.o: kernel.c
	$(CC) $(CFLAGS) -c -o $@ $<

kernel.elf: kernel.o kernel_c.o link.ld
	$(LD) -m elf_i386 -T link.ld -o $@ kernel.o kernel_c.o

iso/boot/grub/grub.cfg:
	mkdir -p iso/boot/grub
	cp grub.cfg iso/boot/grub/grub.cfg

iso/boot/kernel.elf: kernel.elf
	mkdir -p iso/boot
	cp kernel.elf iso/boot/kernel.elf

myos.iso: iso/boot/kernel.elf iso/boot/grub/grub.cfg
	grub-mkrescue -o myos.iso iso

clean:
	rm -f kernel.o kernel_c.o kernel.elf myos.iso
	rm -rf iso
