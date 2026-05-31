#!/usr/bin/env bash

set -e

BASE_DIR="$PWD/.postgresql"
DB_DIR="$BASE_DIR/data"
SOCKET_DIR="$BASE_DIR/socket"
LOG_DIR="$BASE_DIR/logs"

LOG_FILE="$LOG_DIR/postgres.log"

PORT="5433"

init_db() {
  if [ ! -f "$DB_DIR/PG_VERSION" ]; then
    mkdir -p "$DB_DIR" "$SOCKET_DIR" "$LOG_DIR"

    echo "Initializing PostgreSQL..."
    initdb -D "$DB_DIR"
  fi
}

start_db() {
  init_db

  echo "Starting PostgreSQL..."

  pg_ctl \
    -D "$DB_DIR" \
    -l "$LOG_FILE" \
    -o "-k $SOCKET_DIR -p $PORT" \
    start

  echo ""
  echo "PostgreSQL started!"
  echo "Host     : 127.0.0.1"
  echo "Port     : $PORT"
  echo "Username : $(whoami)"
  echo "password : (no password)"
  echo "Database : postgres"
}

stop_db() {
  echo "Stopping PostgreSQL..."

  pg_ctl -D "$DB_DIR" stop
}

restart_db() {
  stop_db || true
  sleep 1
  start_db
}

reset_db() {
  echo "Resetting database..."

  stop_db || true

  rm -rf "$DB_DIR"
  rm -rf "$SOCKET_DIR"
  rm -rf "$LOG_DIR"

  echo "Database reset!"
}

status_db() {
  pg_ctl -D "$DB_DIR" status
}

logs_db() {
  tail -f "$LOG_FILE"
}

case "$1" in
  start)
    start_db
  ;;
  stop)
    stop_db
  ;;
  restart)
    restart_db
  ;;
  reset)
    reset_db
  ;;
  status)
    status_db
  ;;
  logs)
    logs_db
  ;;
  *)
    echo "Usage:"
    echo "  pg_sh start"
    echo "  pg_sh stop"
    echo "  pg_sh restart"
    echo "  pg_sh reset"
    echo "  pg_sh status"
    echo "  pg_sh logs"
    exit 1
  ;;
esac
