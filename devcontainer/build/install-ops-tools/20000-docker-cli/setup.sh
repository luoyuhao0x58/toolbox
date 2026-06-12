#! /usr/bin/bash
set -uexo pipefail

apt-get install -y docker-cli docker-compose docker-buildx
groupadd -g $BUILD_DOCKER_GID docker

for user in "$BUILD_USER_NAME" "$BUILD_AGENT_USER_NAME"; do
  usermod -aG docker "$user"
done

echo 'alias docker="sudo docker"' | sudo -u "$BUILD_USER_NAME" tee -a "$BUILD_USER_HOME/.bash_aliases"
