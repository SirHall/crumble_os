SHELL=/usr/bin/env sh
CXX:=gcc
CXX_FLAGS:=-Wall -Wextra -Wpedantic -Wno-unknown-pragmas -Wno-unused-parameter -Werror -Iinclude -std=c11 -g -fbounds-check
NASM:=nasm
NASM_FLAGS:=

SRC_DIR:=src
INCLUDE_DIR:=include

BUILD_DIR:=build
BIN_DIR:=$(BUILD_DIR)/bin
OBJ_DIR:=$(BUILD_DIR)/obj
DEP_DIR:=$(BUILD_DIR)/dep

EXE_NAME:=crumble_os

# Load in file lists
# C_SRC_LIST_FILE:=c_srcs.txt
# C_SRCS:=$($(SHELL) cat ${C_SRC_LIST_FILE})
# ASM_SRC_LIST_FILE:=asm_srcs.txt

OBJS:=$(OBJ_DIR)/kernel.o $(OBJ_DIR)/entry.o


all : iso

iso : $(BIN_DIR)/$(EXE_NAME)
	mkdir -p $(BUILD_DIR)/iso/isodir/boot/grub
	cp $(BIN_DIR)/$(EXE_NAME) $(BUILD_DIR)/iso/isodir/boot/.
	cp grub.cfg $(BUILD_DIR)/iso/isodir/boot/grub/.
	grub-mkrescue -o $(BUILD_DIR)/iso/$(EXE_NAME).iso build/iso/isodir


$(OBJ_DIR)/kernel.o : $(SRC_DIR)/kernel.c
	mkdir -p $(OBJ_DIR)
	$(CXX) -m32 -c -ffreestanding -fno-builtin -Os $< -o $@

$(OBJ_DIR)/entry.o : entry/entry.asm
	mkdir -p $(OBJ_DIR)
	$(NASM) -f elf32 $< -o $@

$(BIN_DIR)/$(EXE_NAME) : $(OBJS)
	mkdir -p $(BIN_DIR)
	ld -m elf_i386 -T link.ld -o $@ $^