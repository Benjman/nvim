local present, gs = pcall(require, 'gitsigns')
if not present then return end

gs.setup {
  signs = {
    add = { hl = 'GitSignsAdd', text = '+', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
  },
  current_line_blame_formatter = '<author_time:%Y-%m-%d> (<abbrev_sha>) - <summary>',
  word_diff = false,
  linehl = true,
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      -- opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, desc = 'next hunk' })

    map('n', '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, desc = 'previous hunk' })
  end,
}

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.cmd [[
      hi GitSignsChangeInline gui=reverse
      hi GitSignsAddInline gui=reverse
      hi GitSignsDeleteInline gui=reverse
    ]]
  end
})

local function opts(desc)
  return { desc = 'GitSigns: ' .. desc }
end

require('b.utils').apply_keymaps {
  { 'n', '<leader>gb', ':Gitsigns blame_line<cr>', opts('Blame line') },
  { 'n', '<leader>gB', ':Gitsigns toggle_current_line_blame<cr>', opts('Blame line toggle') },
}
