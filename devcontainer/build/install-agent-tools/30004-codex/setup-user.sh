#! /bin/bash
set -uexo pipefail

source ~/.bashrc.d/*-nodejs.sh || true
pnpm install -g "@openai/codex@$BUILD_CODEX_VERSION"
