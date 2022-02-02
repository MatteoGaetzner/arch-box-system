#!/bin/bash

i3-msg workspace 7
i3-msg move workspace to output left
i3-msg append_layout $HOME/.config/i3/layouts/bsprak_left.json;

kitty -d $HOME/Sync/University/WS2122Betriebssystempraktikum/Solutions/ &
kitty -d $HOME/Sync/University/WS2122Betriebssystempraktikum/Solutions/ zsh -c "nvim ." &
kitty -d $HOME/Isis/Courses/WS2021Betriebssystempraktikum/ zsh -c "vifm" &
firefox

i3-msg workspace 8
i3-msg move workspace to output right
i3-msg append_layout $HOME/.config/i3/layouts/bsprak_right.json;
kitty -d $HOME/Sync/University/WS2122Betriebssystempraktikum/Solutions/ &

firefox
