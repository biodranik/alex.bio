#!/bin/bash
set -euo pipefail

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ `which hugo` ]; then HUGO=hugo
else echo "`hugo` binary is not installed" && exit 1
fi

"$MYDIR/compile_scss.sh"
"$HUGO"
