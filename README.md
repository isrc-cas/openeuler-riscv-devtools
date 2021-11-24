# openeuler-riscv-devtools

为 openEuler RISC-V 打包构建中可能用到的各类工具。

## 注意事项及前提条件

1. 默认 Linux 系统，安装了 `docker`, `expect`, and `make`
2. 默认每次推出QEMU就清空了。如果不希望推出时删除，可以修改 `Makefile` 中的对应参数。
3. 运行了配置脚本后，默认关闭了密码登陆，所以也没有修改密码。如果希望保留密码登陆，那么强烈建议修改密码。
4. 默认使用了 12066 端口映射出来。如果使用其它端口，请注意修改 `docker -p` 参数和 `init_vm.exp` 重的参数。

## 如何使用

```
# top dir of this repo
# two tmux windows or terminals are recommended
tmux
#C-b c
# window 1
make build && make run
# wait until the login prompt appears

# window 2
expect init_vm.exp
```

## TODO
[ ] 完成 tmux 两个窗口的自动化有序创建
[ ] `osc` 配置。
