#!/bin/bash

set -e

host="$1"
port="$2"

echo "⏳ Waiting for database at $host:$port to be ready..."

until pg_isready -h "$host" -p "$port" > /dev/null 2>&1; do
  sleep 1
done

echo "✅ Database is ready!"
