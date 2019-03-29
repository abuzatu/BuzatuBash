#!/usr/bin/env bash
# it can only be executed, do not allow to source
# and stop if some unbound variable is used
# if there is no parameter, it stops and it gives the instructions
# Adrian Buzatu (adrian.buzatu@cern.ch) 

[[ $- == *i* ]] && echo "Shell Interactive" || echo "Shell Not interactive"
if [[ $0 != "$BASH_SOURCE" ]]; then
    echo "ERROR: I'm a script forcing you to execute. Don't source me!" >&2
    return 1
else
    # if I am OK to execute, force that the script stops if variables are not defined
    # this catches bugs in the code when you think a variable has value, but it is empty
    set -eu
fi

# if there is no parameter, it stops and it gives the instructions
if [ $# -ne 2 ]; then
cat <<EOF
Usage: $0 debug verbose
Usage: $0 0     1
EOF
exit 1
fi

# #########################################################################################################
# COMMAND LINE ARGUMENTS                                                                          #########
# #########################################################################################################

DEBUG=${1}
VERBOSE=${2}

# #########################################################################################################
# RUN                                                                                             #########
# #########################################################################################################

echo "Running ./example_execute.sh with DEBUG=${DEBUG} and VERBOSE=${VERBOSE}!"

# #########################################################################################################
# DONE                                                                                            #########
# #########################################################################################################

echo ""
echo ""
echo "All finished well for example_execute.sh"
