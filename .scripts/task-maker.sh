#!/usr/bin/env bash
set -euo pipefail

# Used for creating new tasks.

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)"
PARSER="${ROOT_DIR}/.scripts/pretty-log-line.js"


if [[ -z "${1:-}" ]]; then
  echo "Usage: tasks.sh \"plan description\""
  exit 1
fi

INPUT=$1

PLAN=$(cat <<EOF
Read plans/guides/creating-tasks.md. 

${INPUT}

Come up with a plan for this.

Break the plan down into smaller tasks, small enough for agent context windows. 

Put the tasks in todo/{feature-name}/{task-name}.pending.md
EOF
) 

set +e
claude "$PLAN" --model opus --print --dangerously-skip-permissions --include-partial-messages --verbose --output-format stream-json | node "${PARSER}"
status=$?
set -e

if [[ $status -ne 0 ]]; then
echo "WARN: Task generation failed (exit ${status});"
fi