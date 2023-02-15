set nocompatible  " be iMproved, required

let vimrcDir = "~/setup/configs/vim"
" With a map leader it's possible to do extra key combinations
let mapleader = " "

let config_files = [
        \ "plugins.vim",
        \ "coc.vim",
        \ "keymappings.vim",
        \ "helpers.vim",
        \ "settings.vim",
        \ ]
for filename in config_files
  let source_cmd = "source " . vimrcDir . "/" . filename
  exec source_cmd
endfor


if has('nvim')
  for lua_file in [
        \ "nvim_tree.lua",
        \ ]
    exec "luafile " . vimrcDir . "/lua/" . lua_file
  endfor
endif

