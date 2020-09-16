FROM balenalib/raspberrypi4-64:latest

LABEL maintainer="scinter <byuegv@gmail.com>"

ARG PASSWORD="123456"
ENV NOTVISIBLE "in users profile"

RUN apt-get update \
    && apt-get install -y iproute2 net-tools vim curl wget redis-server openssh-server htop git \
    # Pytorch on raspberrypi 4
    && apt-get install -y gcc python3-dev v4l-utils python3-opencv python3-pip python3-setuptools libffi-dev libssl-dev \
    && wget https://mathinf.com/pytorch/arm64/torch-1.6.0a0+b31f58d-cp37-cp37m-linux_aarch64.whl \
    && wget https://mathinf.com/pytorch/arm64/torchvision-0.7.0a0+78ed10c-cp37-cp37m-linux_aarch64.whl \
    && apt-get install -y python3-numpy python3-wheel python3-setuptools python3-future python3-yaml python3-six python3-requests python3-pip python3-pillow ipython3 \
    && pip3 install torch*.whl torchvision*.whl \
    && rm -rf ./torch*.whl \
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
    && sed -i 's/protected-mode yes/protected-mode no/g' /etc/redis/redis.conf

EXPOSE 22 6379

COPY --chown=root:root startup.sh /

CMD ["/startup.sh"]
