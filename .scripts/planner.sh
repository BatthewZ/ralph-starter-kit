#!/usr/bin/env bash
set -euo pipefail

# Like scripts/convert.sh, but pretty-prints the agent's stream-json output line-by-line.
# NOTE: We do NOT edit scripts/convert.sh (workspace rule).

cleanup() {
  echo "Ctrl+C detected! Performing cleanup..."
  exit 1
}
trap cleanup SIGINT

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)"
PARSER="${ROOT_DIR}/.scripts/pretty-log-line.js"
ITERATIONS="${1:-5}"

RALPH=$(cat <<'EOF'
Refer to .plans/plan.md for the overall plan of the project.

Your job is to come up with a new feature, for after all the existing /todo tasks are completed.

Break down the feature into smaller, more manageable "tasks" that will likely fit in a single agent context window.

Include concise quality assurance considerations where appropriate.

Write the broken down tasks to /todo/{feature-name}/{task-name}.pending.md

Exit immediately once you have written the tasks.
EOF
)

for i in $(seq 1 "${ITERATIONS}"); do
  # Run agent and pretty-print each line to stdout via node parser
  # Important: don't let a failing agent/node invocation kill the whole loop.
  set +e
  claude "$RALPH" --model opus --print --dangerously-skip-permissions --include-partial-messages --verbose --output-format stream-json | node "${PARSER}"
  # agent --model gpt-5.2-codex --output-format stream-json --stream-partial-output --sandbox disabled --browser --print --force "$RALPH" \
  #   | node "${PARSER}"
  status=$?
  set -e

  if [[ $status -ne 0 ]]; then
    echo "WARN: iteration ${i} failed (exit ${status}); continuing..."
  fi
done