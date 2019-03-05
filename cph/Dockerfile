FROM ubuntu:latest

ARG MQ_URL=http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/messaging/mqadv/mqadv_dev911_ubuntu_x86-64.tar.gz
ARG MQ_PACKAGES="ibmmq-sdk ibmmq-client"

COPY install-mqdev.sh /usr/local/bin/

# Install MQ.  To avoid a "text file busy" error here, we sleep before installing.
RUN chmod u+x /usr/local/bin/install-mqdev.sh \
  && sleep 1 \
  && echo "export LC_ALL=C" >>/etc/profile

RUN install-mqdev.sh

# Install extra packages
RUN apt-get update -y && \
    apt-get -y upgrade && \
    export LC_ALL=C && \
    apt-get install -y \
        iputils-ping \
        ca-certificates \
        git \
        build-essential
    
# Build/Install mq-cph
RUN git clone https://github.com/ibm-messaging/mq-cph.git /tmp/mq-cph && \
    cd /tmp/mq-cph && \
    export installdir=/root/cph && \
    make

WORKDIR /root/cph
ENTRYPOINT ["/bin/bash"]