#! /bin/sh

# First argument specifies the cpu usage of the compression
# E.g. `vdcompress 42` means:use at most 42% of the cpu (including all cores).

unset perc

case $# in
  0 )
    perc=100 ;;
  1 )
    perc=$1 ;;
  * )
    pwarn "Usage: vdcompress <cpu usage in percent>; e.g. vdcompress 42"
    return 1
    ;;
esac

cpulimit -l $(( $(nproc) * $perc )) -i _vdcompress
