#!/bin/bash

BASE_PORT=11211

# コマンドライン引数から個数を取得（デフォルトは10）
NUM_INSTANCES=${1:-10}

for i in $(seq 0 $((NUM_INSTANCES - 1))); do
  PORT=$((BASE_PORT + i))
  sudo ./memcached -p $PORT -u root &
  echo "Started memcached on port $PORT"
done

wait
