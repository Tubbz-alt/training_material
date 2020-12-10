#! /usr/bin/bash
set -e

# Replace file extensions by both git moving the files and changing any reference to the file
# in the project sources.
#
# usage: rename_ext.sh <old_extension> <new_extension>
# $ bash rename_ext.sh .jpg .jpeg
#
# After running the script you can `git diff` to review the sources changes,
# don't forget to add them before commiting.

old_ext=$1
new_ext=$2

for f in $(find -name "*.$old_ext"); do
    fnew="${f%.$old_ext}.$new_ext"
    echo "$f -> $fnew"
    sed -i "s/$(basename $f)/$(basename $fnew)/g" $(grep -lr $(basename $f))
    git mv -- "$f" "$fnew"
done
