#!/usr/bin/env bash
sfdx_auth_url=$1
echo "{\"sfdxAuthUrl\": \"$sfdx_auth_url\"}" > authFile.json