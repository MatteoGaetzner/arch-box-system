"-------------  General Settings  --------------

filetype plugin indent on
set backspace=indent,eol,start
set complete+=kspell
set nohlsearch
set completeopt=menuone,longest
set conceallevel=2
set expandtab
set ic is
set ignorecase
set linebreak
set shiftwidth=2
set shortmess+=c
set smartcase
set smartindent
set tabstop=2
set number relativenumber
set nu rnu
set hidden
set nostartofline
set timeout ttimeoutlen=25
set colorcolumn=100
set scrolloff=10
let mapleader = " "
" set syntax=on

" Performance
set lazyredraw

" Source plugins
source $HOME/.config/nvim/vim-plug/plugins.vim

" Use Python3
if has('python3')
endif


set foldmethod=syntax
set foldlevelstart=2

let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script

"--------------  Auxiliary Files  ----------------

set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

"--------------  Key Tweaks  ---------------------

nnoremap <Tab> >>2l
nnoremap <S-T> <<2h

" gm -> add mark
nnoremap gm m

"--------------  Custom Commands -----------------

cnoremap -complete=file -nargs=1 O execute 'silent! !xdg-open <args>'
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

"--------------  Moving Lines  -------------------

nnoremap <C-J> :move .+1<CR>==
nnoremap <C-K> :move .-2<CR>==
inoremap <C-J> <Esc>:move .+1<CR>==gi
inoremap <C-K> <Esc>:move .-2<CR>==gi
vnoremap <C-J> :move '>+1<CR>gv=gv
vnoremap <C-K> :move '<-2<CR>gv=gv

"--------------  Vimrc Editing  ------------------

nnoremap <F1> :e ~/.config/nvim/init.vim<CR>
nnoremap <F2> <C-o>:source ~/.config/nvim/init.vim<CR>

"--------------  Clipboard  ----------------------

augroup clipboardgroup
  autocmd!
  autocmd VimLeave * call system("xsel -ib", getreg('+'))
augroup end

set clipboard+=unnamedplus
let g:clipboard = {
      \   'name': 'xsel_override',
      \   'copy': {
        \      '+': 'xsel --input --clipboard',
        \      '*': 'xsel --input --primary',
        \    },
        \   'paste': {
          \      '+': 'xsel --output --clipboard',
          \      '*': 'xsel --output --primary',
          \   },
          \   'cache_enabled': 1,
          \ }

"--------------  Vim-Localrc  --------------------

silent! so .vimlocal
autocmd BufReadPost *.vimlocal set filetype=vim

"--------------  Line Numbers  -------------------

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup end

"--------------  Spelling and Grammar  -----------

" Show nine spell checking candidates at most
set spellsuggest=best,9

" switch spellcheck languages
let g:myLang = 0
let g:myLangList = [ "nospell", "de_de", "en_us" ]
function! MySpellLang()
  " loop through languages
  let g:myLang = g:myLang + 1
  if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
  if g:myLang == 0 | set nospell | endif
  if g:myLang == 1 | setlocal spell spelllang=de_de | endif
  if g:myLang == 2 | setlocal spell spelllang=en_us | endif
  echo "language:" g:myLangList[g:myLang]
endfun

map <F12> :call MySpellLang()<CR>
imap <F12> :call MySpellLang()<CR>

"--------------  Windows  ------------------------

" Make windows always equal size after resize
augroup windowsgroup
  autocmd!
  autocmd VimResized * if &equalalways | wincmd = | endif
augroup end

"--------------  Themes  -------------------------

if has('termguicolors')
  set termguicolors
endif

" For dark version.
set background=dark

" Other options
let g:everforest_enable_italic = 1
let g:everforest_transparent_background = 1
let g:everforest_cursor = 'auto'
let g:everforest_ui_contrast = 'high'
let g:everforest_show_eob = 1
let g:everforest_diagnostic_text_highlight = 1
let g:everforest_diagnostic_line_highlight = 0
let g:everforest_better_performance = 1

" Use this color scheme
colorscheme everforest

"--------------  Lualine  ------------------------

