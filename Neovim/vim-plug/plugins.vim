" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'JuliaEditorSupport/julia-vim'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'honza/vim-snippets'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lervag/vimtex'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neomake/neomake'
Plug 'nvim-lualine/lualine.nvim'
Plug 'sainnhe/everforest'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
Plug 'scrooloose/NERDTree'
Plug 'sheerun/vim-polyglot'
Plug 'skywind3000/asyncrun.vim'
Plug 'svermeulen/vim-easyclip'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-autoformat/vim-autoformat'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'xuhdev/vim-latex-live-preview'
Plug 'python-rope/ropevim'
Plug 'mboughaba/i3config.vim'

Plug 'untitled-ai/jupyter_ascending.vim'

call plug#end()
