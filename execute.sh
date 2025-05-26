#!/bin/bash

BASE_PORT=11211

# コマンドライン引数から個数を取得（デフォルトは10）
NUM_INSTANCES=${1:-10}
# memcached の最大キャッシュ容量．これを超えると，evict されるためどれだけ load しても無駄になる．
MAX_BYTES=524288

for i in $(seq 0 $((NUM_INSTANCES - 1))); do
  PORT=$((BASE_PORT + i))
  sudo ./memcached -m $MAX_BYTES -p $PORT -u root &
  echo "Started memcached on port $PORT"
done

wait
