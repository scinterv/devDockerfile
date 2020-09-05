#!/bin/bash
# start code-server
/opt/rcoder/bin/code-server --auth none --bind-addr "127.0.0.1:8080"


# start sshd
/usr/sbin/sshd -D


