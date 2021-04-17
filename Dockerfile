FROM debian:buster-slim

ENV http_proxy="" \
    https_proxy="" \
    token="" \
    token_file="/run/secrets/gh_token" \
    owner="" \
    repo_name="" \
    runner_name=""

WORKDIR /actions-runner

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y ca-certificates curl expect --no-install-recommends && \
    apt-get autoremove -y && \
    rm -rf /var/cache/apt/* && \
    adduser --disabled-password --gecos "" runner

ARG runner_version="2.278.0"
ARG runner_architecture="x64"

RUN curl -OL https://github.com/actions/runner/releases/download/v${runner_version}/actions-runner-linux-${runner_architecture}-${runner_version}.tar.gz && \
    tar xzf ./actions-runner-linux-${runner_architecture}-${runner_version}.tar.gz && \
    rm actions-runner-linux-${runner_architecture}-${runner_version}.tar.gz && \
    ./bin/installdependencies.sh && \
    chown runner: /actions-runner

USER runner

COPY --chown=runner:runner autoconf.sh autoconf.sh
COPY --chown=runner:runner start.sh start.sh

CMD [ "bash", "start.sh" ]
