You need the following things for this to work
(Please open a issue or ping me if you encounter if you run into problems)

- Podman
- nasm
- x86_64-elf-gcc
- (optional) just

```sh
brew install podman-desktop nasm x86_64-elf-gcc just
```

This should be obvious, but podman needs to be running for this to work.

Standard use is:
```sh
just run path
```
where path is the path to the .asm file you want to run

Example:
```sh
just run ./04/hello.asm
```
would run the hello world file
(don't be alarmed. The thing above "Hello, world!" is the hash of the container where the asm is run. You can safely ignore it)

Because I'm tagging the containers with the filename, the filename has to be lowercase :D snake_case FTW!

If while coding and trying things out and you can't exit the container:
```sh
just kill
```
this will kill the last started container