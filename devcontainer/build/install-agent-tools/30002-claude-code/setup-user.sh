#! /bin/bash
set -uexo pipefail

source ~/.bashrc.d/*-nodejs.sh || true
pnpm install -g "@anthropic-ai/claude-code@$BUILD_CLAUDE_CODE_VERSION"
