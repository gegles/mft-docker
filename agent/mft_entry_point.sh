#!/bin/bash
# -*- mode: sh -*-
# © Copyright IBM Corporation 2015, 2017
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

#set -e
echo "Who am I: $(whoami)"

echo "Setting up FTE Environment for this Agent"
source /opt/mqm/mft/bin/fteCreateEnvironment -d /var/mqm/mft/mftdata
echo "Return code:$?"
# Assumption is that a single queue manager will be used as Coorindation/Command/Agent.
# User should have passed us the queue manager details as environment variables. 

echo "Setting up Coordination manager for this agent"
fteSetupCoordination -coordinationQMgr ${MQ_COOR_QMGR_NAME} -coordinationQMgrHost ${MQ_COOR_QMGR_HOST} -coordinationQMgrPort ${MQ_COOR_QMGR_PORT} -coordinationQMgrChannel ${MQ_QMGR_CHL} -f
echo "Coordination manager setup completed"

echo "Setting up Command manager for this agent"
fteSetupCommands -p ${MQ_COOR_QMGR_NAME} -connectionQMgr  ${MQ_QMGR_NAME} -connectionQMgrHost ${MQ_QMGR_HOST} -connectionQMgrPort  ${MQ_QMGR_PORT} -connectionQMgrChannel ${MQ_QMGR_CHL} -f
echo "Command manager setup completed"

echo "Creating MFT Agent"
fteCreateAgent -p ${MQ_COOR_QMGR_NAME} -agentName ${MFT_AGENT_NAME} -agentQMgr ${MQ_QMGR_NAME} -agentQMgrHost ${MQ_QMGR_HOST} -agentQMgrPort ${MQ_QMGR_PORT} -agentQMgrChannel ${MQ_QMGR_CHL} -f
#fteCreateAgent -agentName ${MFT_AGENT_NAME} -agentQMgr ${MQ_QMGR_NAME} -agentQMgrHost ${MQ_QMGR_HOST} -agentQMgrPort ${MQ_QMGR_PORT} -agentQMgrChannel ${MQ_QMGR_CHL} -mquserid mftadmin -mqpassword passw0rd -f
#fteCreateAgent -agentName ${MFT_AGENT_NAME} -agentQMgr ${MQ_QMGR_NAME} -agentQMgrHost ${MQ_QMGR_HOST} -agentQMgrPort ${MQ_QMGR_PORT} -agentQMgrChannel ${MQ_QMGR_CHL} -agentQMgrAuthenticationCredentialsFile /home/mftadmin/MQMFTCredentials.xml -f
echo "Agent creation was successful"

#echo "Starting MFT Agent...."
fteStartAgent -p ${MQ_COOR_QMGR_NAME} ${MFT_AGENT_NAME}
echo "MFT Agent Started"

fteListAgents -p ${MQ_COOR_QMGR_NAME}

# Monitor a particular directory to upload files to dropbox.
mft_monitor_agent.sh
