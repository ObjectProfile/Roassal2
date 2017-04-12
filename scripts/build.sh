#!/bin/bash

export ERR_NOARGS=1
export ERR_DIR=2
export ERR_MISSING_FILE=3
export ERR_NOSERVER=4
export ERR_ZIP_LS=5
export ERR_ZIP_COMPRESS=6
export WORKING_DIR=build

### Define revision number ###

if [[ -z "$REVISION" ]] ; then
    if [[ -n "$TRAVIS_BUILD_NUMBER" ]] ; then 
	BUILD_NUMBER="-$TRAVIS_BUILD_NUMBER"
    else
	BUILD_NUMBER="$(date -u +%S)"
    fi
    REVISION="$(date -u +%Y%m%d%H%M)${BUILD_NUMBER}"
    export REVISION
fi

### Define GIT branch of GIT commit id ###

if [[ -n "$TRAVIS_COMMIT" ]] ; then
    BRANCH="$TRAVIS_COMMIT"
elif git rev-parse --is-inside-work-tree > /dev/null 2>&1 ; then
    BRANCH="$(git rev-parse HEAD)"
else
    BRANCH="master"
fi
export BRANCH


function help {
    echo "USAGE: $0 <arguments> [server name]"
    echo "       -4  download Pharo 4.0 (image, changes, VM)"
    echo "       -5  download Pharo 5.0 (image, changes, VM)"
    echo "       -6  download Pharo 6.0 (image, changes, VM)"
    echo "       -c  configure [name] image"
    echo "       -z  compress [name] image as ZIP"
    echo "       -r  run the [name] image"
    echo " server name can be:"
    echo "       PharoSprint    Pharo Sprint Client"
#    echo "       webhooks       FogBugz Webhooks to IoT Delegate Server"
    echo ""
}

function ensureWorkingDirectory {
    if mkdir -p $WORKING_DIR ; then
	cd $WORKING_DIR
    else
	echo "Cannot create working directory" >&2
	exit $ERR_DIR
    fi
}

function downloadPharoImageAndVM {
    # Downloads Pharo.image Pharo.changes, pharo, pharo-ui, and pharo-vm directory
    # $1 defines Pharo version (40, 50, 60)
    zeroScript="$(which curl wget | head -1)"
    PVERSION=${1:-60}

    case "$zeroScript" in
	*curl*)
	    curl get.pharo.org/$PVERSION+vm | bash
	    ;;
	*wget*)
	    wget -O- get.pharo.org/$PVERSION+vm | bash
	    ;;
	*)
	    echo default
	    ;;
    esac
}

# function configure {
#     # For some reason it does not work
#     ./pharo Pharo.image config \
# 	    http://smalltalkhub.com/mc/JurajKubelka/GTCollaborate/main/ \
# 	    ConfigurationOfPharoSprint --install=stable
# }


function runPharoScript {
    # $1 Pharo image
    # $2 Pharo script
    PHARO="./pharo"
    if [ ! -r "$PHARO" ] ; then
	echo "Missing Pharo VM called $PHARO in $PWD directory." >&2
	exit $ERR_MISSING_FILE
    fi
    if [ ! -r "$1" ] ; then
	echo "Missing Pharo image called $1 in $PWD directory." >&2
	exit $ERR_MISSING_FILE
    fi
    if [ ! -r "$2" ] ; then
	echo "Missing script file '$2' in $PWD directory." >&2
	exit $ERR_MISSING_FILE
    fi
    $PHARO "$1" --no-default-preferences "$2"
}

# function configure {
#     # $1 <server-name>
#     runPharoScript Pharo.image "../configure-${1}.st"
# }

function prepareScript {
    # $1 <image name>
    sed -e 's/$REVISION\$/'"$REVISION"'/' -e  's/$BRANCH\$/'"$BRANCH"'/' "../configuration-${1}.st" > "./configuration-${1}.st"
}
    
function configure {
    # $1 <image name>
    if [ ! -r "../configuration-${1}.st" ] ; then
	echo "Configuration file does not exists." >&2
	exit $ERR_MISSING_FILE
    fi
    prepareScript "$1"
    runPharoScript Pharo.image "./configuration-${1}.st"
}

function compressImage {
    # $1 <image name>
    if ! ls ${1}*${REVISION}* ; then
	exit $ERR_ZIP_LS
    fi
    FILENAME="$(ls ${1}*${REVISION}* | head -1)"
    if ! zip "${FILENAME%.*}.zip" ${1}*${REVISION}*.image ${1}*${REVISION}*.changes ; then
	exit $ERR_ZIP_COMPRESS
    fi
}

function run {
    # $1 <server-name>
    runPharoScript "${1}Server.image" "../run-${1}.st"
}

# Parse allowed parameters
args=$(getopt 456crhzn: $*)

if [ $? != 0 ] ; then
    help
    exit $ERR_NOARGS
fi

set -- $args

for param
do
    case "$param"
    in
	-4)
	    ARG_VERSION=40
	    ARG_OK=true
	    shift
	    ;;
	-5)
	    ARG_VERSION=50
	    ARG_OK=true
	    shift
	    ;;
	-6)
	    ARG_VERSION=60
	    ARG_OK=true
	    shift
	    ;;
	-r)
	    ARG_RUN=true
	    ARG_OK=true
	    shift
	    ;;
	-c)
	    ARG_CONFIGURE=true
	    ARG_OK=true
	    shift
	    ;;
	-z)
	    ARG_ZIP=true
	    ARG_OK=true
	    shift
	    ;;
	-h)
	    ARG_HELP=true
	    shift
	    ;;
	--)
	    shift
	    break
	    ;;
	-n)
	    ARG_SERVER="$2"
	    shift
	    shift
	    ;;
    esac
done

if [ "$ARG_HELP" ] ; then
    help
    exit 0
fi

if [ ! "$ARG_OK" ] ; then
    echo "You should decide what to do." >&2
    help
    exit $ERR_NOARGS
fi

if [ \( -n "$ARG_CONFIGURE" -o -n "$ARG_RUN" \) -a -z "$ARG_SERVER" ] ; then
    echo "You have to decide what image to configure or run. Use parameter -n." >&2
    help
    exit $ERR_NOSERVER
fi

ensureWorkingDirectory

if [ "$ARG_VERSION" ] ; then
    echo
    echo "### Download Pharo Image and VM of version $PVERSION ###"
    echo
    downloadPharoImageAndVM "$ARG_VERSION"
fi

if [ "$ARG_CONFIGURE" ] ; then
    echo
    echo "### Configure "$ARG_SERVER" Image ###"
    echo
    configure "$ARG_SERVER"
fi

if [ "$ARG_ZIP" ] ; then
    echo
    echo "### Compress "$ARG_SERVER" Image ###"
    echo
    compressImage "$ARG_SERVER"
fi

if [ "$ARG_RUN" ] ; then
    echo
    echo "### Run "$ARG_SERVER" Image ###"
    echo
    run "$ARG_SERVER"
fi