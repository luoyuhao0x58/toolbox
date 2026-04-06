#! /bin/bash

export G_MIRROR="${G_MIRROR:-@@BUILD_GOMIRROR@@/dl}"
export GOPROXY="${GOPROXY:-@@BUILD_GOPROXY@@}"
export GONOSUMDB='*'
export GOEXPERIMENT=jsonv2
if [[ -n $(alias g 2>/dev/null) ]]; then
    unalias g
fi
[ -s "${HOME}/.g/env" ] && \. "${HOME}/.g/env"
