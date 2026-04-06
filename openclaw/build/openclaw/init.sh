#! /bin/bash

if [ -n "$OPENCLAW_CONFIG" ]; then
  result=$(echo "$OPENCLAW_CONFIG" | jq -s '.[0] * .[1]' ~/.openclaw/openclaw.json -)
  echo "$result" > ~/.openclaw/openclaw.json
fi
unset OPENCLAW_CONFIG

for var in $(env | grep '^OPENCLAW_' | cut -d= -f1); do
    echo "${var#OPENCLAW_}=${!var}" >> ~/.openclaw/.env
done
