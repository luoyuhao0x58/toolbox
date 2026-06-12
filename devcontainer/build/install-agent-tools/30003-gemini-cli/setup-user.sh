#! /bin/bash
set -uexo pipefail

source ~/.bashrc.d/*-nodejs.sh || true
pnpm install -g "@google/gemini-cli@$BUILD_GEMINI_CLI_VERSION"
