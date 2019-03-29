#!/usr/bin/env bash
# it can only be sourced, do not allow to execute
# if there is no parameter, it stops and it gives the instructions
# Adrian Buzatu (adrian.buzatu@cern.ch)

[[ $- == *i* ]] && echo "Shell Interactive" || echo "Shell Not interactive"
if [[ $0 == "$BASH_SOURCE" ]]; then
    echo "ERROR: I'm a script ($0) forcing you to source. Don't execute me!" >&2
    exit 1
fi

# if there is no parameter, it stops and it gives the instructions
if [ $# -ne 2 ]; then
cat <<EOF
Usage: $0 debug verbose
Usage: $0 0     1
EOF
return
fi

# #########################################################################################################
# COMMAND LINE ARGUMENTS                                                                          #########
# #########################################################################################################

DEBUG=${1}
VERBOSE=${2}

# #########################################################################################################
# RUN                                                                                             #########
# #########################################################################################################

echo "Running source example_source.sh with DEBUG=${DEBUG} and VERBOSE=${VERBOSE}!"

# #########################################################################################################
# DONE                                                                                            #########
# #########################################################################################################

echo ""
echo ""
echo "All finished well for example_source.sh"
