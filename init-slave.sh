#!/bin/bash

pg_ctl -D /var/lib/postgresql/data stop -m fast
rm -rf /var/lib/postgresql/data/*
until pg_isready -h pg-master -U postgres; do sleep 1; done
pg_basebackup -h pg-master -D /var/lib/postgresql/data -U postgres -v -P --wal-method=stream
echo "primary_conninfo = 'host=pg-master port=5432 user=${POSTGRES_USER} password=${POSTGRES_PASSWORD}'" >> /var/lib/postgresql/data/postgresql.conf

echo "host all all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf
echo "host replication all all trust" >> /var/lib/postgresql/data/pg_hba.conf



touch /var/lib/postgresql/data/standby.signal
docker-entrypoint.sh postgres