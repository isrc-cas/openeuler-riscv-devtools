#!/bin/bash

# session name
SN=oerv

# three windows will be created
# 1. dashboard
# 2. oE/RV in QEMU in docker container
# 3. ssh connection to oE/RV


cmd_start_qemu="expect start_openeuler.exp"
cmd_ssh="expect init_vm.exp"

init_session () {
	tmux new-session -s $SN -n dashboard -d
	tmux select-layout -t $SN main-horizontal

	tmux new-window -n qemu -t $SN
	tmux send-keys -t $SN:qemu "$cmd_start_qemu" C-m

	tmux new-window -n ssh -t $SN
	#tmux send-keys -t $SN:ssh "$cmd_ssh" C-m

	#tmux select-window -t $SN:dashboard
}

tmux has-session -t $SN || init_session

tmux attach -t $SN

