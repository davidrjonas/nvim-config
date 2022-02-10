-- If you’re not sure if an option is global, buffer or window-local, consult the Vim help! For example, :h 'number':
local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- global options
o.dir = '/tmp'
o.hidden = true
o.hlsearch = true
o.incsearch = true
o.laststatus = 2
o.list = true
o.listchars = 'tab:>~,trail: '
o.smartcase = true
o.swapfile = true

--o.ignorecase = true
--o.scrolloff = 12

-- window-local options
wo.number = false
wo.wrap = false
wo.foldenable = false

-- buffer-local options
bo.expandtab = true
o.shiftwidth = 4
o.tabstop = 4

-- per type
vim.cmd('autocmd Filetype yaml setlocal ts=2 sw=2 sts=0 expandtab foldmethod=indent')
