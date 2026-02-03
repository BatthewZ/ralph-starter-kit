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
Read plans/guides/creating-tasks.md. Come up with a plan on how to clean up the codebase. Spawn up to 100 subagents to look for opportunities to refactor, fix, edge cases, abstract out duplicate code, but do not implement changes.  

Are the tests skipping anything vital, or written in a way that might mean that we miss important feedback? Are there any unfinished integrations? Think hard. Be rigorous. Check the tests against the relevant source code.

We want the code to be accurate and maintainable. Clean, but never sacrifice accuracy for simplicity.

Once you have come up with the plan, break it down into new tasks that will fit in a single agent context window. Write down the tasks into:

${TASK_FOLDER}/{feature-name}/{task-name}.pending.md
EOF
)

# Run agent and pretty-print each line to stdout via node parser
set +e
claude "$CLEANUP_PLANNER" --model opus --print --dangerously-skip-permissions --include-partial-messages --verbose --output-format stream-json | node "${PARSER}"

status=$?
set -e

if [[ $status -ne 0 ]]; then
echo "WARN: Cleanup failed (exit ${status});"
fi

TASK_COUNT=$(find "$TASK_FOLDER" -type f | wc -l)

echo "Cleanup tasks created. Unleashing Ralph!"

"${ROOT_DIR}/.scripts/ralph.sh" 20 "$TASK_FOLDER"