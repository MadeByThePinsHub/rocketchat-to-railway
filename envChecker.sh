#!/bin/env bash

echo "============================================="
echo "Your configurations are the following:"
echo "MongoDB Main: ${MONGO_URL}"
echo "MongoDB Oplogs/ReplicaSets: ${MONGO_OPLOG_DB}"
echo "Root URL: ${ROOT_URL}"
echo "============================================="

export MONGO_OPLOG_URL=$MONGO_OPLOG_DB
export MONGO_URL="$MONGO_URL/?replicaSet=rs01"
echo "Final DB URL ${MONGO_URL} with OpLogs URL ${MONGO_OPLOG_URL}"
