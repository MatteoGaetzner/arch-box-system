cmd("filetype plugin indent on")

g.mapleader = " " -- sets the leader key for key stroke combinations
g.python3_host_prog = os.getenv("HOME").."/.mambaforge/envs/neovim/bin/python3" -- python3 executable
g.python_host_prog =  os.getenv("HOME").."/.mambaforge/envs/neovim-python2/bin/python2" -- python2 executable
g.vimsyn_folding = 'afP' -- enables folding of augroups, functions, python in vimscript

opt.belloff = "all" -- disable bell ringing feedback (e.g. on error)
opt.completeopt = "menuone,longest" -- show menu even if only one match, sort by length
opt.incsearch = true -- moves to the search result upon typing the pattern
opt.smartcase = true -- enables smart search pattern matching wrt. case
opt.ignorecase = true -- enables case insensitive search pattern matching wrt. case
opt.hlsearch = false -- turns off persistent highlighting of search results
opt.startofline = false -- makes CTRL-D and CTRL-U keep column after moving up/down
opt.mouse = "a" -- enables mouse support for all modes (insert, normal, visual etc.)
opt.scrolloff = 10 -- sets minimum lines between cursor and top/bottom of file
opt.shiftwidth = 4 -- sets how many spaces to use for indentation
opt.shortmess = "filnxtToOFc" -- limit insert mode completion messages
opt.ttimeoutlen = 25 -- wait 25 milliseconds for a mapped sequence to complete
opt.complete = ".,w,b,u,t,kspell" -- use the currently active spell checking for insert mode completions
opt.expandtab = true -- fills indented whitespaces with spaces (instead of tabs)
opt.smartindent = true -- enables smart indentation when starting a new line
opt.tabstop = 4 -- sets option 2 from the :h 'tabstop' manual
opt.syntax = 'on' -- enables syntax highlighting
opt.number = true -- enables current line number on the left
opt.relativenumber = true -- enables relative line numbers
opt.wrap = false -- disables wrapping lines
opt.backup = false -- disable neovim from creating backups (useless)
opt.directory = os.getenv("HOME").."/.cache/vim/swap/" -- sets the directory where swap files get saved
opt.undodir = os.getenv("HOME").."/.cache/vim/undo/" -- sets the directory where undo histories get saved
opt.undofile = true -- enables the use of undofiles
opt.undolevels = 1000 -- sets the maximum number of changes that can be undone
opt.clipboard = "unnamedplus"
