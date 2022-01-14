if !exists('g:colors_name') || g:colors_name !=# 'everforest'
    finish
endif
if index(g:everforest_loaded_file_types, 'octave') ==# -1
    call add(g:everforest_loaded_file_types, 'octave')
else
    finish
endif
" ft_begin: octave {{{
" vim-octave: https://github.com/McSinyx/vim-octave{{{
highlight! link octaveDelimiter Fg
highlight! link octaveSemicolon Grey
highlight! link octaveOperator Orange
highlight! link octaveVariable YellowItalic
highlight! link octaveVarKeyword YellowItalic
" }}}
" ft_end
