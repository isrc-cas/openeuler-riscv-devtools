#!/bin/bash

# Arg 1: filename
# Arg 2: URL
function ensure_file () {
	if [ -f "$1" ]; then
		echo "FILE: $1 has been downloaded. Skip."
	else
		echo "FILE: $1 had not been downloaded. Downloading"
		wget --no-check-certificate -O "$1" "$2"
	fi
}

ensure_file fw_payload_oe.elf https://repo.openeuler.org/openEuler-preview/RISC-V/Image/fw_payload_oe.elf
ensure_file openEuler-preview.riscv64.qcow2 https://repo.openeuler.org/openEuler-preview/RISC-V/Image/openEuler-preview.riscv64.qcow2
ensure_file qemu.20210207.tbz https://mirror.iscas.ac.cn/plct/qemu.20210207.tbz
