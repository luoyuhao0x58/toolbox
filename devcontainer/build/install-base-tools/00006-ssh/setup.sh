#! /usr/bin/bash
set -uexo pipefail

apt-get install -y openssh-server

# configure sshd
sudo sed -i "s/^#HostKey \/etc\/ssh\/\(.*\)/HostKey \/etc\/ssh\/hostkey\/\1/g" /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
sudo mkdir -p /run/sshd /etc/ssh/hostkey/ && sudo mv /etc/ssh/ssh_host_* /etc/ssh/hostkey/
cp ./supervisord.conf /etc/supervisor/conf.d/sshd.conf
mkdir -p /var/log/supervisor/sshd

for user in "$BUILD_USER_NAME" "$BUILD_AGENT_USER_NAME"; do
  sudo -u "$user" ./setup-user.sh
done