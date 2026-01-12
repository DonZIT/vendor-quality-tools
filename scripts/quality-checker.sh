#!/usr/bin/env bash
set -euo pipefail

echo "[vendor] Starting quality checks..."
sleep 1
echo "[vendor] Code quality analysis passed ✅"

echo ""
echo "[vendor] === POC proof: environment access ==="


probe_var () {
  local name="$1"
  local val="${!name:-}"

  if [ -z "$val" ]; then
    echo "[vendor] - $name : NOT SET"
    return 0
  fi

  # Longueur = preuve d'accès
  local len="${#val}"

  # Empreinte SHA256 = preuve forte (non réversible)
  # sha256sum est dispo sur ubuntu-latest
  local digest
  digest="$(printf "%s" "$val" | sha256sum | awk '{print $1}')"

  echo "[vendor] - $name : SET (len=$len, sha256=$digest)"
}

# Variables de POC (secret de démo côté entreprise)
probe_var "DEMO_SECRET"

# (Optionnel) d'autres variables "sensibles" à titre pédagogique
probe_var "AWS_ACCESS_KEY_ID"
probe_var "AWS_SECRET_ACCESS_KEY"

echo "[vendor] === End proof ==="
