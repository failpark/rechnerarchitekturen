FROM scratch AS base
ARG BIN_NAME
COPY bin/${BIN_NAME} /asm-bin
CMD ["/asm-bin"]

# Debug image (for file system excercises etc)
FROM alpine:latest AS debug
ARG BIN_NAME
COPY bin/${BIN_NAME} /asm-bin
CMD ["/bin/sh", "-c", "/asm-bin && /bin/sh"]