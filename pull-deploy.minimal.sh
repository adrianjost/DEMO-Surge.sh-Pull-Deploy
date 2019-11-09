#!/bin/bash

# deploy to surge.sh
npx surge --project ${BUILD_DIR} --domain ${TRAVIS_PULL_REQUEST}.${SURGE_SUBDOMAIN}.surge.sh

# comment url to pull request
curl -H "Authorization: token ${GITHUB_TOKEN}" -X POST -d "{\"body\": \"❤️ I have deployed this pull-request for you: \nhttp://${TRAVIS_PULL_REQUEST}.${SURGE_SUBDOMAIN}.surge.sh\"}" "https://api.github.com/repos/${TRAVIS_REPO_SLUG}/issues/${TRAVIS_PULL_REQUEST}/comments"