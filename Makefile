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

# Load in file lists
# C_SRC_LIST_FILE:=c_srcs.txt
# C_SRCS:=$($(SHELL) cat ${C_SRC_LIST_FILE})
# ASM_SRC_LIST_FILE:=asm_srcs.txt

OBJS:=$(OBJ_DIR)/kernel.o $(OBJ_DIR)/bootloader.o


all : $(BIN_DIR)/kernel-0

$(OBJ_DIR)/kernel.o : $(SRC_DIR)/kernel.c
	mkdir -p $(OBJ_DIR)
	$(CXX) -m32 -c $< -o $@

$(OBJ_DIR)/bootloader.o : bootloader/bootloader.asm
	mkdir -p $(OBJ_DIR)
	$(NASM) -f elf32 $< -o $@

$(BIN_DIR)/kernel-0 : $(OBJS)
	mkdir -p $(BIN_DIR)
	ld -m elf_i386 -T link.ld -o $@ $^