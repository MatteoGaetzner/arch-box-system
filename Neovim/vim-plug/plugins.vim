" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'SirVer/ultisnips'
Plug 'SmiteshP/nvim-gps'
Plug 'adborden/vim-notmuch-address'
Plug 'airblade/vim-gitgutter'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'jiangmiao/auto-pairs'
Plug 'kevinoid/vim-jsonc'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'lervag/vimtex'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mboughaba/i3config.vim'
Plug 'neomake/neomake'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'p00f/nvim-ts-rainbow'
Plug 'sainnhe/everforest'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
Plug 'skywind3000/asyncrun.vim'
Plug 'svermeulen/vim-easyclip'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-autoformat/vim-autoformat'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'xuhdev/vim-latex-live-preview'

" Wait for these plugins to get fixed
Plug 'andymass/vim-matchup'

call plug#end()
