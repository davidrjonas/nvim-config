-- https://github.com/wbthomason/packer.nvim
--
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim \
-- ~/.local/share/nvim/site/pack/packer/start/packer.nvim

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- UI
    use 'sjl/badwolf'
    use 'morhetz/gruvbox'
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function() require('lualine').setup({
            options = {theme = 'auto'}
        }) end
    }
    use 'mhinz/vim-signify'
    use 'tpope/vim-fugitive'

    -- Editing
    use 'tpope/vim-surround'
    use 'L3MON4D3/LuaSnip'
    -- let g:UltiSnipsSnippetDirectories = [$HOME.'/Documents/dotfiles/UltiSnips']
    -- let g:UltiSnipsExpandTrigger="<tab>"
    -- let g:UltiSnipsJumpForwardTrigger="<tab>"
    -- let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

    -- abolish will convert between snake_case (crs), StudlyCaps (crm), cameCase
    -- (crc), UPPER_CASE (cru), kebab-case (cr-), dot.case (cr.), space case
    -- (cr<space>), Title Case (crt)
    use 'tpope/vim-abolish'
    use 'tpope/vim-sleuth'
    use 'tpope/vim-commentary'
    use 'tommcdo/vim-lion'
    -- let g:lion_squeeze_spaces = 1

    -- Completion
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use {
        'hrsh7th/nvim-cmp',
        config = function() require('cmp').setup({
            completion = {
                completeopt = 'menu,menuone,noinsert',
            },
            snippet = {
              expand = function(args)
                require('luasnip').lsp_expand(args.body)
              end,
            },
            mapping = {
              ['<Tab>'] = function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                else
                  fallback()
                end
              end,
            },
            sources = {
              { name = 'nvim_lsp' },
              { name = 'luasnip' },
            },
        }) end
    }

    -- IDE
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'ojroques/nvim-lspfuzzy'
    use {
      'nvim-telescope/telescope.nvim',
      requires = { 'nvim-lua/plenary.nvim' }
    }

    use 'vimwiki/vimwiki'
    -- let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.wiki'}]

    -- Languages
    --use 'ray-x/go.nvim'

    -- Maybes
    --use '9mm/vim-closer'
    --use {
    --    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    --    config = function() require('gitsigns').setup() end
    --}
    --use 'tpope/vim-unimpaired'
end)

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local nvim_lsp = require'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = { 'clangd', 'rust_analyzer', 'pyright', 'intelephense' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end
