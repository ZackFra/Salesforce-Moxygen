#!/usr/bin/env bash
scripts/bash/invoke-lambda-func.sh "{\"pullRequestUrl\":\"/$REPOSITORY/pull/$PULL_REQUEST_NUMBER\"}" $AWS_GET_DEPLOYMENT_FUNC > found-deployment.json
cat found-deployment.json