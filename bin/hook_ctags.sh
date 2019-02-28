#!/bin/sh

if [ -f /usr/local/bin/exctags ]; then
	ctags=exctags
else
	ctags=ctags
fi

# Only pfSense/FreeBSD-src repos
if [ ! -f ./build.sh -a ! -f ./ObsoleteFiles.inc ]; then
	exit 0
fi

set -e
PATH="/opt/local/bin:$PATH"
git_dir=$(git rev-parse --git-dir)
trap "rm -f ${git_dir}/tags.$$" EXIT
$ctags --tag-relative -Rf ${git_dir}/tags.$$ --exclude=.git --languages=PHP,JavaScript --langmap=PHP:.php.inc >/dev/null 2>&1
mv ${git_dir}/tags.$$ ${git_dir}/tags
