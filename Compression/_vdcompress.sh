#!/bin/bash

vcompress() {
  fname="$1"
  fname_no_ext=${fname%.*}
  if [[ $2 = -bg ]]; then
    # surrounding brackets avoid pid output to terminal
    ffmpeg -nostdin -i $1 -vcodec libx265 -crf 20 ${fname_no_ext}_compressed.mp4 & 2> /dev/null
  else
    ffmpeg -i $1 -vcodec libx265 -crf 20 ${fname_no_ext}_compressed.mp4 2> /dev/null
  fi
}

((n_files=$(ls -1 | wc -l)))
((n_compressed=0))

# let at most two jobs run concurrently
num_processes=$(pgrep -c -P$$)
echo "Compressed videos: $n_compressed / $n_files"
for fname in *; do
  num_processes=$(pgrep -c -P$$)
  if [[ $num_processes -ge 2 ]]
  then
    wait -n
    ((n_compressed+=1))
  fi

  vcompress "$fname" -fg &

  echo -e "\e[1A\e[KCompressed videos: $n_compressed / $n_files"
done

# wait for last two processes to finish
num_processes=$(pgrep -c -P$$)
while [[ $num_processes -gt 0 ]]
do
  wait -n
  ((n_compressed+=1))
  num_processes=$(pgrep -c -P$$)
  echo -e "\e[1A\e[KCompressed videos: $n_compressed / $n_files"
done


usage_before=0
usage_after=0

# remove _compressed substring from file names
for filename in *_compressed*; do
  newname=$(echo $filename | sed 's/_compressed//')
  usage_before=$((usage_before+$(du -sb $newname | awk '{ print $1 }')))
  mv "$filename" $newname
  usage_after=$((usage_after+$(du -sb $newname | awk '{ print $1 }')))
done

usage_before=$(echo $usage_before | numfmt --to=iec)
usage_after=$(echo $usage_after | numfmt --to=iec)


echo "Old usage: $usage_before"
echo "New usage: $usage_after"
