#! /bin/bash
set -uexo pipefail

export COREPACK_ENABLE_DOWNLOAD_PROMPT=0
source ~/.bashrc.d/*-nodejs.sh || true
pnpm install -g "@fission-ai/openspec@$BUILD_OPENSPEC_VERSION"
