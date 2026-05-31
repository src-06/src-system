#!/usr/bin/env bash

set -e

BASE_DIR="$PWD/.mariadb"
DB_DIR="$BASE_DIR/data"
RUN_DIR="$BASE_DIR/run"
LOG_DIR="$BASE_DIR/logs"

SOCKET="$RUN_DIR/mysql.sock"
PID_FILE="$RUN_DIR/mysql.pid"
LOG_FILE="$LOG_DIR/mariadb.log"

PORT="3307"

init_db() {
  if [ ! -d "$DB_DIR/mysql" ]; then
    mkdir -p "$DB_DIR" "$RUN_DIR" "$LOG_DIR"

    MYSQL_BASEDIR="$(dirname "$(dirname "$(readlink -f "$(which mariadb-install-db)")")")"

    echo "Initializing MariaDB..."
    mariadb-install-db \
      --basedir="$MYSQL_BASEDIR" \
      --datadir="$DB_DIR" \
      --auth-root-authentication-method=normal \
      &>/dev/null
  fi
}

wait_for_db() {
  echo "Waiting for MariaDB..."

  local retries=30

  until mariadb-admin --socket="$SOCKET" ping &>/dev/null || [ "$retries" -eq 0 ]; do
    sleep 1
    retries=$((retries - 1))
  done

  [ "$retries" -eq 0 ] && {
    echo "MariaDB failed to start!"
    exit 1
  }

  echo "MariaDB is ready!"
}

start_db() {
  init_db

  echo "Starting MariaDB..."

  mariadbd \
    --datadir="$DB_DIR" \
    --socket="$SOCKET" \
    --pid-file="$PID_FILE" \
    --log-error="$LOG_FILE" \
    --port="$PORT" \
    --skip-networking=0 \
    --bind-address=127.0.0.1 &

  wait_for_db

  echo ""
  echo "MariaDB started!"
  echo "Host     : 127.0.0.1"
  echo "Port     : $PORT"
  echo "Username : root"
  echo "password : (no password)"
  echo "Database : test"
}

stop_db() {
  echo "Stopping MariaDB..."

  if [ -f "$PID_FILE" ]; then
    kill "$(cat "$PID_FILE")"
    rm -f "$PID_FILE"
  fi

  echo "Stopped!"
}

restart_db() {
  stop_db || true
  sleep 1
  start_db
}

reset_db() {
  echo "Resetting MariaDB..."

  stop_db || true

  rm -rf "$DB_DIR"
  rm -rf "$RUN_DIR"
  rm -rf "$LOG_DIR"

  echo "Database reset!"
}

status_db() {
  if [ -f "$PID_FILE" ]; then
    echo "MariaDB running with PID $(cat "$PID_FILE")"
  else
    echo "MariaDB not running"
  fi
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
    echo "  mariadb-sh start"
    echo "  mariadb-sh stop"
    echo "  mariadb-sh restart"
    echo "  mariadb-sh reset"
    echo "  mariadb-sh status"
    echo "  mariadb-sh logs"
    exit 1
  ;;
esac
