-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})

-- highlight on yank text
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
  group = vim.api.nvim_create_augroup('TextYankPost_hl_on_yank', { clear = true }),
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('b-lsp-attach', { clear = true }),
  callback = function(args)
    local blsp = require 'b.lsp'
    blsp.init()
    blsp.set_lsp_keymaps(args.buf)

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client.server_capabilities.documentFormattingProvider then return end
    if client.name == 'tsserver' then return end
    client.server_capabilities.semanticTokensProvider = nil

    vim.api.nvim_create_autocmd('BufWritePre', {
      group = blsp.fmt_get_augroup(client),
      buffer = args.buf,
      callback = function()
        if not blsp.fmt_is_enabled then return end
        vim.lsp.buf.format {
          async = false,
          filter = function(c)
            return c.id == client.id
          end,
        }
      end,
    })
  end,
})
