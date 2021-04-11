#!/bin/bash

if [ -z "${token}"  ]; then
  if [ -z "${token_file}" ]; then
    echo "token must be set" 1>&2
    exit 1
  elif [ ! -f "${token_file}" ]; then
    echo "Token file does not found" 1>&2
    exit 1
  else
    export TOKEN=$(cat $token_file)
  fi
else
  export TOKEN="${token}"
fi

if [ ! -f "./.credentials" ]; then
    bash ./autoconf.sh
fi

shutdown_handler() {
    echo "Start shutdown process"
    ./config.sh remove --token $TOKEN
}

./run.sh &
pid="$!"
trap "shutdown_handler $pid" SIGTERM
while kill -0 $pid > /dev/null 2>&1; do
    wait
done
