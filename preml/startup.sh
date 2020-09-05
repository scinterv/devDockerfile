#!/bin/bash
# start coder-server
/opt/rcoder/bin/coder-server --auth none --bind-addr "0.0.0.0:8080"

# start up redis-service
redis-server /etc/redis/redis.conf

# start up sshd service
/usr/sbin/sshd -D

# start jupyter notebook
jupyter-notebook --no-browser --allow-root --ip='*' --port 8888
--NotebookApp.token='' --NotebookApp.password='' & > /dev/null
