FROM pytorch/pytorch

LABEL maintainer="scinter <byuegv@gmail.com>"

ARG PASSWORD="123456"
ENV NOTVISIBLE "in users profile"

RUN apt-get update \
    && apt-get install -y iproute2 net-tools vim curl wget redis-server openssh-server htop git \
    # configure conda for all user
    # && echo "export PATH=/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" >> /etc/profile \
    && pip install redis \
    && conda install -c conda-forge scikit-image \
    && conda install -c anaconda scikit-learn \
    && conda install -c conda-forge tensorboard \
    && conda install -c conda-forge protobuf \
    && conda install -c conda-forge seaborn \
    && conda install -c conda-forge jupyter \
    && conda install -c annaconda tensorflow \
    && conda install matplotlib \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    # Configure ssh
    && mkdir /var/run/sshd \
    && echo "root:${PASSWORD}" | chpasswd \
    && sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    # SSH login fix. Otherwise user is kicked off after login
    && sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd \
    && echo "export VISIBLE=now" >> /etc/profile \
    # Configure redis
    && sed -i 's/bind 127.0.0.1 ::1/#bind 127.0.0.1 ::1/g' /etc/redis/redis.conf \
    && sed -i 's/protected-mode yes/protected-mode no/g' /etc/redis/redis.conf \
    # Install coder-server
    && xos=$(uname -s | awk '{ print tolower($1) }') && xarch=$(uname -m | awk '{ print tolower($1) }') \
    && wget https://github.com/cdr/code-server/releases/download/v3.5.0/code-server-3.5.0-${xos}-${xarch}.tar.gz \
    && tar -xvzf code-server-3.5.0-${xos}-${xarch}.tar.gz \
    && rm -rf code-server-3.5.0-${xos}-${xarch}.tar.gz \
    # && chmod u+x code-server-3.5.0-${xos}-${xarch}/code-server \
    && mv code-server-3.5.0-${xos}-${xarch} rcoder \
    && mv rcoder /opt

ENV PATH ${PATH}:/opt/rcoder/bin:/opt/conda/bin

EXPOSE 22 6379 8080 8888

COPY --chown=root:root startup.sh /

CMD ["/startup.sh"]
