#!/bin/bash
set -e

PGDATA=/opt/local/pgsql/11/data/

mkdir -p ${PGDATA}
chown -R postgres:postgres ${PGDATA}
chmod -R go-rwx ${PGDATA}
