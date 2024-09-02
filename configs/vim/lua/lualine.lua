require('lualine').setup{
  extensions = {'fugitive', 'fzf', 'nvim-tree'},
  tabline = {
    lualine_a = {'buffers'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'tabs'}
  }
}

