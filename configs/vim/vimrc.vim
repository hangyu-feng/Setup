set nocompatible  " be iMproved, required

let currDir = expand("%:p:h")

execute "source " . currDir . "/plugins.vim"
execute "source " . currDir . "/keymappings.vim"
execute "source " . currDir . "/helpers.vim"
execute "source " . currDir . "/settings.vim"

