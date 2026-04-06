#! /bin/bash
set -uexo pipefail

export COREPACK_ENABLE_DOWNLOAD_PROMPT=0
source ~/.bashrc.d/*-nodejs.sh || true
pnpm install -g "@google/gemini-cli@$BUILD_GEMINI_CLI_VERSION"