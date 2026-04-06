#! /bin/bash
set -uexo pipefail


LATEST=$(curl -s "$BUILD_GOMIRROR/VERSION?m=text" | head -1)

function get_arch() {
    a=$(uname -m)
    case ${a} in
    "x86_64" | "amd64")
        echo "amd64"
        ;;
    "i386" | "i486" | "i586")
        echo "386"
        ;;
    "aarch64" | "arm64")
        echo "arm64"
        ;;
    "armv6l" | "armv7l")
        echo "arm"
        ;;
    "s390x")
        echo "s390x"
        ;;
    "riscv64")
        echo "riscv64"
        ;;
    *)
        echo ""
        ;;
    esac
}

arch=$(get_arch)
target_file="$LATEST.linux-$arch.tar.gz"
wget "$BUILD_GOMIRROR/dl/$target_file"

tar -C /usr/local -xzf "$target_file"
rm -rf "$target_file"

echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/shell.rc

sudo -u $BUILD_USER_NAME --preserve-env=BUILD_GOMIRROR,BUILD_GOPROXY ./setup-user.sh $arch
