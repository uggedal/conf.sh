[uwsgi]

master = true
auto-procname = true

socket = /var/run/uwsgi/%n.sock
chmod-socket = 660

logto = /var/log/uwsgi/%n.log
disable-logging = true

plugin-dir = /usr/lib/uwsgi
plugins = python

{{#_uwsgi_chdir}}
chdir = {{_uwsgi_chdir}}
{{/_uwsgi_chdir}}

{{#_uwsgi_django}}
env = DJANGO_SETTINGS_MODULE={{_uwsgi_module}}.settings
{{/_uwsgi_django}}

{{^_uwsgi_django}}
module = {{_uwsgi_module}}
{{/_uwsgi_django}}

processes = {{_uwsgi_processes}}

{{#_uwsgi_idle}}
idle = 60
{{/_uwsgi_idle}}

procname-prefix-spaced = %n:
