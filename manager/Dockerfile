FROM ibmcom/mq
RUN useradd gegles -G mqm && \
    echo gegles:passw0rd | chpasswd
COPY config.mqsc /etc/mqm/
