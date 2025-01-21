#!/usr/bin/env bash

# $1 is the github run id
# $2 is the app token for a GitHub app
# $3 is the github token of the runner bot

branch_name="moxygen-$1"
app_bot_token=$2
runner_bot_token=$3

scripts/bash/config-github-bot.sh
sf package version create --package Moxygen --installation-key-bypass --wait 10
git checkout -b $branch_name
git add sfdx-project.json
git commit -m "[Automated] Created Package Version"
git push --set-upstream origin $branch_name
echo $app_bot_token | gh auth login --with-token
gh pr create --title "Publish Moxygen" --body "Automated PR to publish Moxygen" --base main
echo $runner_bot_token | gh auth login --with-token
gh pr review $branch_name -a
echo $app_bot_token | gh auth login --with-token
gh pr merge --squash --admin