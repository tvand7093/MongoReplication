#!/bin/bash
set -x
MONGO_LOG="/var/log/mongodb/mongod.log"
MONGO="/usr/bin/mongo"
MONGOD="/usr/bin/mongod"
$MONGOD --fork --replSet $REPL_SET --smallfiles --logpath $MONGO_LOG
 
checkSlaveStatus(){

	SECONDARY=$1
	$MONGO --host $SECONDARY --eval db
	while [ "$?" -ne 0 ]
	do
		echo "Waiting for secondary node to come up..."
		sleep 15
		$MONGO --host $SECONDARY --eval db
	done
}
 
if [ "$ROLE" == "primary" ]
then
	$MONGO --eval "rs.initiate()"
	checkSlaveStatus $SECONDARY1
	$MONGO --eval "rs.add(\"${SECONDARY1}:27017\")"
	checkSlaveStatus $ARBITER
	$MONGO --eval "rs.add(\"${ARBITER}:27017\", true)"
fi
tailf /dev/null
