set relativenumber
set number
set mouse=a
set clipboard=unnamedplus
set virtualedit=all

function! KittyBufferHistoryClean()
  set modifiable
  set noconfirm
  " clean ascii/ansi code  (starts with ^[)
  silent! %s/\e\[[0-9:;]*m//g
  silent! %s/[^[:alnum:][:punct:][:space:]]//g
  silent! %s/\e\[[^\s]*\s//g
  " remove empty spaces from end
  silent! %s/\s*$//
  let @/ = ""
  set rnu
  " map q to force quit
  cnoremap q q!
endfunction

command! KittyBufferHistoryClean call KittyBufferHistoryClean()
