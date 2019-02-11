#!/bin/bash
# -*- mode: sh -*-

killall fasp.io-gateway
rm -rf ~/logs/mq
mkdir -p ~/logs/mq
~/mft-docker/gateway/fasp.io-gateway --config ~/mft-docker/gateway/mc/$1-in.toml &
~/mft-docker/gateway/fasp.io-gateway --config ~/mft-docker/gateway/mc/$2-in.toml &