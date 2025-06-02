You need the following things for this to work
(Please open a issue or ping me if you encounter if you run into problems)

- Podman
- nasm
- x86_64-elf-gcc

```sh
brew install podman-desktop nasm x86_64-elf-gcc
```

This should be obvious, but podman needs to be running for this to work.

Standard use is:
```sh
./bootstrap.sh path
```
where path is the path to the .asm file you want to run

Example:
```sh
./bootstrap.sh ./L4/hello.asm
```
would run the hello world file
(don't be alarmed. The thing above "Hello, world!" is the hash of the container where the asm is run. You can safely ignore it)
