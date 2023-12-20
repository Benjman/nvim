local function augroup(name)
  return vim.api.nvim_create_augroup("b_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Protect GPG files
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = {
    '*.asc',
    '*.gpg',
    '*.pgp'
  },
  callback = function()
    vim.bo.filetype = 'text'
    vim.bo.swapfile = false
    vim.opt.backup = false
  end,
})

-- Show diagnostics under the cursor when holding position
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  pattern = "*",
  callback = function()
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(winid).zindex then
        return
      end
    end
    vim.diagnostic.open_float({
      scope = "cursor",
      focusable = false,
      close_events = {
        "CursorMoved",
        "CursorMovedI",
        "BufHidden",
        "InsertCharPre",
        "WinLeave",
      },
    })
  end,
  group = augroup("lsp_diagnostics_hold"),
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup('LspConfig'),
  callback = function(args)
    local bufnr = args.buf

    local desc = function(desc)
      return { buffer = bufnr, desc = desc }
    end
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, desc('[L]SP: [R]ename'))
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, desc('[L]SP: Code [A]ction'))

    vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, desc('[G]oto [D]efinition'))
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, desc('[G]oto [R]eferences'))
    vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations, desc('[G]oto [I]mplementation'))
    vim.keymap.set('n', '<leader>lD', require('telescope.builtin').lsp_type_definitions,
      desc('[L]SP: Type [D]efinition'))
    vim.keymap.set('n', '<leader>lSd', require('telescope.builtin').lsp_document_symbols,
      desc('[L]SP: [S]ymbols [D]ocument'))
    vim.keymap.set('n', '<leader>lSw', require('telescope.builtin').lsp_dynamic_workspace_symbols,
      desc('[L]SP: [S]ymbols [W]orkspace'))
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
    vim.keymap.set('n', '<leader>Df', '<cmd>Format<cr>', desc('[D]ocument [F]ormat'))

    require('which-key').register({
      s = { name = '[L]SP [S]erver', _ = 'which_key_ignore' },
      S = { name = '[L]SP [S]ymbols', _ = 'which_key_ignore' },
    }, { prefix = '<leader>l' })

    local signs = { Error = '', Info = '', Hint = '', Warn = '' }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
  end,
})
