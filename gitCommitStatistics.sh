#!/usr/bin/env bash

# script that will print the git commit statistics since a date
# either specified by the user, or calculated automatically since last year
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
if [ $# -ne 1 ]; then
cat <<EOF
Usage: $0 dates
Usage: $0 2019-11-01,last_year
EOF
exit 1
fi

# #########################################################################################################
# COMMAND LINE ARGUMENTS                                                                          #########
# #########################################################################################################

DATES=${1}

# #########################################################################################################
# FUNCTIONS                                                                                       #########
# #########################################################################################################

getGitStatsSinceOneBeginDate()
{
    begintime=${1}
    echo "Git commit stats:"
    # Analyse the git log and save as a variable
    gitLog=$(git log --shortstat --since="$begintime")
    # Commits, insertions and deletions
    gitCommits=$(grep -c commit <<< "$gitLog")
    gitInserted=$(sum=0; for i in $(git log --shortstat --since="$begintime" | grep insertions | cut -d "," -f2 | sed 's/^[ \t]*//' | cut -d " " -f1); do sum=$((sum+${i})); done; echo "${sum}")
    gitDeleted=$(sum=0; for i in $(git log --shortstat --since="$begintime" | grep deletions | cut -d "," -f3 | sed 's/^[ \t]*//' | cut -d " " -f1); do sum=$((sum+${i})); done; echo "${sum}")
    # Show the results
    echo "Commits since:        "$begintime
    echo "Number of commits:    "$gitCommits
    echo "Inserted lines:       "$gitInserted
    echo "Deleted lines:        "$gitDeleted
}

getGitStats()
{
    # first check that we are in a git repository
    isGitRepo="$(git rev-parse --is-inside-work-tree 2> /dev/null)"
    if [ -z "${isGitRepo}" ]; then
	echo "Please run this script from inside a git repository ..."
	exit -1
    fi
    
    # if here we are in a repository
    echo ""
    echo "We checked we are in a git folder, so we proceed to evaluate its commit statistics."

    # Some statistics about your git repository
    echo "Basic git statistics:"
    gitRepoName=$(basename `git rev-parse --show-toplevel`)
    echo "Repository name:      "$gitRepoName
    echo "Looping over all the dates you want studied."

    # loop over all the dates since when we want statistics to be printed out
    for DATE in `echo "${DATES}" | awk -v RS=, '{print}'`
    do
	echo ""
	echo "DATE=${DATE}"
	if [[ ${DATE} == "last_year" ]]; then
	    declare -i Year=$(date +"%Y")
	    ((Year--))
	    begintime=$(date +"$Year-%m-%d")
	    prefix="Statistics for the last year"
	    echo "begintime=${begintime}"
	else
	    begintime=${DATE}
	    prefix="Statistics since a fixed date"
	fi
	echo "${prefix}"
	getGitStatsSinceOneBeginDate ${begintime}	
    done
}

# #########################################################################################################
# RUN                                                                                             #########
# #########################################################################################################

getGitStats

# #########################################################################################################
# DONE                                                                                            #########
# #########################################################################################################

echo ""
echo "All done!"
