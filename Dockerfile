FROM ubuntu:18.04
LABEL maintainer="techzealot" \
      version="1.0" \
      description="ubuntu 18.04 with tools for tsinghua's rCore-Tutorial-V3"

#install some deps
RUN set -x \
    && apt-get update \
    && apt-get install -y curl wget autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev \
              gawk build-essential bison flex texinfo gperf libtool patchutils bc xz-utils \
              zlib1g-dev libexpat-dev pkg-config  libglib2.0-dev libpixman-1-dev git tmux python3 

#install rust,". $HOME/.cargo/env" equals "source $HOME/.cargo/env" in shell,source only can be used in bash
RUN set -x; \
    RUSTUP='/root/rustup.sh' \
        && cd $HOME \
        #install rust
        && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > $RUSTUP && chmod +x $RUSTUP \
        && $RUSTUP -y --default-toolchain nightly --profile minimal \
        && . $HOME/.cargo/env \
        && rustup target add riscv64gc-unknown-none-elf \
        && cargo install cargo-binutils && rustup component add llvm-tools-preview

#install qemu \
RUN set -x; \
    wget https://ftp.osuosl.org/pub/blfs/conglomeration/qemu/qemu-5.0.0.tar.xz \
    && tar xvJf qemu-5.0.0.tar.xz \
    && cd qemu-5.0.0 \
    && ./configure --target-list=riscv64-softmmu,riscv64-linux-user \
    && make -j$(nproc) install \
    && cd $HOME && rm -rf qemu-5.0.0 qemu-5.0.0.tar.xz