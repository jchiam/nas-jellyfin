#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PASS=0

run() {
  local name="$1"; shift
  echo "==> $name"
  if "$@"; then
    echo "    OK"
  else
    echo "    FAILED"
    PASS=1
  fi
  echo
}

run "yamllint (docker-compose.yaml)" \
  docker run --rm -v "$ROOT:/data" cytopia/yamllint docker-compose.yaml

exit $PASS
