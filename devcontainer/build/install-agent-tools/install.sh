#! /bin/bash
set -uexo pipefail

apt-get update -y

corepack enable

for filename in $(ls ./*-*/setup.sh | sort); do
  cd $(dirname $filename)
  ./setup.sh
  cd -
done

corepack disable
