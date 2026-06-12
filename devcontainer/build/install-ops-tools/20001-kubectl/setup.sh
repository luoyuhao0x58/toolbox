#! /usr/bin/bash
set -uexo pipefail

BUILD_K8S_VERSION=$(curl https://dl.k8s.io/release/stable.txt 2>/dev/null | cut -d'.' -f1,2)
curl -fsSL "${BUILD_K8S_MIRROR}/core/stable/${BUILD_K8S_VERSION}/deb/Release.key" |
    gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] ${BUILD_K8S_MIRROR}/core/stable/${BUILD_K8S_VERSION}/deb/ /" |
    tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubectl
