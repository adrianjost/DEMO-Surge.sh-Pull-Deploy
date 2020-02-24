#!/bin/bash

# Deploy Docs & Storybook to surge.sh
# and comment deployed URLs to pull requests

# will be populated to your.subdomain.surge.sh
# you can also set the env variable
SURGE_SUBDOMAIN=${SURGE_SUBDOMAIN:="your.surge.subdomain"}
BUILD_DIR=${BUILD_DIR:="./build_dir/"}

# Only run if it is a pull request
if [ "$TRAVIS_PULL_REQUEST" == "false" ];
then
	echo "Do not deploy to test system. This is not a pull request."
	exit 0;
fi

if [ -z "$SURGE_LOGIN" ] || [ -z "$SURGE_TOKEN" ];
then
	echo "Do not deploy to surge.sh. Missing SURGE_LOGIN or SURGE_TOKEN env variables for deployment."
	exit 0;
fi

npx surge --project ${BUILD_DIR} --domain ${TRAVIS_PULL_REQUEST}.${SURGE_SUBDOMAIN}.surge.sh


if [ -z "$GITHUB_TOKEN" ];
then
	echo "Do not comment back deployed url. Missing GITHUB_TOKEN env variable."
	exit 0;
fi

# and there is not already a comment
if curl -H "Authorization: token ${GITHUB_TOKEN}" -s "https://api.github.com/repos/${TRAVIS_REPO_SLUG}/issues/${TRAVIS_PULL_REQUEST}/comments" | grep "deployed this pull-request for you"
then
	echo "URL Comment already exists. => Skip"
else
	curl -H "Authorization: token ${GITHUB_TOKEN}" -X POST -d "{\"body\": \"❤️ I have deployed this pull-request for you: \nhttp://${TRAVIS_PULL_REQUEST}.${SURGE_SUBDOMAIN}.surge.sh\"}" "https://api.github.com/repos/${TRAVIS_REPO_SLUG}/issues/${TRAVIS_PULL_REQUEST}/comments"
	echo "Commented URLs to github"
fi