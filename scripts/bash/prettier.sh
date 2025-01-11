#!/usr/bin/env bash
prettier --plugin=prettier-plugin-apex --write $(git diff --name-only --diff-filter d | grep -E '[.](cls|apex|trigger)$')