vim.cmd('set background=dark')

vim.cmd('let g:gruvbox_bold = 1')
vim.cmd('let g:gruvbox_contrast_dark = "hard"')
vim.cmd('let g:gruvbox_invert_signs = 1')
vim.cmd('let g:gruvbox_italic = 1')
vim.cmd('let g:gruvbox_italicize_comments = 1')
vim.cmd('let g:gruvbox_sign_column = "bg0"')
vim.cmd('let g:gruvbox_undercurl = 1')
vim.cmd('let g:gruvbox_underline = 1')

vim.cmd('colorscheme gruvbox')
--vim.cmd('colorscheme badwolf')

-- https://jdhao.github.io/2020/09/22/highlight_groups_cleared_in_nvim/
-- https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
-- https://vi.stackexchange.com/questions/3355/why-do-custom-highlights-in-my-vimrc-get-cleared-or-reset-to-default
-- https://superuser.com/questions/466662/vim-how-to-auto-sync-custom-syntax-highlight-rules-when-colorscheme-changes
vim.cmd([[
augroup custom_highlight
  autocmd!
  au ColorScheme * highlight EoLSpace ctermbg=52 guibg=52
               \ | match EoLSpace /\s\+$/
augroup END
]])
