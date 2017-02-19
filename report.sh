#!/bin/bash
counter=0
accounts=`find users -type f -not -name example.json | wc -l`

usage() {
    echo "[#] Usage: ./report.sh [steamID64] (matchID)"
    exit 0
}

if [ -z "$1" ]; then
    usage
fi

node protos/updater.js

for user in `find users -type f -not -name example.json`; do
    command="node report.js $user"

    for id in "$*"; do
       command+=" $id"
    done

    $command

    # Increment and display the counter
    counter=$((counter + 1))
    echo "[INFO] Status : $counter/$accounts"
done
