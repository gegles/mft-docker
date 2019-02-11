# mft-docker

## Build images

```shell
docker build -t mftmgr manager
docker build -t mftagent agent
```

## Run Managers

```shell
docker volume create qm1data
docker volume create qm2data
```

```shell
docker run --env LICENSE=accept --env MQ_QMGR_NAME=QM1 --publish 1515:1414 --publish 9443:9443 --volume qm1data:/mnt/mqm --detach --name=QM1 mftmgr
docker run --env LICENSE=accept --env MQ_QMGR_NAME=QM2 --publish 1515:1414 --publish 9443:9443 --volume qm2data:/mnt/mqm --detach --name=QM2 mftmgr
```

## Setup FTE Coordination

Pick one manager

```shell
docker exec -ti QM1 setup_fte_coordination.sh
```
## Create agents on the managers

```shell
docker exec -ti QM1  setup_fte_agent.sh A1
docker exec -ti QM2  setup_fte_agent.sh A2
```

## Create cluster (via MQ explorer for now)

## Run FTE Agents

```shell
docker run --env MQ_COOR_QMGR_NAME=QM1 --env MQ_COOR_QMGR_HOST=rapid7.aspera.us --env MQ_COOR_QMGR_PORT=1515 --env MQ_QMGR_NAME=QM1 --env MQ_QMGR_HOST=172.17.0.2 --env MQ_QMGR_PORT=1414 --env MQ_QMGR_CHL=MFT.SVRCONN --env MFT_AGENT_NAME=A1 -d --name=A1 mftagent

docker run --env MQ_COOR_QMGR_NAME=QM1 --env MQ_COOR_QMGR_HOST=rapid7.aspera.us --env MQ_COOR_QMGR_PORT=1515 --env MQ_QMGR_NAME=QM2 --env MQ_QMGR_HOST=172.17.0.2 --env MQ_QMGR_PORT=1414 --env MQ_QMGR_CHL=MFT.SVRCONN --env MFT_AGENT_NAME=A2 -d --name=A2 mftagent


docker run --volume ~/volumes/A1:/mnt/A1 --env MQ_COOR_QMGR_NAME=QM1  --env MQ_COOR_QMGR_HOST=172.17.0.2 --env MQ_COOR_QMGR_PORT=1414 --env MQ_QMGR_NAME=QM1  --env MQ_QMGR_HOST=172.17.0.2 --env MQ_QMGR_PORT=1414 --env MQ_QMGR_CHL=MFT.SVRCONN --env MFT_AGENT_NAME=A1 -d --name=A1 mftagent

docker run --volume ~/volumes/A2:/mnt/A2 --env MQ_COOR_QMGR_NAME=QM1  --env MQ_COOR_QMGR_HOST=172.17.0.1 --env MQ_COOR_QMGR_PORT=1414 --env MQ_QMGR_NAME=QM2  --env MQ_QMGR_HOST=172.17.0.2 --env MQ_QMGR_PORT=1414 --env MQ_QMGR_CHL=MFT.SVRCONN --env MFT_AGENT_NAME=A2 -d --name=A2 mftagent

```

## Generate large file

On the A1 host:
```shell
dd if=/dev/zero iflag=count_bytes count=1G bs=1M of=/tmp/1GB
```

## Transfer a file
```shell
docker exec -ti A1 fteCreateTransfer -p QM1 -sa A1 -sm QM1 -da A2 -dm QM2 -df /tmp/1GB /tmp/1GB
```

