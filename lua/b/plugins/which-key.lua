return {
  'folke/which-key.nvim',
  config = function()
    require('which-key').register({
      ['<leader>'] = {
        b = { name = '[B]uffer', _ = 'which_key_ignore' },
        d = { name = '[D]ocument', _ = 'which_key_ignore' },
        f = { name = '[F]ile', _ = 'which_key_ignore' },
        g = { name = '[G]it', _ = 'which_key_ignore' },
        r = { name = '[R]ename', _ = 'which_key_ignore' },
        s = { name = '[S]earch', _ = 'which_key_ignore' },
        S = { name = '[S]essions', _ = 'which_key_ignore' },
        w = { name = '[W]indow', _ = 'which_key_ignore' },
      },
    })
  end,
}
