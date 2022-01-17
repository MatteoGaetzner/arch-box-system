#! /bin/sh

# First argument specifies the cpu usage of the compression
# E.g. `vdcompress 42` means:use at most 42% of the cpu (including all cores).

unset perc

case $# in
  0 )
    cpulimit -l $(( $(nproc) * 100 )) -i _vdcompress ;;
  1 )
    cpulimit -l $(( $(nproc) * $1 )) -i _vdcompress ;;
  2 )
    cpulimit -l $(( $(nproc) * $1 )) -i _vdcompress $2 ;;
  * )
    pwarn "Usage: vdcompress <cpu usage in percent>; e.g. vdcompress 42 <optional:encoder>"
    return 1
    ;;
esac

