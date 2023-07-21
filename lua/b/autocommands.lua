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
