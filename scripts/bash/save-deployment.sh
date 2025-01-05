#!/usr/bin/env bash
scripts/bash/config-aws.sh
node scripts/js/format-deployment-data.js "validate.json"
scripts/bash/invoke-lambda-func.sh "file://deployment-request.json" $AWS_SAVE_DEPLOYMENT_FUNC