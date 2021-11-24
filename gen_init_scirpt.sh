#!/bin/bash

# This tool generates a script file which will be executed on
# openEuler RISC-V in the QEMU.



GEN_FILE='import_pubkey.sh'

PUBKEY_FILE="$HOME/.ssh/id_rsa.pub"

die () {
	echo "$*"
	exit 1
}


[ -f "$GEN_FILE" ] && mv -f "${GEN_FILE}{,.old}"

[ -f "$PUBKEY_FILE" ] || die "FATAL: Could not find $PUBKEY_FILE."

cat > "$GEN_FILE" << "EOTXT"
cd
mkdir .ssh
cat > .ssh/authorized_keys <<"EOT"
EOTXT

cat "$PUBKEY_FILE" >> "$GEN_FILE"


cat >> "$GEN_FILE" << "EOTXT"
EOT
chmod 600 .ssh/authorized_keys
EOTXT
