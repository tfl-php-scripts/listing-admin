#!/bin/sh
set -e

mkdir -p /app/public/images/codes/
chmod -R 777 /app/public/images
mkdir -p /app/public/admin/cache
chmod -R 777 /app/public/admin/cache

exec "$@"
