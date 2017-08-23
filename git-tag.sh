#!/bin/bash
# if testing then delete test tag like so:
# git tag -d tagname

git checkout develop
git pull
git tag
read -p 'Please choose the previous tag to match against > ' last
read -p 'Please provide the next tag name > ' next
if [ -n "$last"  ]; then
	CHANGES="$(git log $last..HEAD | grep "pull request")"
	if [ -n "$next" ]; then
		git tag -a $next -m "$CHANGES"
		git push --tags
		COMMIT="$(git log -1 --format=format:"%H" $next)"
		GREEN='\033[0;32m'
		NC='\033[0m' # No Color
		echo -e "${GREEN}'git push origin $COMMIT:test' ${NC}to enforce these changes"
	fi
fi
