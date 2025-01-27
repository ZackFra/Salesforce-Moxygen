#!/usr/bin/env bash
sfdx_auth_url=$1
auth_file=$2 || "authFile.json"
echo "{\"sfdxAuthUrl\": \"$sfdx_auth_url\"}" > "$auth_file"