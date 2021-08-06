#!/usr/bin/with-contenv sh
set -euo pipefail

config_dir="/etc/cloudflared"
mkdir -p "$config_dir"

jo \
  AccountTag=$ACCOUNT_TAG \
  TunnelSecret=$TUNNEL_SECRET \
  TunnelID=$TUNNEL_ID \
  TunnelName="$TUNNEL_NAME" \
  > "$config_dir/$TUNNEL_ID.json"

cat $config_dir/$TUNNEL_ID.json 
