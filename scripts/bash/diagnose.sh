#!/usr/bin/env bash
echo y | sf plugins install sfdx-hardis
sf hardis:org:diagnose:instanceupgrade --json