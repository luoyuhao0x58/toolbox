#! /bin/bash

source /etc/shell.rc
cp ./bashrc.sh "$HOME/.bashrc.d/$(basename "$(pwd -P)").sh"
source "$HOME/.bashrc.d/$(basename "$(pwd -P)").sh"
curl $BUILD_RUST_RUSTUP_INIT_SCRIPT_MIRROR -sLSf | sh -s -- -y --no-modify-path --default-toolchain none
