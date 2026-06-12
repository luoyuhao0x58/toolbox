#! /bin/bash
set -uexo pipefail

source ~/.bashrc.d/*-nodejs.sh || true
pnpm install -g "opencode-ai@$BUILD_OPENCODE_AI_VERSION"
