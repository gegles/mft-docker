# © Copyright IBM Corporation 2015, 2018
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
FROM ubuntu:latest

RUN export DEBIAN_FRONTEND=noninteractive \
  # Install additional packages required by MQ, this install process and the runtime scripts
  && apt-get update -y \
  && apt-get install -y --no-install-recommends \
    bash \
    bc \
    ca-certificates \
    coreutils \
    curl \
    debianutils \
    file \
    findutils \
    gawk \
    grep \
    libc-bin \
    lsb-release \
    mount \
    passwd \
    procps \
    sed \
    tar \
    util-linux \
    inotify-tools \
    locales \
    s3fs

RUN rm -rf /var/lib/apt/lists/* \
  && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
  && locale-gen

RUN  useradd -ms /bin/bash mftadmin \
  && echo mftadmin:passw0rd | chpasswd

# Extract the MQ installation files
ADD  *-IBM-MQFA-Redist-LinuxX64.tar.gz /opt/mqm/mft/

COPY *.sh /opt/mqm/mft/bin/
ENV PATH="$PATH:/opt/mqm/mft/bin"

COPY --chown=mftadmin MQMFTCredentials.xml /home/mftadmin/
RUN  chmod go-rw /home/mftadmin/MQMFTCredentials.xml

RUN  mkdir -p /var/mqm/mft/mftdata/ \
  && chown mftadmin /var/mqm/mft/mftdata 
ENV BFG_DATA=/var/mqm/mft/mftdata

USER mftadmin
ENV HOME=/home/mftadmin
ENTRYPOINT ["mft_entry_point.sh"]