lua << END
-- Customized config
require("nvim-gps").setup({

	disable_icons = false,           -- Setting it to true will disable all icons

	icons = {
		["class-name"] = ' ',      -- Classes and class-like objects
		["function-name"] = ' ',   -- Functions
		["method-name"] = ' ',     -- Methods (functions inside class-like objects)
		["container-name"] = '⛶ ',  -- Containers (example: lua tables)
		["tag-name"] = '炙'         -- Tags (example: html tags)
	},

	-- Add custom configuration per language or
	-- Disable the plugin for a language
	-- Any language not disabled here is enabled by default
	languages = {
		-- Some languages have custom icons
		["json"] = {
			icons = {
				["array-name"] = ' ',
				["object-name"] = ' ',
				["null-name"] = '[] ',
				["boolean-name"] = 'ﰰﰴ ',
				["number-name"] = '# ',
				["string-name"] = ' '
			}
		},
		["toml"] = {
			icons = {
				["table-name"] = ' ',
				["array-name"] = ' ',
				["boolean-name"] = 'ﰰﰴ ',
				["date-name"] = ' ',
				["date-time-name"] = ' ',
				["float-name"] = ' ',
				["inline-table-name"] = ' ',
				["integer-name"] = '# ',
				["string-name"] = ' ',
				["time-name"] = ' '
			}
		},
		["verilog"] = {
			icons = {
				["module-name"] = ' '
			}
		},
		["yaml"] = {
			icons = {
				["mapping-name"] = ' ',
				["sequence-name"] = ' ',
				["null-name"] = '[] ',
				["boolean-name"] = 'ﰰﰴ ',
				["integer-name"] = '# ',
				["float-name"] = ' ',
				["string-name"] = ' '
			}
		},

		-- Disable for particular languages
		-- ["bash"] = false, -- disables nvim-gps for bash
		-- ["go"] = false,   -- disables nvim-gps for golang

		-- Override default setting for particular languages
		-- ["ruby"] = {
		--	separator = '|', -- Overrides default separator with '|'
		--	icons = {
		--		-- Default icons not specified in the lang config
		--		-- will fallback to the default value
		--		-- "container-name" will fallback to default because it's not set
		--		["function-name"] = '',    -- to ensure empty values, set an empty string
		--		["tag-name"] = ''
		--		["class-name"] = '::',
		--		["method-name"] = '#',
		--	}
		--}
	},

	separator = ' > ',

	-- limit for amount of context shown
	-- 0 means no limit
	depth = 0,

	-- indicator used when context hits depth limit
	depth_limit_indicator = ".."
})

local gps = require("nvim-gps")

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'everforest',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = { { gps.get_location, cond = gps.is_available }, },
    lualine_x = {'filename'},
    lualine_y = {'filetype'},
    lualine_z = {'location'}
    },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {'location'},
    lualine_z = {}
    },
  tabline = {},
  extensions = {}
  }
END

"--------------  Text Objects  -------------------

for s:char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '$' ]
  execute 'xnoremap i' . s:char . ' :<C-u>normal! T' . s:char . 'vt' . s:char . '<CR>'
  execute 'onoremap i' . s:char . ' :normal vi' . s:char . '<CR>'
  execute 'xnoremap a' . s:char . ' :<C-u>normal! F' . s:char . 'vf' . s:char . '<CR>'
  execute 'onoremap a' . s:char . ' :normal va' . s:char . '<CR>'
endfor

"--------------  Nerdtree  -----------------------

" " Open Nerdtree shortcuts
" nmap <C-f> :NERDTreeToggle<CR>
" nnoremap <silent> <Leader>v :NERDTreeFind<CR>
" set modifiable

" " Beauty
" let NERDTreeMinimalUI = 1
" let NERDTreeDirArrows = 1

" " Convenience
" let NERDTreeQuitOnOpen = 1
" let NERDTreeAutoDeleteBuffer = 1

" " Exit Vim if NERDTree is the only window left.
" augroup nerdtreegroup
"   autocmd!
"   autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
"         \ quit | endif
" augroup end

