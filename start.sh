#!/bin/bash

set -e

if [[ -z "$PGBIN" ]]; then
    (>&2 echo "Setting PGBIN...")
    export PGBIN=/usr/pgsql/bin
fi

if [[ -z "$PGDATA" ]]; then
    (>&2 echo "Setting PGDATA...")
    export PGDATA=/var/lib/pgsql/11/data
fi

if [ ! -d "${PGDATA}/base" ]; then
    (>&2 echo "Initializing cluster...")
    ${PGBIN}/pg_ctl initdb
fi

(>&2 echo "Copying configuration files...")
cp postgresql.conf pg_hba.conf $PGDATA


if [[ ! -z "$PGPASS" ]]; then 
    ${PGBIN}/pg_ctl start
    (>&2 echo "Setting postgres user password...")
    psql -c "ALTER ROLE postgres WITH LOGIN PASSWORD '${PGPASS}' "
    ${PGBIN}/pg_ctl stop
fi

(>&2 echo "Starting postgres...")
${PGBIN}/postgres -D "${PGDATA}"
