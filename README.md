# Crumble OS
A test os targetting x86 cpus.

# Build
To build the operating system, run the following commands.

`mkdir build`

`cd build`

`cmake ..`

`make`

You can find the iso under the iso directory created in the bin folder.

# Extra Required Build Tools
+ NASM - Compile assembly
+ grub - Generate iso
+ mtools - Used by grub-mkrescue
