# Generate-Crypto-Keys
Generate cryptographic keys on Linux command line in batches. The keys are generated using OpenSSL in various strengths. Those key files can be used to open TrueCrypt volumes.




# Reasonable defaults — for users
In order to generate key files you can either:

1. **call autoGenerate.sh** or
This will generate some solid confidential and secret keys in a dedicated *./keys/* folder with subfolders *./keys/Confidential/* and *./keys/Secret/* respectively.

2. **call generateKeys.sh** like this
*sh generateKeys.sh nonexistent/folder/to/keys/ keysize keycount filenameMiddlePartLength Prefix Suffix*




The key size is defined in bytes and key count without units — it’s file count. The filenameMiddlePartLength is a random part of the resulting file name — the filesystem, your Operating System, and containing folders define how long each file name still can be. Prefix and suffix are optional, but iff a suffix exists a prefix must as well.




The **autoGenerate.sh** will do nothing but call

1. **sh generateKeys.sh keys/Confidential/ 8192 64 6 X P**

2. **sh generateKeys.sh keys/Secret/ 8388608 8 6 S C**

with the current user’s privileges. Only you will be able to read those files. No one is allowed to write them by default. All access from other users is restricted right before the first key is being created.




# Reasonable defaults — for developers
To work you through the program there are only two files you need to be aware of:

- **autoGenerate.sh** and 

- **generateKeys.sh**.

Both of them are very lean. The first is a great starting point, as it shows you how to call the operative script with command line arguments. The latter is to needed to gain this deeper understanding of what is going on under the bonnet.
