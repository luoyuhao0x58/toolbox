#! /usr/bin/bash

export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NODE_OPTIONS=${NODE_OPTIONS:-"--max-old-space-size=2048"}
export NVM_NODEJS_ORG_MIRROR=${NVM_NODEJS_ORG_MIRROR:-@@NVM_NODEJS_ORG_MIRROR@@}
export COREPACK_NPM_REGISTRY=${COREPACK_NPM_REGISTRY:-@@COREPACK_NPM_REGISTRY@@}
export COREPACK_ENABLE_DOWNLOAD_PROMPT=0
