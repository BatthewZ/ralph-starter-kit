#!/usr/bin/env bash
set -euo pipefail

# Experimental! Good luck ;D

cleanup() {
  echo "Ctrl+C detected!"
  kill 0 2>/dev/null || true  # kill children
}
trap cleanup SIGINT EXIT

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)"
PARSER="${ROOT_DIR}/.scripts/pretty-log-line.js"
TASK_FOLDER="${ROOT_DIR}/todo/cleanup"

mkdir -p "$TASK_FOLDER"

CLEANUP_PLANNER=$(cat <<EOF
Come up with a plan on how to clean up the codebase. Spawn up to 500 subagents to look for opportunities to refactor, 

fix, edge cases, abstract out duplicate code.  Are the tests skipping anything vital, or written in a way that might mean that we miss important feedback?

Once you have come up with the plan, break it down into new "tasks" that will fit in a single agent context window. Write down the tasks into:

${TASK_FOLDER}/{task-name}.pending.md
EOF
)

# Run agent and pretty-print each line to stdout via node parser
set +e
claude "$CLEANUP_PLANNER" --model opus --print --dangerously-skip-permissions --include-partial-messages --verbose --output-format stream-json | node "${PARSER}"
# agent --model claude-4.5-opus --output-format stream-json --stream-partial-output --sandbox disabled --browser --print --force "$RALPH" \
#   | node "${PARSER}"
status=$?
set -e

if [[ $status -ne 0 ]]; then
echo "WARN: Cleanup failed (exit ${status});"
fi

TASK_COUNT=$(find "$TASK_FOLDER" -type f | wc -l)

echo "Cleanup tasks created. Unleashing Ralph!"

"${ROOT_DIR}/.scripts/ralph.sh" "$TASK_COUNT" "$TASK_FOLDER"