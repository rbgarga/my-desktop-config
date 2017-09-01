#!/bin/sh

usage() {
	echo "Usage: $(basename ${0}) -u user -b branch -p #pull_request"
}

USER=""
BRANCH=""
PULL=""

while getopts u:b:p:h flag; do
	case ${flag} in
		u)
			if echo "${OPTARG}" | grep -q ':'; then
				USER=$(echo "${OPTARG}" | cut -d: -f1)
				BRANCH=$(echo "${OPTARG}" | cut -d: -f2)
			else
				USER=${OPTARG}
			fi
			;;
		b)
			BRANCH=${OPTARG}
			;;
		p)
			PULL=${OPTARG}
			;;
		h)
			usage
			exit 0
			;;
	esac
done

if [ -z "${USER}" -o -z "${BRANCH}" -o -z "${PULL}" ]; then
	usage
	exit 1
fi

REPO=$(git config --get remote.origin.url | sed 's,.*/,,')

if [ -z "${REPO}" ]; then
	echo "Current dir doesn't looks like a git repository"
	exit 1
fi

RESULT=$(git pull --no-ff --log --no-commit \
	git@github.com:${USER}/${REPO} ${BRANCH} 2>&1)

if [ $? -eq 0 ]; then
	git commit -m "Merge pull request #${PULL} from ${USER}/${BRANCH}" >/dev/null 2>&1
	echo "Pull request #${PULL} has ben merged, please review and push the changes"
else
	echo "ERROR! Pull request #${PULL} could not be merged, check following errors:"
	echo ""
	echo ${RESULT}
	echo ""
	exit 1
fi

exit 0
