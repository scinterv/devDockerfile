#!/bin/bash
# start code-server
/opt/rcoder/bin/code-server --auth none --bind-addr "0.0.0.0:8080"

# start sshd
/usr/sbin/sshd -D


