#! /usr/bin/bash
set -uexo pipefail

curl -fsSL https://pgp.mongodb.com/server-8.0.asc | sudo gpg --dearmor -o /etc/apt/keyrings/mongodb-server-8.0.gpg
echo "deb [signed-by=/etc/apt/keyrings/mongodb-server-8.0.gpg] https://mirrors.tuna.tsinghua.edu.cn/mongodb/apt/debian trixie/mongodb-org/8.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
apt-get update -y
apt-get install -y mongodb-mongosh
