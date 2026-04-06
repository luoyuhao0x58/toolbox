#! /bin/bash
set -uexo pipefail

sudo --preserve-env=BUILD_CODEX_VERSION -u "$BUILD_AGENT_USER_NAME" ./setup-user.sh
