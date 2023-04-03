-- https://github.com/wbthomason/packer.nvim
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
    -- git wrapper
    use 'tpope/vim-fugitive'
    -- highlight trailing whitespace
    use 'ntpeters/vim-better-whitespace'

    -- Editing
    use 'tpope/vim-surround'
    use 'L3MON4D3/LuaSnip'

    -- abolish will convert between snake_case (crs), StudlyCaps (crm), cameCase
    -- (crc), UPPER_CASE (cru), kebab-case (cr-), dot.case (cr.), space case
    -- (cr<space>), Title Case (crt)
    use 'tpope/vim-abolish'
    -- auto set buffer options like sw, ts, expandtab
    use 'tpope/vim-sleuth'
    -- bulk comments
    use 'tpope/vim-commentary'
    -- align data (gl, gL)
    use 'tommcdo/vim-lion'
    -- let g:lion_squeeze_spaces = 1

    -- Completion
    use("hrsh7th/nvim-cmp")
    use({
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      after = { "hrsh7th/nvim-cmp" },
      requires = { "hrsh7th/nvim-cmp" },
    })

    -- IDE
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'neovim/nvim-lspconfig'
    use { 'ojroques/nvim-lspfuzzy',
      requires = {
         {'junegunn/fzf'},
         {'junegunn/fzf.vim'},
      },
    }
    use("nvim-lua/popup.nvim")
    use {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.1',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-ui-select.nvim' }
    use 'mhartington/formatter.nvim'
    --use {'kevinhwang91/nvim-bqf', ft = 'qf'}
    -- visualize lsp  progress
    use({
      "j-hui/fidget.nvim",
      config = function()
        require("fidget").setup()
      end
    })
    use('simrat39/inlay-hints.nvim')

    -- Languages
    -- https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins
    -- rust.vim so that `compiler cargo` is set
    use 'simrat39/rust-tools.nvim'
    use {
      'Saecki/crates.nvim',
      event = { "BufRead Cargo.toml" },
      requires = { { 'nvim-lua/plenary.nvim' } },
      config = function()
          require('crates').setup()
      end,
    }
    -- https://kushellig.de/neovim-php-ide/ has many good tips
    use 'phpactor/phpactor'
    use 'stephpy/vim-php-cs-fixer'
    use 'alvan/vim-php-manual'
    --use 'ray-x/go.nvim'
    use 'vimwiki/vimwiki'
    -- let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.wiki'}]

    use {
      'lewis6991/spellsitter.nvim',
      config = function()
        require('spellsitter').setup()
      end
    }

    -- use { 'weihanglo/polar.vim', config = function() require'polar'.setup() end }

    -- Maybes
    use 'rstacruz/vim-closer'
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
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = { 'clangd', 'rust_analyzer', 'pyright', 'intelephense', 'phpactor' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end


require("inlay-hints").setup()
local ih = require("inlay-hints")
local rt = require("rust-tools")
rt.setup({
  tools = {
    on_initialized = function()
      ih.set_all()
    end,
    inlay_hints = {
      auto = true,
    },
  },
  server = {
    on_attach = function(c, bufnr)
      ih.on_attach(c, bufnr)
      -- This callback is called when the LSP is attached/enabled for this buffer
      -- we could set keymaps related to LSP, etc here.
      local keymap_opts = { buffer = buffer }
      -- Code navigation and shortcuts
      vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, keymap_opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
      vim.keymap.set("n", "gD", vim.lsp.buf.implementation, keymap_opts)
      vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, keymap_opts)
      vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, keymap_opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
      vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
      vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
      vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, keymap_opts)
    end,
  },
})

local cmp = require'cmp'

cmp.setup({
    preselect = cmp.PreselectMode.None,
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
      --['<Esc>'] = cmp.mapping.close(),
      ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),

    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
      { name = 'buffer' },
      { name = "crates" },
    },
})

-- https://github.com/mhartington/formatter.nvim/blob/master/CONFIG.md
require('formatter').setup({
  filetype = {
    rust = {
      function()
        return {
          exe = "rustfmt",
          args = {"--edition=2021", "--emit=stdout"},
          stdin = true
        }
      end
    },
  }
})

vim.opt.shortmess = vim.opt.shortmess + "c"

require("telescope").setup {}
require("telescope").load_extension("ui-select")

vim.cmd([[
  autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
  let g:php_cs_fixer_config_file = '~/.php_cs.dist.php'
]])

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.rs FormatWrite
augroup END
]], true)
