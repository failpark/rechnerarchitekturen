#!/bin/sh
# exit on e(rror)
set -e

if [ -z "$1" ]; then
	echo "No filename supplied"
	exit 1;
fi
if [ ! -f "$1" ]; then
	echo "File does not exist"
	exit 1;
fi

# Compile printf.asm if not already compiled
if [ ! -f "bin/printf.o" ]; then
	nasm -f elf -g "printf.asm" -o "bin/printf.o"
fi

# Compile start.asm if not already compiled
if [ ! -f "bin/start.o" ]; then
	nasm -f elf -g "start.asm" -o "bin/start.o"
fi

# strip .asm extension
filename=$(basename "$1" .asm)

# -g generate debug info
nasm -f elf -g "$1" -o "bin/$filename.o"

x86_64-elf-ld -m elf_i386 -o "bin/$filename" "bin/$filename.o" "bin/printf.o" "bin/start.o"

# build and start container
podman build --build-arg BIN_NAME="$filename" --quiet --tag "$filename" --file Dockerfile

# podman run --rm --quiet -e "BIN_NAME=$filename" "localhost/$filename"
podman run -it --rm "localhost/$filename"