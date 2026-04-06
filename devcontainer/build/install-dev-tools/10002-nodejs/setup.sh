#! /bin/bash
set -uexo pipefail

VERSION=$(curl -sL "${BUILD_NODEJS_MIRROR}index.json" | jq -r '[.[] | select(.lts != false)] | first | .version')
ARCH=$(uname -m)
case $ARCH in
  x86_64)  ARCH="x64" ;;
  aarch64) ARCH="arm64" ;;
esac
filename=node-${VERSION}-linux-${ARCH}.tar.xz
curl -LO ${BUILD_NODEJS_MIRROR}${VERSION}/${filename}
tar -xJf ${filename} -C /usr/local --strip-components=1 --exclude='*.md' --exclude='LICENSE'

npm set registry -g "$BUILD_NPM_MIRROR"
export COREPACK_NPM_REGISTRY="$BUILD_NPM_MIRROR"
sudo corepack enable
pnpm config set registry -g "$BUILD_NPM_MIRROR"

sed -e "s|@@NVM_NODEJS_ORG_MIRROR@@|${BUILD_NODEJS_MIRROR}|g" \
    -e "s|@@COREPACK_NPM_REGISTRY@@|${BUILD_NPM_MIRROR}|g" \
    ./bashrc.sh.tpl > /tmp/nodejs.sh
chmod a+x /tmp/nodejs.sh

sudo -u "$BUILD_USER_NAME" ./setup-user.sh
echo "export PATH=\$PATH:$BUILD_AGENT_USER_HOME/.local/share/pnpm" | sudo -u "$BUILD_USER_NAME" tee -a "$BUILD_USER_HOME/.bashrc.d/$(basename "$(pwd -P)").sh"

sudo -u "$BUILD_AGENT_USER_NAME" cp /tmp/nodejs.sh "$BUILD_AGENT_USER_HOME/.bashrc.d/$(basename "$(pwd -P)").sh"
