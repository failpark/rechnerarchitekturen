alias bootstrap := run
alias r := run
alias rs := run-shell

_default:
	@just --list

printf:
	nasm -f elf -g "printf.asm" -o "bin/printf.o"

run path:
	./bootstrap.sh {{ join(invocation_directory(), clean(path)) }}

run-shell path:
	./bootstrap.sh {{ join(invocation_directory(), clean(path)) }} debug

kill:
	podman kill $(podman ps --last 1 --format '{{{{.Names}}')

test:
	./test.sh
