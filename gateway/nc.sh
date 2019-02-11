#!/bin/bash
# -*- mode: sh -*-

killall fasp.io-gateway
rm -rf ~/logs/nc
mkdir -p ~/logs/nc
~/mft-docker/gateway/fasp.io-gateway --config ~/mft-docker/gateway/nc/$1.toml &