"--------------  Treesitter  ---------------------

lua << END
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = {},

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },

  -- Incremental selection based on the named nodes from the grammar.
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  
  -- Indentation
  indent = {
    enable = true,
    disable = { "python" },
  },

  -- Treesitter text objects
  textobjects = {
    -- Swap text objects
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    -- peek definitions
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },

  -- Support for comments in embedded programming languages
  context_commentstring = {
    enable = true
  },
   matchup = {
    enable = true,              -- mandatory, false will disable the whole extension
    disable = {},  -- optional, list of language that will be disabled
    disable_virtual_text = true,
    include_match_words = true
  },
}
END


"--------------  Treesitter-Context  -------------

lua << END
require'treesitter-context'.setup {
    enable = true,
    throttle = false,
    max_lines = 0, 
    patterns = { 
        default = {
            'class',
            'function',
            'method',
        },
    },
}
END

"--------------  Coc  ----------------------------

" Correct comment highlighting
autocmd FileType json syntax match Comment +\/\/.\+$+

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

"Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

"Give more space for displaying messages.
set cmdheight=2

"Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
"delays and poor user experience.
set updatetime=300

"Don't pass messages to |ins-completion-menu|.
set shortmess+=c

"Always show the signcolumn, otherwise it would shift the text each time
"diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  "  Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

"Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"Use `[g` and `]g` to navigate diagnostics
"Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

"GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg .  " . expand('<cword>')
  endif
endfun

"Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

"Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

"Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup cocgroup0
  autocmd!
  "  Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  "  Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

"Applying codeAction to the selected region.
"Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

"Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
"Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

"Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

"Map function and class text objects
"NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap af <Plug>(coc-funcobj-a)
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <Down> coc#float#has_scroll() ? coc#float#scroll(1) : "\<Down>"
  nnoremap <silent><nowait><expr> <Up> coc#float#has_scroll() ? coc#float#scroll(0) : "\<Up>"
  inoremap <silent><nowait><expr> <Down> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <Up> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <Down> coc#float#has_scroll() ? coc#float#scroll(1) : "\<Down>"
  vnoremap <silent><nowait><expr> <Up> coc#float#has_scroll() ? coc#float#scroll(0) : "\<Up>"
endif

"Use CTRL-S for selections ranges.
"Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

"Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

"Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

"Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

"Add (Neo)Vim's native statusline support.
"NOTE: Please see `:h coc-status` for integrations with external plugins that
"provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"Mappings for CoCList
"Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"--------------  Coc-Snippets  -------------------

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfun

"--------------  Coc-Explorer  -------------------

let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'cocConfig': {
\      'root-uri': '~/.config/coc',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'tab:$': {
\     'position': 'tab:$',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   },
\   'buffer': {
\     'sources': [{'name': 'buffer', 'expand': v:true}]
\   },
\ }

" Use preset argument to open it
nmap <space>ed <Cmd>CocCommand explorer --preset .vim<CR>
nmap <space>ef <Cmd>CocCommand explorer --preset floating<CR>
nmap <space>ec <Cmd>CocCommand explorer --preset cocConfig<CR>
nmap <space>eb <Cmd>CocCommand explorer --preset buffer<CR>
nmap <space>ee  <Cmd>CocCommand explorer --preset buffer<CR>
nmap <C-e>      <Cmd>CocCommand explorer<CR>


"--------------  UltiSnips  ----------------------

let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger = "<s-tab>"
let g:ulti_expand_or_jump_res = 0
let g:UltiSnipsJumpForwardTrigger="<nop>"
let g:UltiSnipsJumpBackwardTrigger="<nop>"

nnoremap <space>u <Cmd>UltiSnipsEdit<CR>

"--------------  Git-Gutter  ---------------------

let g:gitgutter_signs = 0

"--------------  Gutentags  ----------------------

let g:gutentags_cache_dir = '~/.cache/gutentags/'
let g:gutentags_resolve_symlinks = 1

"--------------  Formating  ----------------------

