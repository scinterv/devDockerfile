FROM ubuntu:18.04

LABEL maintainer="scinterv <scinterv@gmail.com>"

ARG PASSWORD="123456"
ENV NOTVISIBLE "in users profile"

 RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && apt-get update \
# RUN apt-get update \
    # Install packages
    && apt-get install -y curl wget vim openssh-server git htop \
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
    # Install coder-server
    && xos=$(uname -s | awk '{ print tolower($1) }') && xarch=$(uname -m | awk '{ print tolower($1) }') \
    && wget https://github.com/cdr/code-server/releases/download/v3.5.0/code-server-3.5.0-${xos}-${xarch}.tar.gz \
    && tar -xvzf code-server-3.5.0-${xos}-${xarch}.tar.gz \
    && rm -rf code-server-3.5.0-${xos}-${xarch}.tar.gz \
    # && chmod u+x code-server-3.5.0-${xos}-${xarch}/code-server \
    && mv code-server-3.5.0-${xos}-${xarch} rcoder \
    && mv rcoder /opt

ENV PATH ${PATH}:/opt/rcoder/bin

EXPOSE 22 8080

WORKDIR /workspace

COPY --chown=root:root startup.sh /

CMD ["/startup.sh"]

