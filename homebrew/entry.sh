#!/usr/bin/bash

sudo dockerd-entrypoint.sh >/dev/null 2>/dev/null &

code -v tunnel