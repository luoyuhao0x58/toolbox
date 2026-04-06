[program:openclaw]
command=/usr/local/bin/openclaw gateway --allow-unconfigured --verbose run
user = @@OPENCLAW_USER@@
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile=/dev/stderr
stderr_logfile_maxbytes=0
stdout_logfile_backups=0
stderr_logfile_backups=0
autostart = true
autorestart = true
pidfile=@@OPENCLAW_USER_HONE@@/.%(program_name)s.pid
environment = OPENCLAW_NO_RESPAWN="1",NODE_COMPILE_CACHE="/var/tmp/openclaw-compile-cache",HOME="@@OPENCLAW_USER_HONE@@"
directory=@@OPENCLAW_USER_HONE@@/.openclaw
