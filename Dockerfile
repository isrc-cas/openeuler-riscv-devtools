FROM ubuntu:20.04

RUN sed -i 's,archive.ubuntu.com,mirrors.tuna.tsinghua.edu.cn,g' /etc/apt/sources.list
RUN apt-get update -qq \
    && \
    DEBIAN_FRONTEND=noninteractive \
    apt install -y -qq --no-install-recommends \
    vim htop tmux git build-essential cmake wget expect  python3 python3-pip ninja-build cmake pkg-config libglib2.0-dev libpixman-1-dev \
    && \
    rm -rf /var/lib/apt/lists/*


WORKDIR /root/
COPY fw_payload_oe.elf ./
COPY openEuler-preview.riscv64.qcow2 ./
COPY vm_*.sh *.exp ./
ADD qemu.20210207.tbz ./
WORKDIR /root/qemu
RUN git checkout v5.0.0 && git clean -fdx
RUN ./configure --target-list=riscv64-softmmu && make -j $(nproc) && make install

WORKDIR /root/
CMD qemu-system-riscv64   -nographic -machine virt   -smp 8 -m 32G   -kernel fw_payload_oe.elf   -drive file=openEuler-preview.riscv64.qcow2,format=qcow2,id=hd0   -object rng-random,filename=/dev/urandom,id=rng0   -device virtio-rng-device,rng=rng0   -device virtio-blk-device,drive=hd0   -device virtio-net-device,netdev=usernet   -netdev user,id=usernet,hostfwd=tcp::12066-:22   -append 'root=/dev/vda1 rw console=ttyS0 systemd.default_timeout_start_sec=600 selinux=0 highres=off mem=32G earlycon'

