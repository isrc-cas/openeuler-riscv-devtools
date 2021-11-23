build:
	(DATETAG=$$(date +%Y%m%d_%H%M) ; docker build . -t oerv:$$DATETAG )
try:
	docker run --rm -ti ubuntu:20.04

prepare:
	bash prepare_downloads.sh

remove-downloads:
	rm -f fw_payload_oe.elf
	rm -f openEuler-preview.riscv64.qcow2
	rm -f qemu.20210207.tbz
