set nocompatible  " be iMproved, required

let vimrcDir = "~/setup/configs/vim"
" With a map leader it's possible to do extra key combinations
let mapleader = " "


execute "source " . vimrcDir . "/plugins.vim"
execute "source " . vimrcDir . "/keymappings.vim"
execute "source " . vimrcDir . "/helpers.vim"
execute "source " . vimrcDir . "/settings.vim"

