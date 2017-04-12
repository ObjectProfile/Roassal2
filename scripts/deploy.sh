#!/bin/bash

export ERR_BUILD=1

# build image and change files and compress them into one ZIP file
( cd scripts && ./build.sh -6cz -n Roassal2 )
if [[ "$?" != 0 ]] ; then
    echo "ERROR: unsuccessfull build" >&2
    exit $ERR_BUILD
fi

# set version and commit id for the bintray configuration
echo "---"
echo "$TRAVIS_COMMIT_MESSAGE"
ONELINE_COMMIT_MESSAGE="$(echo "$TRAVIS_COMMIT_MESSAGE" | sed -e 's/"/\\"/g' -e :a -e N -e '$!ba' -e 's/\n/\\n/g' | tr '\n\r' '..')"
echo "---"
# create bintray configuration
cat <<EOF | tee .bintray.json
{
    "package": {
        "name": "build",
        "repo": "Roassal2",
	"subject": "ObjectProfile"
    },
    "version": {
        "name": "${REVISION}",
        "desc": "Automatic build of the GitHub commit ${TRAVIS_COMMIT}.\n\nCommit message: ${ONELINE_COMMIT_MESSAGE}"
    },
    "files": [
        {
	    "includePattern": "./scripts/build/(Roassal-.*\\.zip)", 
	    "uploadPattern": "\$1", 
	    "matrixParams": { "override": 1 }
	}
    ],
    "publish": true
}
EOF
echo "---"