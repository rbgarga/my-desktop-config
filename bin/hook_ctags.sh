#!/bin/sh
set -e
PATH="/opt/local/bin:$PATH"
trap "rm -f .git/tags.$$" EXIT
ctags --tag-relative -Rf.git/tags.$$ --exclude=.git --languages=PHP,JavaScript --langmap=PHP:.php.inc >/dev/null 2>&1
mv .git/tags.$$ .git/tags
