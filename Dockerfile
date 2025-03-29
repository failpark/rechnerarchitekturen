# most minimal image
# use ubuntu if you need to debug ¯\_(ツ)_/¯
FROM scratch

ARG BIN_NAME
# Copying the compiled file to the container
COPY bin/${BIN_NAME} /asm-bin

# exec the bin
CMD ["/asm-bin"]