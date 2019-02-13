#!/bin/bash
# -*- mode: sh -*-

killall fasp.io-gateway
rm -rf ~/logs/mq
mkdir -p ~/logs/mq
~/mft-docker/gateway/fasp.io-gateway --config ~/mft-docker/gateway/mq/${1:-fasp}/$(hostname)-in.toml &
~/mft-docker/gateway/fasp.io-gateway --config ~/mft-docker/gateway/mq/${1:-fasp}/$(hostname)-out.toml &