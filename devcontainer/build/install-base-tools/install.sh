#! /bin/bash
set -uexo pipefail

# change mirror
sed -i "s/deb.debian.org/${BUILD_APT_MIRROR}/g" /etc/apt/sources.list.d/debian.sources
sed -i 's/Components: main/Components: main contrib non-free/g' /etc/apt/sources.list.d/debian.sources
apt-get update -y
apt-get install -y tzdata locales
apt-get upgrade -y

# change sh
ln -sf /bin/bash /bin/sh
echo '[ -f /etc/shell.rc ] && source /etc/shell.rc' >> /etc/bash.bashrc

# locale setting
echo "C.UTF-8 UTF-8
$BUILD_LANG UTF-8" > /etc/locale.gen
dpkg-reconfigure locales
update-locale "LANG=C.UTF-8"
echo '
export LANG=C.UTF-8' >> /etc/shell.rc

# timezone setting
ln -fs /usr/share/zoneinfo/$BUILD_TZ /etc/localtime
dpkg-reconfigure tzdata

# history setting
sed -r -i -e '/^[[:space:]]*(HISTFILESIZE|HISTCONTROL|HISTSIZE|HISTTIMEFORMAT)=/d' /etc/skel/.bashrc
echo 'export HISTFILESIZE=100000
export HISTCONTROL=ignoredups
export HISTSIZE=10000
export HISTTIMEFORMAT="[%Y-%m-%d %H:%M:%S]  "' > /etc/profile.d/history.sh

# limits setting
echo '*               soft    nofile          65535
*               hard    nofile          65535
root            soft    nofile          65535
root            hard    nofile          65535
root            soft    core            unlimited
root            hard    core            unlimited' > /etc/security/limits.conf

apt-get install -y \
  sudo dpkg-dev lsb-release man-db \
  psmisc inotify-tools sysstat lsof \
  netcat-openbsd net-tools iproute2 iputils-ping dnsutils telnet \
  nmap tcpdump traceroute mtr \
  curl wget rsync \
  zip unzip unrar-free p7zip-full xz-utils \
  file tree jq yq less source-highlight acl \
  subversion \
  screen

# user setting
groupadd -g $BUILD_GID $BUILD_GROUP_NAME
useradd -c 'admin' -d $BUILD_USER_HOME -s /bin/bash -N -m -u $BUILD_UID -g $BUILD_GROUP_NAME -G sudo $BUILD_USER_NAME
useradd -r -c 'AI' -d $BUILD_AGENT_USER_HOME -s /usr/sbin/nologin -N -m -u $BUILD_AGENT_UID -g $BUILD_GROUP_NAME $BUILD_AGENT_USER_NAME
sed -i 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers
echo "$BUILD_AGENT_USER_NAME ALL=(ALL) NOPASSWD: /usr/bin/apt-get, /usr/bin/apt" >> /etc/sudoers
echo "umask 0002" >> "$BUILD_AGENT_USER_HOME"/.bashrc
chmod 770 "$BUILD_AGENT_USER_HOME"
for user in "$BUILD_USER_NAME" "$BUILD_AGENT_USER_NAME"; do
  user_home=$(getent passwd "$user" | cut -d: -f6)
  sudo -u $user bash -c 'mkdir -p $HOME/.bashrc.d/'
  echo '
for filename in $(ls $HOME/.bashrc.d/*.sh 2>/dev/null | sort); do
  source "$filename"
done
' | sudo -u $user tee -a "$user_home/.bashrc"
done

for filename in $(ls ./*-*/setup.sh | sort); do
  cd $(dirname $filename)
  ./setup.sh
  cd -
done

rsync -a --ignore-times ./rootfs/ /

rm -rf /home/*/.sudo_as_admin_successful
rm -rf /home/*/.cache
rm -rf /root/.cache
