#!/bin/sh

set -e

pkg sudo

tmpl templates/sudoers /etc/sudoers
