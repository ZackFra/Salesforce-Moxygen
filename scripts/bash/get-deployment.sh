#!/usr/bin/env bash
scripts/bash/config-aws.sh
scripts/bash/invoke-lambda-func.sh "{\"pullRequestUrl\":\"/$REPOSITORY/pull/$PULL_REQUEST_NUMBER\"}" $AWS_GET_DEPLOYMENT_FUNC
node scripts/js/get-job-id.js "outfile.json"
$QUICK_DEPLOY_ID = $(cat "outfile.json")
echo "Quick Deploy ID: $QUICK_DEPLOY_ID"