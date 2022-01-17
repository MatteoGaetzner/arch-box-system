#!/bin/bash

print_n_compressed() {
  if [[ "$3" == "-overwrite" ]]; then
    echo -e "\e[1A\e[KCompressed files: $1 / $2"
  else
    echo -e "Compressed files: $1 / $2"
  fi
}

vcompress() {
  fname="$1"
  fname_no_ext=${fname%.*}
  # printf "filename: $fname \t encoder: $2\n"
  if [[ $# -ge 2 ]]; then
    ffmpeg -nostdin -i $1 -vcodec "$2" -crf 20 ${fname_no_ext}_compressed.mp4 2> /dev/null > /dev/null &
  else
    ffmpeg -nostdin -i $1 -vcodec libx265 -crf 20 ${fname_no_ext}_compressed.mp4 2> /dev/null > /dev/null &
  fi
}

((n_files=$(ls -1 | wc -l)))
((n_compressed=0))

print_n_compressed $n_compressed $n_files -nooverwrite

for file in *; do
  num_children=`ps | grep ffmpeg | wc -l`
  if [[ num_children -ge 4 ]]; then
    wait -n
    ((++n_compressed))
    print_n_compressed $n_compressed $n_files -overwrite
  fi
  vcompress $file $1
done

while [[ $num_children -gt 0 ]]; do
  wait -n
  num_children=`ps | grep ffmpeg | wc -l`
  if [[ $num_children -ge 1 ]]; then
    ((++n_compressed))
  fi
  print_n_compressed $n_compressed $n_files -overwrite
done

usage_before=0
usage_after=0

# remove _compressed substring from file names
for filename in ./*_compressed*; do
  # printf "filename: $filename\n"
  newname=$(echo $filename | sed 's/_compressed//')
  usage_before=$((usage_before+$(du -sb $newname | awk '{ print $1 }')))
  mv "$filename" "$newname"
  usage_after=$((usage_after+$(du -sb $newname | awk '{ print $1 }')))
done

usage_before=$(echo $usage_before | numfmt --to=iec)
usage_after=$(echo $usage_after | numfmt --to=iec)


echo "Old usage: $usage_before"
echo "New usage: $usage_after"
