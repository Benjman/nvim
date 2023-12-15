return {
  'folke/which-key.nvim',
  config = function()
    local wk_map = function(name) return { name = name, _ = 'which_key_ignore' } end
    require('which-key').register({
      b = wk_map('[B]uffer'),
      d = wk_map('[D]ocument'),
      f = wk_map('[F]ile'),
      g = wk_map('[G]it'),
      l = wk_map('[L]SP'),
      n = wk_map('[N]otification'),
      r = wk_map('[R]ename'),
      s = wk_map('[S]earch'),
      S = wk_map('[S]essions'),
      T = wk_map('[T]ools'),
      w = wk_map('[W]indow'),
      W = wk_map('[W]orkspace'),
    }, { prefix = '<leader>' })
  end,
}
