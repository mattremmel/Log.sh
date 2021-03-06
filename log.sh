#!/bin/bash

# ------------------------------------------------------------------
#  Author: Matthew Remmel (matt.remmel@gmail.com)
#  Title: log
#
#  Description: Writes a formatted log message to standard out
#
#  Return:      A 0 is returned if the script runs as normal
#
#  Dependency:  date
# ------------------------------------------------------------------

# --- Version and Usage ---
DESCRIPTION="Description: Writes a formatted log message to standard out
or to the specified log file."
VERSION=0.2.0
USAGE="Usage: log [OPTIONS] MESSAGE

Options:
-h, --help       Show help and usage information
-v, --version    Show version information
-m, --message    Specify the message to log
-l, --logfile    Specify log file to write to
-t, --trace      Return trace style message
-d, --debug      Return debug style message
-i, --info       Return info style message
-w, --warning    Return warning style message
-e, --error      Return error style message
-f, --fatal      Return fatal style message"

# --- Dependecy Check ---
command -v date >/dev/null 2>&1 || { echo >&2 "[ERROR] Dependency 'date' not installed. Exiting."; exit 1; }

# --- Arguments ---
# Check that there is at least one argument. If not show usage.
if [ $# -eq 0 ]; then
    echo "$DESCRIPTION"
    echo
    echo "$USAGE"
    echo
    exit 1
fi

LOGLEVEL=""
LOGFILE=""
MESSAGE=""

while [[ $# > 0 ]]
do
    key="$1"

    case $key in
	-h|--help)
	    echo "$DESCRIPTION"; echo
	    echo "$USAGE"; echo
	    exit 0;;
	-v|--version)
	    echo "Version: $VERSION"
	    exit 0;;
	-m|--message)
            MESSAGE=$2
	    shift;;
  	-l|--logfile)
            LOGFILE=$2
            shift;;
	-t|--trace)
	    LOGLEVEL="[TRACE]";;
	-d|--debug)
	    LOGLEVEL="[DEBUG]";;
        -i|--info)
            LOGLEVEL="[INFO] ";;
        -w|--warning)
            LOGLEVEL="[WARN] ";;
        -e|--error)
            LOGLEVEL="[ERROR]";;
        -f|--fatal)
            LOGLEVEL="[FATAL]";;
	*)
            MESSAGE="$MESSAGE $@"
            break;;
    esac

    shift
done

# --- Main Body ---
DATE=$(date "+%Y-%m-%d %H:%M:%S")

if [ "$LOGFILE" = "" ]; then
  echo "$DATE $LOGLEVEL $MESSAGE"
else
  echo "$DATE $LOGLEVEL $MESSAGE" >> $LOGFILE
fi

exit 0
