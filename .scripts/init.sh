#!/usr/bin/env bash
set -euo pipefail

cleanup() {
  echo "Ctrl+C detected! Performing cleanup..."
  exit 1
}
trap cleanup SIGINT

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)"

empty_dirs=(
  "${ROOT_DIR}/example-structure"
  "${ROOT_DIR}/plans"
  "${ROOT_DIR}/src/util"
  "${ROOT_DIR}/todo/next"
)

for dir in "${empty_dirs[@]}"; do
  mkdir -p "${dir}"
done

echo "Folders generated!"