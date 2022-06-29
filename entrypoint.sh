#!/bin/sh

MONGODB_VERSION=$1
MONGODB_REPLICA_SET=$2
MONGODB_PORT=$3
MONGODB_USERNAME=$4
MONGODB_PWD=$5


echo "Starting MongoDb"
echo "* port [$MONGODB_PORT]"
echo "* version [$MONGODB_VERSION]"
echo "* replica_set [$MONGODB_REPLICA_SET]"
echo "* credentials [$MONGODB_USERNAME:$MONGODB_PWD]"
docker run --name mongodb --publish $MONGODB_PORT:27017 -e MONGO_ROOT_USERNAME=$MONGODB_USERNAME -e MONGO_ROOT_USERNAME=$MONGODB_PWD -e MONGO_REPLICA_SET_NAME=$MONGODB_REPLICA_SET --detach mongocamp/mongodb:$MONGODB_VERSION

echo "Waiting for MongoDB to accept connections"
sleep 1
TIMER=0

until docker exec --tty mongodb mongo --port $MONGODB_PORT --eval "db.serverStatus()" # &> /dev/null
do
  sleep 1
  echo "."
  TIMER=$((TIMER + 1))

  if [[ $TIMER -eq 30 ]]; then
    echo "Did not initialize MongoDb within 30 seconds. Exit."
    exit 2
  fi
done
