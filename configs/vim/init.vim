set nocompatible  " be iMproved, required

let vimrcDir = "~/setup/configs/vim"
" With a map leader it's possible to do extra key combinations
let mapleader = " "

for filename in [
        \ "plugins.vim",
        \ "coc.vim",
        \ "keymappings.vim",
        \ "helpers.vim",
        \ "settings.vim",
        \ ]
  exec "source " . vimrcDir . "/" . filename
endfor

if has('nvim')
  for lua_file in [
        \ "init.lua",
        \ "nvim_tree.lua",
        \ ]
    exec "luafile " . vimrcDir . "/lua/" . lua_file
  endfor
endif

