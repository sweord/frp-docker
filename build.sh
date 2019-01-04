#!/usr/bin/env bash

latest_release_version() {
  curl --silent "https://api.github.com/repos/fatedier/frp/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/' |
    sed -E 's/^v//'
}

frp_version=$(latest_release_version)

docker build \
  --tag "sweord/frp:$frp_version" \
  --tag "sweord/frp:latest" \
  --build-arg frp_version="$frp_version" \
  --compress \
  .

tee <<EOF
=========================
docker push sweord/frp
=========================
EOF
