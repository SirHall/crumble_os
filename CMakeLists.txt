cmake_minimum_required(VERSION 3.14)

project(crumble_os_proj)

enable_language(C ASM_NASM)

set(INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include/)
set(SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src/)

# Disable implicit linking and build in ELF-32 format
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -c -m32") 
# set(CMAKE_EXE_LINKER_FLAGS "-m elf_i386 -T ${CMAKE_CURRENT_SOURCE_DIR}/link.ld")
# set(CMAKE_C_LINK_EXECUTABLE "/usr/bin/env ld -f elf32 -T ${CMAKE_ASM_NASM_COMPILE_OPTIONS} ${CMAKE}")

# set(CMAKE_ASM_NASM_OBJECT_FORMAT elf32)
# set(CMAKE_ASM_NASM_COMPILE_OPTIONS "${CMAKE_ASM_NASM_COMPILE_OPTIONS} -f elf32")
# set(CMAKE_ASM_NASM_FLAGS "")

set(CMAKE_EXE_LINKER_FLAGS "-T ${CMAKE_CURRENT_SOURCE_DIR}/link.ld")

# Find all source files
file(GLOB_RECURSE SRCS
    "${SOURCE_DIR}/*.cpp"
    "${SOURCE_DIR}/*.c"
    # "${SOURCE_DIR}/*.asm"
    RELATIVE_PATH
)

add_compile_options(-c -m32)

add_library(crumble_os OBJECT ${SRCS})
target_include_directories(crumble_os PUBLIC ${INCLUDE_DIR})
# add_executable(kernel "${CMAKE_CURRENT_SOURCE_DIR}/bootloader/kernel.asm")
# target_link_libraries(kernel crumble_os)

# Setup command that generates the final executable

add_custom_target(
    kernel
    ALL
    DEPENDS crumble_os
    COMMAND /bin/sh ${CMAKE_CURRENT_SOURCE_DIR}/post_build.sh ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_BINARY_DIR} $<TARGET_OBJECTS:crumble_os>
    VERBATIM
)

# && \
#         nasm -f elf64 ${CMAKE_CURRENT_SOURCE_DIR}/bootloader/kernel.asm -o ${CMAKE_BINARY_DIR}/bootloader_obj/bootloader.o && \
#         echo $<TARGET_OBJECTS:crumble_os> \

# ld -T ${CMAKE_CURRENT_SOURCE_DIR}/link.ld -o ${CMAKE_BINARY_DIR}/kernel ${} \
