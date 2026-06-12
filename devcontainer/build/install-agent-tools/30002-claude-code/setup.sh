#! /bin/bash
set -uexo pipefail

sudo --preserve-env=BUILD_CLAUDE_CODE_VERSION -u "$BUILD_AGENT_USER_NAME" ./setup-user.sh
