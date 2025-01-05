#!/usr/bin/env bash
scripts/bash/config-aws.sh
scripts/bash/invoke-lambda-func.sh "{\"pullRequestUrl\":\"/$REPOSITORY/pull/$PULL_REQUEST_NUMBER\"}" $AWS_GET_DEPLOYMENT_FUNC
cat outfile.json
node scripts/js/get-job-id.js "outfile.json"
echo "quick-deploy-id=$(cat job-id.txt)" >> "$GITHUB_OUTPUT"