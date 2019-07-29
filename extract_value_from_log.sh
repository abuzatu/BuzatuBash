#!/usr/bin/env bash
# it can only be executed, do not allow to source
# and stop if some unbound variable is used
# if there is no parameter, it stops and it gives the instructions
# Adrian Buzatu (adrian.buzatu@teraki.com), April 2019, for the project of 3D point cloud compressiong comparing several algorithms 
# evaluates the latency from the Teraki software

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
if [ $# -ne 4 ]; then
cat <<EOF
Usage: $0 LOG_FILE_NAME                                                        OPTION        COMPRESSED_LATENCY                                                                    DEBUG
Usage: $0 ./output/logs/chair_compressed_TERAKI_CP_01_QP_20.log                to            ./output/performance/latencies/chair_compressed_TERAKI_CP_01_QP_20.txt                0 
Usage: $0 ./output/logs/chair_decompressed_TERAKI_CP_01_QP_20.log              to            ./output/performance/latencies/chair_decompressed_TERAKI_CP_01_QP_20.txt              0
Usage: $0 ./output/logs/chair_compressed_PCL_0.001000_0.001000_0_100_4_0.log   compressing   ./output/performance/latencies/chair_compressed_PCL_0.001000_0.001000_0_100_4_0.txt   0 
Usage: $0 ./output/logs/chair_decompressed_PCL_0.001000_0.001000_0_100_4_0.log decompressing ./output/performance/latencies/chair_decompressed_PCL_0.001000_0.001000_0_100_4_0.txt 0
EOF
exit 1
fi

# #########################################################################################################
# COMMAND LINE ARGUMENTS                                                                          #########
# #########################################################################################################

# nothing for now
LOG_FILE_NAME=${1}
OPTION=${2}
LATENCY_FILE_NAME=${3}
DEBUG=${4}

if [[ ${DEBUG} == "1" ]]; then
    echo "LOG_FILE_NAME=${LOG_FILE_NAME}"
    echo "OPTION=${OPTION}"
    echo "LATENCY_FILE_NAME=${LATENCY_FILE_NAME}"
    echo "DEBUG=${DEBUG}"
fi

#############################################################################################
### Running
#############################################################################################

# retrieve the relevant line from the log file
# e.g. for compression (encode) the relevant line is
# Encoded point cloud saved to ./output/data/chair_compressed_Binary_TERAKI_CP_01_QP_20.drc (4 ms to encode).
# from which our goal is to retrieve 4
# e.g. for decompression (decode)
# Decoded geometry saved to ./output/data/chair_decompressed_Binary_TERAKI_CP_01_QP_20.ply (2 ms to decode)
# from which our goal is to retrieve 2

RELEVANT_LINE=$(grep saved ${LOG_FILE_NAME} | grep ${OPTION})
if [[ ${DEBUG} == "1" ]]; then
    echo "RELEVANT_LINE=${RELEVANT_LINE}"
fi

# keep only what is before the first paranthesis "(", so keep only "4 ms to encode)" or "2 ms to decode)".
STEM="${RELEVANT_LINE#*(}"  # Removes until the first dot and also the dot. Keeps what is after the first paranthesis "(".
if [[ ${DEBUG} == "1" ]]; then
    echo "STEM=${STEM}"
fi

# keep only what is before the first space ("\ "), so keep only "4" or "2".
LATENCY="${STEM%%\ *}" # Removes from the first dot until the end. Keeps what is before the first space "\ ".
if [[ ${DEBUG} == "1" ]]; then
    echo "LATENCY=${LATENCY} (in miliseconds, or ms)"
fi

echo "${LATENCY}" > ${LATENCY_FILE_NAME}

#############################################################################################
### Done
#############################################################################################

echo "Done ./code/scripts/extract_value_from_log.sh!"
