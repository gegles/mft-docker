FROM ibmcom/mq

RUN useradd mftadmin -G mqm && \
    echo mftadmin:passw0rd | chpasswd

COPY *.mqsc /etc/mqm/
COPY mft /etc/mqm/mft
COPY *.sh /usr/local/bin/

ENV MQ_DEV=false
