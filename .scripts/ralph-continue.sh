#!/usr/bin/env bash
set -euo pipefail

# Used when tasks are interrupted (ie OS sleeps, token limit reached etc)

cleanup() {
  echo "Ctrl+C detected! Performing cleanup..."
  exit 1
}
trap cleanup SIGINT

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)"
PARSER="${ROOT_DIR}/.scripts/pretty-log-line.js"
ITERATIONS="${1:-20}"
TODO_FOLDER="${2:-todo\/.*$}"

RALPH=$(cat <<EOF
Look under the ${TODO_FOLDER} folders for a file suffixed with ".processing.md" - and claim it as a task by renaming it to ".continuing.md"

If you can't find the folder, say "Can't find folder!" and exit immediately.

Then read the file and execute the task to completion, testing when done. Check the git diff to see which relevant files may have already been started or interrupted for the task.

When done, rename the file to ".completed.md" and add a note about what you did.

If you can't complete the task, rename the file to ".pending.md" and add a note about what went wrong to the file.

When you're done, git commit and push your changes to the remote repository.

If there are no continuing tasks, say "No continuing tasks found." and exit immediately!
EOF
)

for i in $(seq 1 "${ITERATIONS}"); do
  # Run agent and pretty-print each line to stdout via node parser
  # Important: don't let a failing agent/node invocation kill the whole loop.
  set +e
  claude "$RALPH" --model opus --print --dangerously-skip-permissions --include-partial-messages --verbose --output-format stream-json | node "${PARSER}"
  # agent --model claude-4.5-opus --output-format stream-json --stream-partial-output --sandbox disabled --browser --print --force "$RALPH" \
  #   | node "${PARSER}"
  status=$?
  set -e

  if [[ $status -ne 0 ]]; then
    echo "WARN: iteration ${i} failed (exit ${status}); continuing..."
  fi
done