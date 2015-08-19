#!/bin/bash
#
# Generate confidential/black and secret/red keys relative to this directory. 
# Black keys shall be used to gain access only to red keys but no content. 
# Red keys give you access to red content, then.

sh generateKeys.sh keys/Confidential/ 8192 64 6 X P
sh generateKeys.sh keys/Secret/ 8388608 8 6 S C
