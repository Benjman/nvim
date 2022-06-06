local handlers = require "user.lsp.handlers"

return {
  on_attach = function (client, bufnr)
    handlers.on_attach(client, bufnr)
    handlers.enable_format_on_save(bufnr)
  end
}
