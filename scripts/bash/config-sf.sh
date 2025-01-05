#!/usr/bin/env bash
npm i -g @salesforce/cli
sf org login sfdx-url --sfdx-url-file $1 --set-default-dev-hub --alias DevHub