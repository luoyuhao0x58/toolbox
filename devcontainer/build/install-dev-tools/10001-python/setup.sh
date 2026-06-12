#! /bin/bash
set -uexo pipefail

sed -e "s|@@PIP_MIRROR@@|${BUILD_PIP_MIRROR}|g" \
    -e "s|@@PIP_EXTRA_MIRROR@@|${BUILD_PIP_EXTRA_MIRROR}|g" \
    ./pip.conf.tpl > /etc/pip.conf

apt install -y --no-install-recommends \
  python3 \
  python3-pip \
  python3-venv \
  python3-dev \
  python3-httpx \
  pipx

pipx install --global --system-site-packages uv
pipx install --global --system-site-packages ruff
pipx install --global --system-site-packages ty
pipx install --global --system-site-packages ipython

for user in "$BUILD_USER_NAME" "$BUILD_AGENT_USER_NAME"; do
  sudo --preserve-env=BUILD_PIP_MIRROR,BUILD_PIP_EXTRA_MIRROR,BUILD_UV_PYTHON_INSTALL_MIRROR -u "$user" ./setup-user.sh
done
