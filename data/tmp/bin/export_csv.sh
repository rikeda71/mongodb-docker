#!/bin/bash
COLLECTION=$1
keys=`mongo -u user -p pass mongo --authenticationDatabase admin --eval "rs.secondaryOk();var keys = []; for(var key in db.${COLLECTION}.findOne()) { keys.push(key); }; keys;" --quiet`
keys=`echo "${keys}" | sed 's/\[//' | sed 's/\"//g'  | sed 's/\]//'`
keys=`echo $keys | sed 's/ //g'`
mongoexport --db mongo --username user --password pass --authenticationDatabase admin --collection=$COLLECTION --fields="$keys" --type=csv --out=/home/export.csv
