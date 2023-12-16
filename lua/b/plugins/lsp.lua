return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    config = function()
      -- mason-lspconfig requires that these setup functions are called in this order
      -- before setting up the servers.
      require('mason').setup()
      require('mason-lspconfig').setup()

      --  Add any additional override configuration in the following tables. They will be passed to the `settings` field of the server config. You must look up that documentation yourself.
      --
      --  If you want to override the default filetypes that your language server will attach to you can
      --  define the property 'filetypes' to the map in question.
      local servers = {
        clangd = {},

        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }

      local on_attach = function(_, bufnr)
        local desc = function(desc)
          return { buffer = bufnr, desc = desc }
        end

        vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, desc('[L]SP: [R]ename'))
        vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, desc('[L]SP: Code [A]ction'))

        vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, desc('[G]oto [D]efinition'))
        vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, desc('[G]oto [R]eferences'))
        vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations, desc('[G]oto [I]mplementation'))
        vim.keymap.set('n', '<leader>lD', require('telescope.builtin').lsp_type_definitions, desc('[L]SP: Type [D]efinition'))
        vim.keymap.set('n', '<leader>lSd', require('telescope.builtin').lsp_document_symbols, desc('[L]SP: [S]ymbols [D]ocument'))
        vim.keymap.set('n', '<leader>lSw', require('telescope.builtin').lsp_dynamic_workspace_symbols, desc('[L]SP: [S]ymbols [W]orkspace'))
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, desc('Hover Documentation'))
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, desc('Signature Documentation'))
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, desc('[G]oto [D]eclaration'))
        vim.keymap.set('n', '<leader>Wa', vim.lsp.buf.add_workspace_folder, desc('[W]orkspace [A]dd Folder'))
        vim.keymap.set('n', '<leader>Wr', vim.lsp.buf.remove_workspace_folder, desc('[W]orkspace [R]emove Folder'))
        vim.keymap.set('n', '<leader>lst', '<cmd>LspStop<cr>', desc('[L]SP [S]erver: S[t]op'))

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
        vim.keymap.set('n', '<leader>df', '<cmd>Format<cr>', desc('[D]ocument [F]ormat'))

        require('which-key').register({
          s = { name = '[L]SP [S]erver', _ = 'which_key_ignore' },
          S = { name = '[L]SP [S]ymbols', _ = 'which_key_ignore' },
        }, { prefix = '<leader>l' })

        local signs = { Error = '', Info = '', Hint = '', Warn = '' }
        for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
      end

      -- Setup neovim lua configuration
      require('neodev').setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end,
      }
    end,
    dependencies = {
      'folke/neodev.nvim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
    },
  },

  {
    'hrsh7th/nvim-cmp',
    config = function()
      -- [[ Configure nvim-cmp ]]
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'luasnip' },
        },
      })
    end,
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      'hrsh7th/cmp-path',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  {
    -- LSP context
    'utilyre/barbecue.nvim',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
    },
  },
}