" Selects correct formating app the given file
function! Format()
  if exists('b:useClangFormat')
    let l:lines="all"
    if has('python3')
      py3f ~/.config/llvm/clang-format.py
    elseif has('python')
      pyf ~/.config/llvm/clang-format.py
    endif
  endif
  if exists('b:usePrettier')
    Prettier
    return
  endif
  if exists('b:autoformat')
    Autoformat
  endif
endfun

" File formatting settings
augroup formatgroup
  autocmd!
  autocmd FileType h,c,cpp let b:useClangFormat=1
  autocmd FileType html,javascript,vue,css let b:usePrettier=1
  autocmd FileType tex let b:autoformat=1
  autocmd BufWritePre * call Format()
augroup end


"--------------  Latex  --------------------------

let g:tex_flavor = "latex"

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

let g:vimtex_compiler_method = 'latexmk'

" vim-latex-live-preview
set updatetime=500
let g:livepreview_engine = 'pdflatex'
let g:livepreview_previewer = 'okular'
let g:livepreview_texinputs = './out/'
let g:livepreview_use_biber = 1

" Quick compilation
augroup latexgroup
  autocmd!
  autocmd FileType tex nnoremap <C-l> :LLPStartPreview<CR>
  autocmd FileType tex nnoremap <CR> :AsyncRun rm out/*; latexmk -pdf -output-directory=out %<CR>
  autocmd FileType tex nnoremap <F9> :call CleanLabel()<CR>
  " autocmd FileType tex set nowrap
augroup end

function CleanLabel()
  :silent! s/[. ,]/_/g
  :silent! s/*_/_/g
  :execute "normal! guu"
endfun

let g:formatdef_latexindent = '"latexindent -c=/tmp -"'

"--------------  C++  ----------------------------

augroup cppgroup
  autocmd!
  " Quick compile && run
  autocmd FileType cpp nnoremap <C-c> :!g++ -std=c++11 % -Wall -g -o %.out && ./%.out<CR>
  autocmd FileType cpp nnoremap <C-s> :!make && gdb -tui ./bin/main.out<CR>
  autocmd FileType cpp nnoremap <C-m> :!make && ./bin/main.out<CR>
  autocmd FileType cpp nnoremap <CR> :!cmake -S src -B release ; make --directory=release ; ./release/main images/lena.jpg $@
augroup end

"--------------  C  ------------------------------

" Make *.h files C header files by default
let g:c_syntax_for_h = 1

augroup cppgroup
  autocmd!
  " Quick compile && run
  autocmd FileType cpp nnoremap <C-c> :!gcc -std=c11 % -Wall -g -o %.out && ./%.out<CR>
  autocmd FileType cpp nnoremap <C-s> :!make && gdb -tui ./bin/%.out<CR>
augroup end

"--------------  Bash  ---------------------------

augroup bashgroup
  autocmd!
  autocmd FileType sh nnoremap <CR> :!bash %<CR>
augroup end


"--------------  Python  -------------------------

augroup pythongroup
  autocmd!
  autocmd FileType python nnoremap <CR> :w <CR> <bar> :AsyncRun make run ARGS="%"<CR>
  autocmd FileType python nnoremap <F4> :w <CR> <bar> :AsyncRun make test <CR>
  autocmd BufWritePre *.py :CocCommand python.sortImports
augroup end

let g:asyncrun_open = 10

"--------------  Markdown  -----------------------

augroup markdowngroup
  autocmd!
  autocmd BufWritePre *.md call CocActionAsync('runCommand', 'markdownlint.fixAll')
augroup end

let g:mkdp_auto_close = 1
let g:mkdp_browser = 'firefox'
let $NVIM_MKDP_LOG_FILE = expand('~/mkdp-log.log')
let $NVIM_MKDP_LOG_LEVEL = 'debug'

"--------------  i3-config  ----------------------

augroup i3configgroup
  autocmd!
  autocmd BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
augroup end

"--------------  Mutt  ---------------------------

augroup muttgroup
  autocmd!
  autocmd BufReadPost *.mutt set filetype=muttrc
  autocmd BufRead,BufNewFile *mutt-* setfiletype mail
augroup end
