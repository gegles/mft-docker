FROM ubuntu:latest

ARG MQ_URL=http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/messaging/mqadv/mqadv_dev911_ubuntu_x86-64.tar.gz
ARG MQ_PACKAGES="ibmmq-sdk ibmmq-client"
ARG LC_ALL=C

RUN apt-get update -y && \
    apt-get -y upgrade && \
    export LC_ALL=C && \
    apt-get install -y \
        iputils-ping \
        ca-certificates \
        software-properties-common \
        curl \
        apt-utils \
        wget \ 
        git \
        build-essential

COPY install-mqdev.sh /usr/local/bin/

# Install MQ.  To avoid a "text file busy" error here, we sleep before installing.
RUN chmod u+x /usr/local/bin/install-mqdev.sh \
  && sleep 1 \
  && echo "export LC_ALL=C" >>/etc/profile

RUN install-mqdev.sh

# Build/Install mq-cph
RUN git clone https://github.com/ibm-messaging/mq-cph.git && cd mq-cph
RUN installdir=/root/cph make
ENV PATH="$PATH:/root/cph"

ENTRYPOINT ["/bin/bash"]