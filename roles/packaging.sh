#!/bin/sh

set -e

pkg alpine-sdk git-perl

tmpl abuild.conf /etc/abuild.conf
