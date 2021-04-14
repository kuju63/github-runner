# github-runner

github-runner is self hosted runner for GitHub. This is working on container.

## How to use

```bash
docker run -d --rm --name runner -e token="Your runner token" -e owner="repository owner" -e repo_name="repository name" -e runner_name="Runner name" github-runner:latest
```

If need to set proxy settings, set environment variables of proxy. See [GitHub Docs](https://docs.github.com/ja/actions/hosting-your-own-runners/using-a-proxy-server-with-self-hosted-runners).

## Setting

### http_proxy / https_proxy

**Optional** This settings are proxy setting.
Set your proxy server url.

ex.

```bash
http://<user>:<password>@hostname:port-number
```

### runner_name

**Requirement** This is to set runner name.

### token

**Optional** This is to set self hosted runner token.
This token is generated by github.

**Warning** Token can't use when restart container, because it is expired.

### owner

**Requirement** This is to set runner owner, for example organization name or user name.

### repo_name

**Requirement** This is to set repository name. This image is not supported organization runner.
