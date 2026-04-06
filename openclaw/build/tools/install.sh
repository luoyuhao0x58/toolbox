#! /bin/bash
set -uexo pipefail

export agent=$(grep "AI" /etc/passwd | cut -d ':' -f 1)

apt-get update -y
for filename in $(ls ./*-*/setup.sh | sort); do
  cd $(dirname $filename)
  ./setup.sh
  cd -
done

sed -i 's/^autostart = false$/autostart = true/' /etc/supervisor/conf.d/cron.conf
