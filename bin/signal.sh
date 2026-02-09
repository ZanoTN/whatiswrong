#!/usr/bin/env bash
set -e

SEM=/tmp/signal.sem
FD=9

mkdir -p "$(dirname "$SEM")"
touch "$SEM"

case "$1" in
  lock)
    echo "SIGNAL: Lock"
    exec {FD}>"$SEM"
    flock "$FD"
    ;;

  unlock)
    echo "SIGNAL: Unlock"
    exec {FD}>"$SEM"
    flock -u "$FD"
    ;;

  wait)
    echo "SIGNAL: Waiting for lock to be released..."
    exec {FD}>"$SEM"
    flock "$FD"
    flock -u "$FD"
    echo "SIGNAL: Lock released, proceeding..."
    ;;

  *)
    exit 1
    ;;
esac
