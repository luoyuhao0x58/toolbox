[unix_http_server]
file=/var/run/supervisor.sock
chmod=0770
chown=@@UNIX_HTTP_SERVER_USER@@:@@UNIX_HTTP_SERVER_GROUP@@

[supervisord]
nodaemon=true
logfile=/var/log/supervisor/supervisord.log
loglevel=info
user=root
silent=true
pidfile=/var/run/supervisor.sock
directory=/var/log/supervisor/

[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix:///var/run/supervisor.sock

[include]
files = /etc/supervisor/conf.d/*.conf