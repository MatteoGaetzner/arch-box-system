#!/bin/bash

MAX_THREADS_GPU=5
MAX_THREADS_CPU=3
SLEEP_TIME=1

declare -i num_ffmpeg_processes
declare -i num_old_ffmpeg_processes

print_n_compressed() {
  if [[ "$3" == "-overwrite" ]]; then
    echo -e "\e[1A\e[KCompressed files: $1 / $2"
  else
    echo -e "Compressed files: $1 / $2"
  fi
}

ffmpeg_processes() {
  printf "calling ffmpeg_processes\n"
  return $(`ps | grep ffmpeg | wc -l`)
}

get_finished () {
  return $(( $1 - $(ffmpeg_processes) + $2))
}

vcompress() {
  fname="$1"
  fname_no_ext=${fname%.*}
  unset codec

  case $# in
    1)
      codec="hevc_nvenc"
      ;;
    2)
      codec=$2
      ;;
    *)
      perror "vcompress accepts at most two arguments."
      ;;
  esac

  ffmpeg -hwaccel cuda -hwaccel_output_format cuda -nostdin -i $1 -vcodec "$codec" -crf 20 ${fname_no_ext}_compressed.mp4 2> /dev/null > /dev/null &
}

((n_files=$(ls -1 | wc -l)))
((n_compressed=0))

print_n_compressed $n_compressed $n_files -nooverwrite

for file in *; do
  num_old_ffmpeg_processes=${ffmpeg_processes}
  printf "old_procs: $num_old_ffmpeg_processes\n"
  while [[ $num_ffmpeg_processes -ge $MAX_THREADS_GPU ]]; do
    sleep $SLEEP_TIME
    n_compressed=$(get_n_compressed $num_old_ffmpeg_processes $n_compressed)
  done
  print_n_compressed $n_compressed $n_files -overwrite
  vcompress $file $1
done

while [[ $num_ffmpeg_processes -gt 0 ]]; do
  num_old_ffmpeg_processes=$(ffmpeg_processes)
  sleep $SLEEP_TIME
  n_compressed=$(get_n_compressed $num_old_ffmpeg_processes $n_compressed)
  print_n_compressed $n_compressed $n_files -overwrite
done

usage_before=0
usage_after=0

# remove _compressed substring from file names
for filename in ./*_compressed*; do
  newname=$(echo $filename | sed 's/_compressed//')
  usage_before=$((usage_before+$(du -sb $newname | awk '{ print $1 }')))
  mv "$filename" "$newname"
  usage_after=$((usage_after+$(du -sb $newname | awk '{ print $1 }')))
done

usage_before=$(echo $usage_before | numfmt --to=iec)
usage_after=$(echo $usage_after | numfmt --to=iec)


echo "Old usage: $usage_before"
echo "New usage: $usage_after"
