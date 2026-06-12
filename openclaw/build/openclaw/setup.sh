#! /bin/bash
set -uexo pipefail

export agent=$(grep "AI" /etc/passwd | cut -d ':' -f 1)
export agent_home=$(grep "AI" /etc/passwd | cut -d ':' -f 6)

npm install -g "openclaw@$BUILD_OPENCLAW_VERSION"
npm i -g clawhub

chown -R "$agent" ./data
sudo -u "$agent" --preserve-env=BUILD_OPENCLAW_VERSION,NODE_COMPILE_CACHE ./setup-user.sh

sed -e "s|@@OPENCLAW_USER@@|${agent}|g" \
    -e "s|@@OPENCLAW_USER_HONE@@|${agent_home}|g" \
    ./supervisord.conf.tpl > /etc/supervisor/conf.d/openclaw.conf
