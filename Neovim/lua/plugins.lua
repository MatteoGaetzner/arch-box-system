vim.cmd [[packadd packer.nvim]]

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' 
    use {
        'neoclide/coc.nvim',
        branch = 'release'
    }

    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'JuliaEditorSupport/julia-vim'
    use 'SirVer/ultisnips'
    use 'adborden/vim-notmuch-address'
    use 'airblade/vim-gitgutter'
    -- use {
    --     'autozimu/LanguageClient-neovim', 
    --     branch = 'next',
    --     run = 'bash install.sh'
    -- }
    use 'godlygeek/tabular'
    use 'honza/vim-snippets'
    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install'  
    }
    use 'jiangmiao/auto-pairs'
    use 'kevinoid/vim-jsonc'
    use 'kyazdani42/nvim-web-devicons'
    use 'lervag/vimtex'
    use 'ludovicchabant/vim-gutentags'
    use 'mboughaba/i3config.vim'
    use 'neomake/neomake'
    use 'nvim-lualine/lualine.nvim'
    use {
        'nvim-treesitter/nvim-treesitter', 
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'p00f/nvim-ts-rainbow'
    use 'sainnhe/everforest'
    use {
        'sakhnik/nvim-gdb', 
        run = ':!./install.sh'
    }
    use 'skywind3000/asyncrun.vim'
    use 'svermeulen/vim-easyclip'
    use 'tpope/vim-abolish'
    use 'tpope/vim-commentary'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'
    use 'vim-autoformat/vim-autoformat'
    use 'vim-scripts/ReplaceWithRegister'
    use 'xuhdev/vim-latex-live-preview'
    use 'airblade/vim-rooter'
    use 'rust-lang-nursery/rustfmt'
    use 'ellisonleao/glow.nvim'
    -- use 'nvim-treesitter/playground'

    if packer_bootstrap then
        require('packer').sync()
    end
end)
