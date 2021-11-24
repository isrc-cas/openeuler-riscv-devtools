#!/bin/bash

# Need root

# Trick: get current time directly from NTP servers.

cat </dev/tcp/time.nist.gov/13 | awk '{print $2, $3}' | xargs -I {} date -s "{}"

systemctl disable auditd
systemctl disable systemd-networkd-wait-online

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
