#!/usr/bin/bash

sudo dockerd-entrypoint.sh >/dev/null 2>/dev/null &

sudo chown -R $(whoami) /var/run/docker.sock

code -v tunnel

