#!/bin/bash

# Need root

# ref: https://gitee.com/zxs-un/openEuler-port2riscv64/blob/master/doc/vm-qemu-openEuler-riscv64.md

# Trick: get current time directly from NTP servers.

cat </dev/tcp/time.nist.gov/13 | awk '{print $2, $3}' | xargs -I {} date -s "{}"

systemctl disable auditd
systemctl disable systemd-networkd-wait-online

mv /etc/yum.repos.d/oe-rv.repo{,.orig}
cat > /etc/yum.repos.d/oe-rv.repo << "EOT"
[base]
name=base
baseurl=https://isrc.iscas.ac.cn/mirror/openeuler-sig-riscv/oe-RISCV-repo/
enabled=1
gpgcheck=0

[everything]
name=everything
baseurl=https://repo.openeuler.org/openEuler-preview/RISC-V/everything/
enabled=1
gpgcheck=0
EOT

yum update -y
yum install -y osc sudo

# Create a normal user
adduser -p openEuler plctlab
mkdir ~plctlab/.ssh
cp ~/.ssh/authorized_keys ~plctlab/.ssh
chown -R plctlab.plctlab ~plctlab/.ssh

# Disable password login
grep ^Password /etc/ssh/sshd_config 
sed -i 's,^PasswordAuthentication yes,PasswordAuthentication no,' /etc/ssh/sshd_config 
grep ^Password /etc/ssh/sshd_config 
systemctl restart sshd
