#!/bin/sh

if [ ! -f ./Makefile ]; then
	echo "Bad port"
	exit 1
fi

category=$(make -V CATEGORIES | cut -d" " -f1)
pdir=$(basename $(realpath .))
ports_tree=${1:-default}
base_dir="/usr/local/poudriere/ports/${ports_tree}"

if [ -z "$category" ]; then
	echo "Blank category"
	exit 1
fi

if [ -z "$pdir" ]; then
	echo "Blank pdir"
	exit 1
fi

if [ ! -d "$base_dir" ]; then
	echo "No basedir"
	exit 1
fi

if [ -d ${base_dir}/${category}/${pdir} ]; then
	rm -rf ${base_dir}/${category}/${pdir}
fi

cp -rv ../${pdir} ${base_dir}/${category}
