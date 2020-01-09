#!/usr/bin/env sh

echo Compiling entry script... && \
mkdir -p "$2/entry_obj/" && \
nasm -f elf32 "$1/entry/entry.asm" -o "$2/entry_obj/entry.o" && \
mkdir -p "$2/bin/" && \
ld -m elf_i386 -T "$1/link.ld" -o "$2/bin/crumble_os" "$2/entry_obj/entry.o" $(echo "${@:3}") && \
echo Built kernel successfully, creating bootable image && \
mkdir -p "$2/iso/isodir/boot/grub" && \
cp "$2/bin/crumble_os" "$2/iso/isodir/boot/." && \
cp "$1/grub.cfg" "$2/iso/isodir/boot/grub/." && \
grub-mkrescue -o "$2/iso/crumble_os.iso" "$2/iso/isodir/" && \
echo Created CrumbleOs image! 

