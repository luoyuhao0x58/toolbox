#! /bin/bash
set -uexo pipefail

apt-get install -y build-essential autoconf libssl-dev libyaml-dev zlib1g-dev libffi-dev libgmp-dev

RBENV_ROOT="/opt/rbenv"

git clone --depth=1 https://github.com/rbenv/rbenv.git "${RBENV_ROOT}"
git clone --depth=1 https://github.com/rbenv/ruby-build.git "${RBENV_ROOT}/plugins/ruby-build"
git clone --depth=1 https://github.com/AndorChen/rbenv-china-mirror.git "${RBENV_ROOT}/plugins/rbenv-china-mirror"

cat >> /etc/shell.rc << EOF
export RBENV_ROOT="${RBENV_ROOT}"
export PATH="\${RBENV_ROOT}/bin:\${RBENV_ROOT}/shims:\${PATH}"

export RUBY_BUILD_MIRROR_URL="\${RUBY_BUILD_MIRROR_URL:-$BUILD_RUBY_MIRROR}"
export RUBY_BUILD_CACHE_PATH="${RBENV_ROOT}/cache"

EOF

source /etc/shell.rc
mkdir -p "${RBENV_ROOT}/cache"

RUBY_VERSION=$(rbenv install -l 2>/dev/null | grep -E '^\s*[0-9]+\.[0-9]+\.[0-9]+\s*$' | tail -1 | tr -d ' ')
rbenv install "${RUBY_VERSION}"
rbenv global "${RUBY_VERSION}"
rbenv rehash

chmod -R a+rX "${RBENV_ROOT}"

cat > /etc/gemrc << EOF
:sources:
  - ${BUILD_RUBY_GEM_MIRROR}/
gem: "--no-document"
EOF
GEM_BIN="${RBENV_ROOT}/shims/gem"
"${GEM_BIN}" install bundler --no-document -q
rbenv rehash

chmod -R 775 $RBENV_ROOT
chgrp $BUILD_GROUP_NAME -R $RBENV_ROOT

bundle config set --global mirror.https://rubygems.org $BUILD_RUBY_GEM_MIRROR

( sudo -u $BUILD_USER_NAME --preserve-env=BUILD_RUBY_GEM_MIRROR ./setup-user.sh )
