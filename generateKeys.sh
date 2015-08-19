#!/bin/bash
# Generates various Identity files in the specified target directory
#
# target directory:								yet non-existent destination to put generated key files into
# key strength:									any key file's strength in bytes
# amount key files:								how many key files shall be created
# key file name's middle part's length:			the file name will consist of a 
#												static prefix, a random middle part, and 
#												a static suffix; this is the length in 
#												characters for the random middle part
# key file name's prefix:						define the static prefix or none
# key file name's suffix:						define the static suffix or none
#
#
# Reasonable example for confidential/black keys:
# sh generateKeys.sh keys/Confidential/ 8192 64 6 X P
#
#
# Results in 64 key files created in ./keys/Confidential/, which is created on the fly, 
# each file being 8 KB and being named: K??????C, like 'X225cbeP' or 'Xb32241P'. 
# Any of those files is only readable by the creating user. Last two arguments are 
# mandatory, but recommended for human recognition.
#
#
# Reasonable example for secret/red keys:
# sh generateKeys.sh keys/Secret/ 8388608 8 6 S C
#
# Results in eight key files created in ./keys/Secret/, which is created on the fly, 
# each file being 8 MB and being named: S??????C, like 'S7bddf1C' or 'Se3f447C'. 
# Any of those files is only readable by the creating user. Last two arguments are 
# mandatory, but recommended for human recognition.



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
if [ 0 -gt "$KEY_STRENGTH" ]; then
    echo "Please provide a key strength greater than zero. $KEY_STRENGTH does not fit this constraint."
    exit 1
fi


# amount key files has to be positive
if [ 0 -gt "$AMOUNT_KEYFILES" ]; then
    echo "Please provide an amount of key files greater than zero. $AMOUNT_KEYFILES does not fit this constraint."
    exit 1
fi


# amount key files has to be positive
if [ 64 -lt "$KEY_FILENAME_MID_LENGTH" ]; then
    echo "Please provide a key filename middle length at most with 64 chars. $KEY_FILENAME_MID_LENGTH does not fit this constraint."
    exit 1
fi


# create empty target directory
mkdir -p $TARGET_DIR
chmod -R 700 $TARGET_DIR


# create keys on-by-one and put them in there
for i in $(eval echo {1..$AMOUNT_KEYFILES}); do

    FILENAME=`openssl passwd 0 | shasum -a 512`
    FILENAME=`echo $KEY_FILENAME_PREFIX${FILENAME:0:$((KEY_FILENAME_MID_LENGTH))}$KEY_FILENAME_SUFFIX`
    
    CONTENT=`openssl rand -base64 $KEY_STRENGTH`
        
    echo $CONTENT > `echo $TARGET_DIR/$FILENAME`
done

chmod -R 500 $TARGET_DIR
    

# report success creation
echo "$AMOUNT_KEYFILES key files were successfully generated into $TARGET_DIR."
exit 0
