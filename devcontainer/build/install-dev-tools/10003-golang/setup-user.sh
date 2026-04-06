#! /bin/bash
set -uexo pipefail

mkdir -p ~/.g/bin
mkdir -p ~/.g/go
mkdir -p ~/.g/versions

arch="$1"
version=$(basename $(curl -I https://github.com/voidint/g/releases/latest 2>/dev/null | grep location | cut -d ' ' -f 2) | tr -cd '0-9.')
filename="g$version.linux-$arch.tar.gz"
curl -L "https://github.com/voidint/g/releases/download/v$version/$filename" -o "/tmp/$filename"
tar xzf "/tmp/$filename" -C ~/.g/bin

sed -e "s|@@BUILD_GOMIRROR@@|${BUILD_GOMIRROR}|g" \
    -e "s|@@BUILD_GOPROXY@@|${BUILD_GOPROXY}|g" \
    ./genv.tpl >> ~/.g/env

cp ./bashrc.sh "$HOME/.bashrc.d/$(basename "$(pwd -P)").sh"
