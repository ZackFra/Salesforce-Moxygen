#!/usr/bin/env bash
npm i -g aws-cdk
aws configure set aws_access_key_id $1
aws configure set aws_secret_access_key $2
aws configure set default.region $3 
aws configure set default.output json