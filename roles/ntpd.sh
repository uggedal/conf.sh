#!/bin/sh

set -e

pkg openntpd

tmpl ntpd.confd /etc/conf.d/ntpd ntpd
