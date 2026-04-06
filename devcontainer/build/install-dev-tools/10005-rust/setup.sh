#! /bin/bash
set -uexo pipefail

RUST_BASE=/opt/rust
export RUSTUP_HOME=$RUST_BASE/rustup
export CARGO_HOME=$RUST_BASE/cargo
export RUSTUP_UPDATE_ROOT="$BUILD_RUST_RUSTUP_MIRROR"
export RUSTUP_DIST_SERVER="$BUILD_RUST_MIRROR"

mkdir -p $RUSTUP_HOME $CARGO_HOME
chmod -R 775 $RUST_BASE
chgrp $BUILD_GROUP_NAME -R $RUST_BASE
curl $BUILD_RUST_RUSTUP_INIT_SCRIPT_MIRROR -sLSf | sh -s -- -y --no-modify-path --default-toolchain stable
cat >> /etc/shell.rc << EOF
export RUSTUP_HOME=$RUSTUP_HOME
export CARGO_HOME=$CARGO_HOME
export PATH="$CARGO_HOME/bin:\$PATH"
export RUSTUP_UPDATE_ROOT=\${RUSTUP_UPDATE_ROOT:-$BUILD_RUST_RUSTUP_MIRROR}
export RUSTUP_DIST_SERVER=\${RUSTUP_DIST_SERVER:-$BUILD_RUST_MIRROR}
EOF

mkdir -p /.cargo
chmod 655 /.cargo
cat >/.cargo/config.toml <<EOF
[source.crates-io]
replace-with = 'rsproxy-sparse'
[source.rsproxy]
registry = "$BUILD_RUST_MIRROR/crates.io-index"
[source.rsproxy-sparse]
registry = "sparse+$BUILD_RUST_MIRROR/index/"
[registries.rsproxy]
index = "$BUILD_RUST_MIRROR/crates.io-index"
[net]
git-fetch-with-cli = true
EOF

( sudo -u $BUILD_USER_NAME --preserve-env=BUILD_RUST_RUSTUP_INIT_SCRIPT_MIRROR ./setup-user.sh )
