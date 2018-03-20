#!/bin/bash
set -euo pipefail

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT="$MYDIR/.."
SCSS_DIR="$ROOT/scss"

HUGO_BINARY="hugo"
FSWATCH_BINARY="fswatch"

# Kill all background processes in the current process group on exit (ctrl+C).
trap 'kill 0' EXIT

# Run hugo in the background. It automatically rebuilds the site on any css changes.
"$HUGO_BINARY" server -s "$ROOT" --quiet & #--disableFastRender

# Simple sound in case of sassc compilation error.
SASSC_FAILED_COMMAND="echo -ne Failed to compile sassc\a\a"  # 2 beeps/bells in case of error.

# Build css.
"$MYDIR/compile_scss.sh"

echo "Monitoring $SCSS_DIR dir for file changes."
"$FSWATCH_BINARY" -0 -r -l 0.1 "$SCSS_DIR" | while IFS= read -r -d '' CHANGED_FILE
do
  # Display relative path instead of absolute one.
  CHANGED_FILE=${CHANGED_FILE#$PWD/}
  echo "Rebuilding from $SCSS_DIR due to changed file: $CHANGED_FILE"
  # Do not stop after sassc returned error, because it can be caused by invalid scss syntax.
  "$MYDIR/compile_scss.sh" || $SASSC_FAILED_COMMAND
done

# Wait for all background processes to complete.
wait
