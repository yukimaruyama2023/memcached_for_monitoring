##!/bin/bash
#
#BASE_PORT=11211
#
## コマンドライン引数から個数を取得（デフォルトは10）
#NUM_INSTANCES=${1:-10}
## memcached の最大キャッシュ容量．これを超えると，evict されるためどれだけ load しても無駄になる．
#MAX_BYTES=524288
#
#for i in $(seq 0 $((NUM_INSTANCES - 1))); do
#  PORT=$((BASE_PORT + i))
#  # 4 or 5 は，47 thread / 10 instance
#  sudo ./memcached -m $MAX_BYTES -t $(nproc) -p $PORT -u root &
#  echo "Started memcached on port $PORT"
#done
#
#wait

#!/bin/bash

BASE_PORT=11211
NUM_INSTANCES=${1:-10}
MAX_BYTES=524288

for i in $(seq 0 $((NUM_INSTANCES - 1))); do
  PORT=$((BASE_PORT + i))
  sudo numactl --membind=0 taskset -c 0 ./memcached -m $MAX_BYTES -t 1 -p $PORT -u root &
  echo "Started memcached on port $PORT on CPU core 0 and NUMA node 0"
done

wait
