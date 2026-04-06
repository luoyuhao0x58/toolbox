#! /usr/bin/bash
set -uexo pipefail

apt-get install -y gnupg2 pinentry-tty

echo 'export GPG_TTY=$(tty)' >>/etc/shell.rc
mkdir -p /etc/gnupg
printf 'pinentry-program /usr/bin/pinentry\ndefault-cache-ttl 604800\nmax-cache-ttl 604800\n' >/etc/gnupg/gpg-agent.conf

for user in "$BUILD_USER_NAME" "$BUILD_AGENT_USER_NAME"; do
  sudo -u "$user" ./setup-user.sh
done
