#! /bin/bash
set -uexo pipefail

mkdir -p /var/tmp/openclaw-compile-cache
mkdir -p ~/.openclaw/
chmod 700 ~/.openclaw
rsync -a --ignore-times ./data/ ~/.openclaw/
cp init.sh ~/.init
