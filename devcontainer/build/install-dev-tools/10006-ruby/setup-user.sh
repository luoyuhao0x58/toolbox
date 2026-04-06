#! /bin/bash

source /etc/shell.rc
cp ./bashrc.sh "$HOME/.bashrc.d/$(basename "$(pwd -P)").sh"
source "$HOME/.bashrc.d/$(basename "$(pwd -P)").sh"

git clone --depth=1 https://github.com/rbenv/rbenv.git "${RBENV_ROOT}"
git clone --depth=1 https://github.com/rbenv/ruby-build.git "${RBENV_ROOT}/plugins/ruby-build"
git clone --depth=1 https://github.com/AndorChen/rbenv-china-mirror.git "${RBENV_ROOT}/plugins/rbenv-china-mirror"

bundle config set --global mirror.https://rubygems.org $BUILD_RUBY_GEM_MIRROR
