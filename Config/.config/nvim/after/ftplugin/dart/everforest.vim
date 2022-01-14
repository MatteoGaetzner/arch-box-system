if !exists('g:colors_name') || g:colors_name !=# 'everforest'
    finish
endif
if index(g:everforest_loaded_file_types, 'dart') ==# -1
    call add(g:everforest_loaded_file_types, 'dart')
else
    finish
endif
" ft_begin: dart {{{
" dart-lang: https://github.com/dart-lang/dart-vim-plugin {{{
highlight! link dartCoreClasses Aqua
highlight! link dartTypeName Aqua
highlight! link dartInterpolation Blue
highlight! link dartTypeDef RedItalic
highlight! link dartClassDecl RedItalic
highlight! link dartLibrary PurpleItalic
highlight! link dartMetadata Blue
" }}}
" ft_end
