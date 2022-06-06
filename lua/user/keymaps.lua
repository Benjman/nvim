local M = {}
local opts = { noremap = true, silent = true }
local set = vim.keymap.set
local cmd = function (c) return "<cmd>" .. c .. "<cr>" end
local pickers = require 'user.telescope.pickers'

M.setup = function ()
  set({"i", "n"}, "<C-i>",   cmd "lua vim.lsp.buf.signature_help()",          opts)
  set("n", "<C-Down>",       cmd "resize +2",                                 opts) -- window resizing
  set("n", "<C-Left>",       cmd "vertical resize -2",                        opts) -- window resizing
  set("n", "<C-Right>",      cmd "vertical resize +2",                        opts) -- window resizing
  set("n", "<C-Up>",         cmd "resize -2",                                 opts) -- window resizing
  set("n", "<C-h>",          "<C-w>h",                                        opts) -- window navigation
  set("n", "<C-j>",          "<C-w>j",                                        opts) -- window navigation
  set("n", "<C-k>",          "<C-w>k",                                        opts) -- window navigation
  set("n", "<C-l>",          "<C-w>l",                                        opts) -- window navigation
  set("n", "<C-n>",          cmd "cnext",                                     opts) -- jump to next item in quickfix list
  set("n", "<C-p>",          cmd "cprev",                                     opts) -- jump to previous item in quickfix list
  set("n", "<C-q>",          cmd "cclose",                                    opts) -- close quickfix list
  set("n", "<leader>e",      cmd "RnvimrToggle",                              opts)
  set("n", "<leader>lI",     cmd "LspInstallInfo",                            opts)
  set("n", "<leader>la",     cmd "lua vim.lsp.buf.code_action()",             opts)
  set("n", "<leader>li",     cmd "LspInfo",                                   opts)
  set("n", "<leader>lr",     cmd "lua vim.lsp.buf.rename()",                  opts)
  set("n", "gv",             cmd "vert split | lua vim.lsp.buf.definition()", opts) -- goes to definition in a vertical split
  set("n", "gs",             cmd "split      | lua vim.lsp.buf.definition()", opts) -- goes to definition in a split
  set("v", "<",              "<gv",                                           opts) -- indentation without leaving visual mode
  set("v", ">",              ">gv",                                           opts) -- indentation without leaving visual mode
  set("v", "p",              '"_dP',                                          opts) -- replace selected with yanked
  set("x", "J",              cmd "move '>+1gv-gv",                            opts) -- move selected down
  set("x", "K",              cmd "move '<-2gv-gv",                            opts) -- move selected up

  set("n", "<leader>f",  pickers.find_files, opts)
  set("n", "<leader>F",  pickers.live_grep,  opts)
  set("n", "<leader>tb", pickers.buffers,    opts)
  set("n", "<leader>th", pickers.help_tags,  opts)
end

M.lsp = function (bufnr)
  local lsp_opts = vim.tbl_deep_extend("force", { buffer = bufnr }, opts)
  -- set("n", "<C-k>", cmd "lua vim.lsp.buf.signature_help()",                  lsp_opts)
  -- set("n", "<leader>ca", cmd "lua vim.lsp.buf.code_action()",                lsp_opts)
  -- set("n", "<leader>f", cmd "lua vim.diagnostic.open_float()",               lsp_opts)
  -- set("n", "<leader>q", cmd "lua vim.diagnostic.setloclist()",               lsp_opts)
  -- set("n", "<leader>rn", cmd "lua vim.lsp.buf.rename()",                     lsp_opts)
  set("n", "K", cmd "lua vim.lsp.buf.hover()",                                  lsp_opts)
  -- set("n", "[d", cmd 'lua vim.diagnostic.goto_prev({ border = "rounded" })', lsp_opts)
  -- set("n", "]d", cmd 'lua vim.diagnostic.goto_next({ border = "rounded" })', lsp_opts)
  set("n", "gD", cmd "lua vim.lsp.buf.declaration()",                           lsp_opts)
  set("n", "gI", cmd "lua vim.lsp.buf.implementation()",                        lsp_opts)
  set("n", "gd", cmd "lua vim.lsp.buf.definition()",                            lsp_opts)
  set("n", "gl", cmd "lua vim.diagnostic.open_float()",                         lsp_opts)
  set("n", "gr", pickers.lsp_references,                                        lsp_opts)
  set("x", "<leader>f", vim.lsp.buf.range_formatting,                           lsp_opts)

  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]] -- TODO 0.7 autocommands
end

M.lsp_installer = function ()
  return {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
    }
end

M.cmp = function (cmp, luasnip)

  local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
  end

  return {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    -- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  }
end

return M
