require "nvchad.options"

-- add yours here!

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
o.relativenumber = true
o.noswapfile = true
o.nobackup = true
o.noerrorbells = true
o.expandtab = true
o.smarttab = true
-- o.shiftwidth = 2
o.undofile = true
o.smartindent = true
o.autoread = true
o.cursorline = true
o.updatetime = true
o.scrolloff = 5
o.clipboard = 'unnamedplus'
-- WSL yank support
vim.cmd [[
  let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
  if executable(s:clip)
      augroup WSLYank
          autocmd!
          autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
      augroup END
  endif
]]

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
