#!/bin/bash
docker-entrypoint.sh postgres &
pid=$!
sleep 10
kill -INT $pid

wait $pid
echo "host replication all all trust" >> /var/lib/postgresql/data/pg_hba.conf
echo "host all all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf
echo "wal_level = replica" >> /var/lib/postgresql/data/postgresql.conf
docker-entrypoint.sh postgres

pid=$!
