#!/bin/bash

BIDMACH_SCRIPTS="${BASH_SOURCE[0]}"
if [ ! `uname` = "Darwin" ]; then
  BIDMACH_SCRIPTS=`readlink -f "${BIDMACH_SCRIPTS}"`
fi
export BIDMACH_SCRIPTS=`dirname "$BIDMACH_SCRIPTS"`
cd ${BIDMACH_SCRIPTS}
BIDMACH_SCRIPTS=`pwd`
BIDMACH_SCRIPTS="$( echo ${BIDMACH_SCRIPTS} | sed 's+/cygdrive/\([a-z]\)+\1:+' )" 

echo "Loading arabic digits data"

UCI=${BIDMACH_SCRIPTS}/../data/uci
cd $UCI

if [ ! -e Train_Arabic_Digit.txt ]; then
    wget https://archive.ics.uci.edu/ml/machine-learning-databases/00195/Train_Arabic_Digit.txt
fi 

sed -e 's/^[[:space:]]*$/0 0 0 0 0 0 0 0 0 0 0 0 0/g' Train_Arabic_Digit.txt > arabic.txt
cd ${BIDMACH_SCRIPTS}/..
${BIDMACH_SCRIPTS}/../bidmach "-e" "BIDMach.DIGITS.preprocess(\"${UCI}/\",\"arabic\")"

if [ -e "arabic.txt" ]; then
  rm arabic.txt
fi
