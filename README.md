# Pull Request Deployment Demo (using surge.sh)

Read the full article on Medium: https://medium.com/p/394c3977b600

## Setup this Demo

1. Fork the Repo
1. Enable Travis fot this repo
1. enable travis pull request runs for this repo
1. set the required (secret) env variables in travis
    - `SURGE_LOGIN` (secret)
    - `SURGE_TOKEN` (secret)
    - `GITHUB_TOKEN` (secret)
    - `SURGE_SUBDOMAIN`
    - `BUILD_DIR`
1. Open any pull request on your repo and wait for the deployment url to be commented 😊
