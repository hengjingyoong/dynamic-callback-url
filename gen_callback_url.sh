#!/usr/bin/env bash

PUBLIC_URL="$(curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels' | jq '.[] | select(.proto=="https")' | jq -r '.public_url')"
CALLBACK_URL="${PUBLIC_URL}/callback/"

echo ""
echo "Callback URL:"
echo -e "\e[32m${CALLBACK_URL}\e[0m"
echo ""