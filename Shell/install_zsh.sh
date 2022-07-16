#!/bin/bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone git@github.com:ryanoasis/nerd-fonts.git /tmp/nerd-fonts
cd /tmp/nerd-fonts
./install.sh
cd -
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode}
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone https://github.com/mroth/evalcache ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/evalcache
curl -sS https://webinstall.dev/zoxide | bash
curl -sfL https://direnv.net/install.sh | bash
curl https://sh.rustup.rs -sSf | sh
cargo install exa

if [[ -f "$HOME/.zshrc" ]]; then
    mv ~/.zshrc ~/.zshrc.bak
    echo "Moved old '~/.zshrc' to '~/.zshrc.bak"
fi

curl https://raw.githubusercontent.com/MatteoGaetzner/arch-box-system/main/Zsh/.zshrc > ~/.zshrc

curl -s https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh > /tmp/miniconda.sh
bash /tmp/miniconda.sh; rm /tmp/miniconda.sh
conda install mamba -n base -c conda-forge

git clone https://github.com/esc/conda-zsh-completion $HOME/.local/share/conda-zsh-completion

echo "Automatic install currently not supported for:"
echo "  - bat: https://github.com/sharkdp/bat/releases"

exec zsh
