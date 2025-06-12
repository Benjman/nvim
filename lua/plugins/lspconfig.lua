local lsp_clients_popup = require("custom.lsp").lsp_clients_popup

return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      bashls = {},
    },
  },
  keys = {
    { "<Leader>cL", lsp_clients_popup, desc = "Show Client" },
  },
}
