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

# strip .asm extension
filename=$(basename "$1" .asm)

# -g generate debug info
nasm -f elf -g "$1" -o "bin/$filename.o"

# -e entrypoint is by default _start sooooooo set it here or in our asm file
x86_64-elf-ld -m elf_i386 -e main -o "bin/$filename" "bin/$filename.o"

# build and start container
podman build --build-arg BIN_NAME="$filename" --quiet --tag "$filename" --file Dockerfile

# podman run --rm --quiet -e "BIN_NAME=$filename" "localhost/$filename"
podman run -it --rm "localhost/$filename"