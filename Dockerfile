FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    gcc-arm-none-eabi \
    binutils-arm-none-eabi \
    make \
    stlink-tools \
    usbutils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work

COPY . .

CMD ["make"]