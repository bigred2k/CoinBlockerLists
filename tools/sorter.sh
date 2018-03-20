#! /bin/bash
awk -F\. '{print $(NF-1) FS $NF}' file.txt >> o.txt

# get all lines which appear more than once
sort o*.txt | \
  awk ' $0 == prev_line { print $0; } { prev_line = $0 }; ' | \
  sort -u >dups.txt
# loop over the files
for f in o*.txt; do
  # remove dups from the file
  sort -u $f >${f}.tmp
  # are there any dups done already?
  if test -f dups_done.txt; then
    # the "new" (not already done) dups
    comm -23 dups.txt dups_done.txt >dups_new.txt
    # the lines only appearing in file
    comm -23 ${f}.tmp dups.txt >${f}.srt
    # add the "new" dups to file
    comm -12 ${f}.tmp dups_new.txt >>${f}.srt
    # unique sort of file
    sort -u ${f}.srt >${f}.out
    # all dups in this file are done now
    comm -12 ${f}.out dups.txt >dups_done.tmp
    # add former done dups
    cat dups_done.txt >>dups_done.tmp
    # create a sorted, unique done file
    sort -u dups_done.tmp >dups_done.txt
  else
    # no former done dups: create the done file
    comm -12 ${f}.tmp dups.txt >dups_done.txt
    mv ${f}.tmp ${f}.out
  fi
done
# a little bit cleanup
rm dups* *.tmp *.srt 2>/dev/null
exit 0
