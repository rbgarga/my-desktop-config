#!/bin/sh

branch="${1}"

if [ -z "${branch}" ]; then
	exit 1
fi

git chp -x $( \
	git log --oneline origin/${branch}..${branch} | \
	sed '1d' | \
	tail -r | \
	awk '{print $1}' | \
	paste -d' ' -s -
)
