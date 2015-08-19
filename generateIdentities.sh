#!/bin/bash
# Generates various Identity files in the specified target directory
#
# 


# parse command line arguments
TARGET_DIR=$1
KEY_STRENGTH=$2
AMOUNT_KEYFILES=$3
KEY_FILENAME_MID_LENGTH=$4
KEY_FILENAME_PREFIX=$5
KEY_FILENAME_SUFFIX=$6


# never overwrite existing structures
if [ -d "$TARGET_DIR" ]; then
  echo "Please provide a non-existent directory. Existing keys are not meant to be replaced for security reasons."
  exit 1
fi


# key strength has to be positive
if [ "$KEY_STRENGTH" -gt 0 ]
    echo "Please provide a key strength greater than zero. $KEY_STRENGTH does not fit this constraint."
    exit 1
fi


# amount key files has to be positive
if [ "$AMOUNT_KEYFILES" -gt 0 ]
    echo "Please provide an amount of key files greater than zero. $AMOUNT_KEYFILES does not fit this constraint."
    exit 1
fi


# create empty target directory
mkdir -p $TARGET_DIR


# create keys on-by-one and put them in there
for i in $(eval echo {1..$AMOUNT_KEYFILES}); do

    FILENAME=`openssl passwd 0 | shasum -a 512`
    FILENAME=`echo $KEY_FILENAME_PREFIX${FILENAME:0:$((KEY_FILENAME_MID_LENGTH))}$KEY_FILENAME_SUFFIX`
    
    CONTENT=`openssl rand -base64 $KEY_STRENGTH`
        
    echo $CONTENT > `echo $TARGET_DIR/${FILENAME}`
done
    

# report success creation
echo "$AMOUNT_KEYFILES key files were successfully generated into $TARGET_DIR."
exit 0
