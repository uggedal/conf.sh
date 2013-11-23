#!/bin/sh

set -e

tmpl hostname /etc/hostname dns
tmpl hosts /etc/hosts
