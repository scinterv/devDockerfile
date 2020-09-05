FROM ubuntu:18.04

LABEL maintainer="scinterv <scinterv@gmail.com>"

ARG PASSWORD="123456"
ENV NOTVISIBLE "in users profile"

# RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
RUN apt-get update \
    # Install packages
    && apt-get install -y curl wget vim openssh-server git \
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
    && echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
