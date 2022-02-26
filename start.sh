#!/bin/bash

export TOKEN="${token}"

if [ -z "${token}"  ]; then
  if [ -z "${token_file}" ]; then
    echo "token must be set" 1>&2
    exit 1
  elif [ ! -f "${token_file}" ]; then
    echo "Token file does not found" 1>&2
    exit 1
  else
    secret_token="$(cat "$token_file")"
    export TOKEN="$secret_token"
  fi
fi

if [ -z "${tls_no_verify}" ]; then
  export GITHUB_ACTIONS_RUNNER_TLS_NO_VERIFY=0
elif [ "$tls_no_verify" = "1" ]; then
echo "Disabled TLS verify check"
  export GITHUB_ACTIONS_RUNNER_TLS_NO_VERIFY=1
fi

if [ ! -f "./.credentials" ]; then
    bash ./autoconf.sh
fi

shutdown_handler() {
    echo "Start shutdown process"
    ./config.sh remove --token "$TOKEN"
}

./run.sh &
pid="$!"
trap '"shutdown_handler $pid"' SIGTERM
while kill -0 $pid > /dev/null 2>&1; do
    wait
done
