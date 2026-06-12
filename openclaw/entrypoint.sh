#! /bin/bash

gen_pass() {
    local len=${1:-12}
    openssl rand -base64 48 | tr -dc 'a-zA-Z0-9' | head -c "$len"
}

echo "root:$(gen_pass)" | su-exec root chpasswd
admin=$(grep "admin" /etc/passwd | cut -d ':' -f 1)
echo "$admin:$(gen_pass)" | su-exec root chpasswd
agent=$(grep "AI" /etc/passwd | cut -d ':' -f 1)
echo "$agent:$(gen_pass)" | su-exec root chpasswd

EXCLUDE="^HOME=|^USER=|^LOGNAME=|^MAIL=|^SHELL=|^XDG_RUNTIME_DIR=|^XDG_SESSION_ID="
mapfile -t ENV_ARRAY < <(env | grep -Ev "$EXCLUDE")

for user in "$admin" "$agent"; do
  init_script="$(getent passwd "$user" | cut -d: -f6)/.init"
  [ -f "$init_script" ] && sudo -u"$user" env "${ENV_ARRAY[@]}" bash "$init_script"
done

export agent_home=$(grep "AI" /etc/passwd | cut -d ':' -f 6)

exec supervisord -n -c /etc/supervisor/supervisord.conf
