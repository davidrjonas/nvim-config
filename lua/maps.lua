-- maps.lua

local map = vim.api.nvim_set_keymap

vim.g.mapleader = ','

options = { noremap = true }

map('v', '>', '>gv', options)
map('v', '<', '<gv', options)
map('n', '<Leader>i', ':e ~/.config/nvim<CR>', options)
map('n', '<Leader>x', ':%s/\\s\\+$//g<CR>', options)
map('n', '<Leader>b', ':b#<CR>', options)
map('n', '<Leader>z', '1z=', options)
map('n', '<Leader>n', ':lne<CR>', options)
map('n', '<Leader>p', ':set invpaste<CR>', options)
map('n', '<Leader>g', ':Telescope live_grep<CR>', options)

-- uh, do I use these?
map('n', '<Leader>f', 'gqis', options)
--map('n', '<Leader><Leader>', ':TagbarToggle<CR>', options)

-- vimwiki
--
map('n', '<Leader>vs', ':Vwrg<CR>', options)
map('n', '<Leader>vn', ':VimwikiDiaryNextDay<CR>', options)
map('n', '<Leader>vp', ':VimwikiDiaryPrevDay<CR>', options)
