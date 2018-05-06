#!/bin/bash
set -euo pipefail

# Project root directory without slash at the end.
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."
# sassc input.
SASSC_INPUT_SCSS="$ROOT/scss/style.scss"
# sassc output
SASSC_OUTPUT_CSS="$ROOT/static/css/style.css"

if [ `which sass` ]; then SASS=sass
elif [ `which sassc` ]; then SASS=sassc
else echo "Sass is not installed" && exit 1
fi

$SASS --style nested "$SASSC_INPUT_SCSS" "$SASSC_OUTPUT_CSS"
