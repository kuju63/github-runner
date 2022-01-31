#!/bin/bash

set -e

if [ -z "${runner_name}" ]; then
  echo "RUNNER_NAME must be set" 1>&2
  exit 1
fi

if [ -z "${owner}" ]; then
  echo "OWNER must be set" 1>&2
  exit 1
fi

if [ -z "${repo_name}" ]; then
  echo "Repository name must be set" 1>&2
  exit 1
fi

LABEL=""

if [ -z "${label}" ]; then
  LABEL=""
else
  LABEL="${label}"
fi

if [ -z "${group}" ]; then
  GROUP="Default"
else
  GROUP="${group}"
fi

expect -c "
set timeout 10
spawn ./config.sh --url https://github.com/${owner}/${repo_name} --token ${TOKEN}
expect \"Enter the name of the runner group to add this runner to:\"
send \"${GROUP}\n\"
expect \"Enter the name of runner:\"
send \"${runner_name}\n\"
expect \"Enter any additional labels (ex. label-1,label-2):\"
send \"${LABEL}\n\"
expect \"Enter name of work folder:\"
send \"\n\"
expect \"$\"
exit 0
"
