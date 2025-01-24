#!/usr/bin/env bash

branch_name="apexdocs-$1"
app_bot_token="$2"
runner_bot_token="$3"

scripts/bash/config-github-bot.sh

npm i -g @cparra/apexdocs
git checkout -b $branch_name
rm ./docs -rf
apexdocs markdown
git add ./docs
# if there are any changes in the docs folder, commit and push
if [[ `git status --porcelain` ]]; then
    git commit -m "[Automated] Generate Apex Docs"
    git push --set-upstream origin $branch_name

    echo $app_bot_token | gh auth login --with-token
    gh pr create --title "Generate Apex Docs" --body "Automated PR to update Apex Docs" --base main

    echo $runner_bot_token | gh auth login --with-token
    gh pr review $branch_name -a

    echo $app_bot_token | gh auth login --with-token
    gh pr merge --squash --admin
else
  echo "No changes in docs, exiting..."
  exit 0
fi