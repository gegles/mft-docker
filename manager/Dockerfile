FROM ibmcom/mq
# RUN useradd gegles -G mqm && \
#     echo gegles:passw0rd | chpasswd
COPY 30-mft.mqsc /etc/mqm/
ENV MQ_DEV=false
