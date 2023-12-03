#!/bin/bash

PGSQLV=15

echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main $PGSQLV" > /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
apt-get update
apt-get -y install postgresql-$PGSQLV

