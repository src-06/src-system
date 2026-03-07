#!/usr/bin/env bash
set -e

ENGINE="$1"
CMD="$2"

BASE_DIR="$PWD"
MARIADB_DIR="$BASE_DIR/.mariadb"
POSTGRES_DIR="$BASE_DIR/.postgres"

# ----------------------------
# MariaDB Section
# ----------------------------
mariadb_up() {
  DATA_DIR="$MARIADB_DIR/data"
  SOCKET="$MARIADB_DIR/mysql.sock"
  PID_FILE="$MARIADB_DIR/mysql.pid"
  LOG_FILE="$MARIADB_DIR/mysql.log"

  mkdir -p "$MARIADB_DIR"

  if [ ! -d "$DATA_DIR/mysql" ]; then
    echo "Init MariaDB..."
    mariadb-install-db \
      --datadir="$DATA_DIR" \
      --auth-root-authentication-method=normal \
      > /dev/null
  fi

  echo "Starting MariaDB..."
  mariadbd \
    --datadir="$DATA_DIR" \
    --socket="$SOCKET" \
    --port=3306 \
    --bind-address=127.0.0.1 \
    --pid-file="$PID_FILE" \
    --log-error="$LOG_FILE" &

  echo "Waiting for MariaDB..."
  for _ in $(seq 1 30); do
    if mariadb-admin --socket="$SOCKET" ping &>/dev/null; then
      break
    fi
    sleep 1
  done

  mariadb --socket="$SOCKET" -u root \
    -e "CREATE DATABASE IF NOT EXISTS mariadb;"

  echo ""
  echo "========================================"
  echo "  Engine: MariaDB"
  echo "  Host: 127.0.0.1"
  echo "  Port: 3306"
  echo "  User: root"
  echo "  Password: (no password)"
  echo "  Database: mariadb"
  echo "========================================"
}

mariadb_down() {
  PID_FILE="$MARIADB_DIR/mysql.pid"
  echo "Stopping MariaDB..."
  [ -f "$PID_FILE" ] && kill "$(cat "$PID_FILE")" || true
}

mariadb_status() {
  PID_FILE="$MARIADB_DIR/mysql.pid"
  [ -f "$PID_FILE" ] && echo "MariaDB running" || echo "MariaDB stopped"
}

# ----------------------------
# PostgreSQL Section
# ----------------------------
postgres_up() {
  DATA_DIR="$POSTGRES_DIR/data"
  SOCKET_DIR="$POSTGRES_DIR/socket"
  LOG_FILE="$POSTGRES_DIR/postgres.log"

  export PGHOST="$SOCKET_DIR"
  export PGPORT=5432

  mkdir -p "$SOCKET_DIR"

  if [ ! -d "$DATA_DIR" ]; then
    echo "Init PostgreSQL..."
    initdb -D "$DATA_DIR" > /dev/null
  fi

  echo "Starting PostgreSQL..."
  pg_ctl -D "$DATA_DIR" \
    -o "-k $SOCKET_DIR -p $PGPORT" \
    -l "$LOG_FILE" start

  echo ""
  echo "========================================"
  echo "  Engine: PostgreSQL"
  echo "  Host: 127.0.0.1"
  echo "  Port: 5432"
  echo "  User: $USER"
  echo "  Password: (no password)"
  echo "  Database: postgres"
  echo "========================================"
}

postgres_down() {
  DATA_DIR="$POSTGRES_DIR/data"
  echo "Stopping PostgreSQL..."
  pg_ctl -D "$DATA_DIR" stop || true
}

postgres_status() {
  DATA_DIR="$POSTGRES_DIR/data"
  pg_ctl -D "$DATA_DIR" status || true
}

# ----------------------------
# Router
# ----------------------------
case "$ENGINE" in
  mariadb)
    case "$CMD" in
      up) mariadb_up ;;
      down) mariadb_down ;;
      status) mariadb_status ;;
      *) echo "Usage: db mariadb {up|down|status}" ;;
    esac
  ;;

  postgresql)
    case "$CMD" in
      up) postgres_up ;;
      down) postgres_down ;;
      status) postgres_status ;;
      *) echo "Usage: db postgresql {up|down|status}" ;;
    esac
  ;;

  *)
    echo "Usage: db {mariadb|postgresql} {up|down|status}"
    exit 1
  ;;
esac
