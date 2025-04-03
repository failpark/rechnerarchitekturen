You need the following things for this to work
(Please open a issue or ping me if you encounter if you run into problems)

- Podman
- nasm
- x86_64-elf-gcc

```sh
brew install podman-desktop nasm x86_64-elf-gcc
```

to login to the container use
```sh
podman run -it --rm localhost/<filename>
```
