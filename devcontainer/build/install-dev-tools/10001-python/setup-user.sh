#! /usr/bin/bash
set -uexo pipefail

sed -e "s|@@UV_DEFAULT_INDEX@@|${BUILD_PIP_EXTRA_MIRROR}|g" \
    -e "s|@@UV_INDEX@@|${BUILD_PIP_MIRROR}|g" \
    -e "s|@@UV_PYTHON_INSTALL_MIRROR@@|${BUILD_UV_PYTHON_INSTALL_MIRROR}|g" \
    ./bashrc.sh.tpl > "$HOME/.bashrc.d/$(basename "$(pwd -P)").sh"
chmod a+x "$HOME/.bashrc.d/$(basename "$(pwd -P)").sh"
mkdir -p ~/.local/

mkdir -p ~/.config/ruff/
cp ./ruff.toml ~/.config/ruff/
