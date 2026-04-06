#! /bin/sh

export GOROOT="${HOME}/.g/go"
[ -z "$GOPATH" ] && export GOPATH="${HOME}/go"
export PATH="${HOME}/.g/bin:${GOROOT}/bin:${GOPATH}/bin:$PATH"
export G_MIRROR="${G_MIRROR:-@@BUILD_GOMIRROR@@/dl}"
export GOPROXY="${GOPROXY:-@@BUILD_GOPROXY@@}"
export GOEXPERIMENT=jsonv2
