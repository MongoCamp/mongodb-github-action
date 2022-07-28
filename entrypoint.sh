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
docker run --name mongodb --publish $MONGODB_PORT:27017 -e MONGO_ROOT_USERNAME=$MONGODB_USERNAME -e MONGO_ROOT_PWD=$MONGODB_PWD -e MONGO_REPLICA_SET_NAME=$MONGODB_REPLICA_SET --detach mongocamp/mongodb:$MONGODB_VERSION

MONGO_SHELL_COMMAND="mongosh"
if ! docker exec --tty mongodb /bin/bash -c "command -v $MONGO_SHELL_COMMAND &> /dev/null"
then
    echo "<mongosh> could not be found use mongo"
    MONGO_SHELL_COMMAND=mongo
fi

if [[ ${MONGO_SHELL_COMMAND} != 'mongosh' ]]; then
   MONGO_SHELL_COMMAND="${MONGO_SHELL_COMMAND} --quiet "
fi

echo "Waiting for MongoDB to accept connections"
sleep 1
TIMER=0

until docker exec --tty mongodb /bin/bash -c "$MONGO_SHELL_COMMAND --port 27017 --eval 'true'"
do
  sleep 1
  echo "."
  TIMER=$((TIMER + 1))

  if [[ $TIMER -eq 30 ]]; then
    echo "Did not initialize MongoDb within 30 seconds. Exit."
    exit 2
  fi
done

echo "Start you tests"
