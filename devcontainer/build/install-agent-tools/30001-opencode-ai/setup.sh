#! /bin/bash
set -uexo pipefail

sudo --preserve-env=BUILD_OPENCODE_AI_VERSION -u "$BUILD_AGENT_USER_NAME" ./setup-user.sh
