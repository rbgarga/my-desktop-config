#!/bin/sh

for pr in "$@"; do
	descr=$(curl https://github.com/pfsense/pfsense/pull/${pr} 2>/dev/null | sed '/<title>/!d; s,^.*<title>,,; s,...Pull Request #.*$,,')
	echo "  - #${pr}: ${descr}"
done

