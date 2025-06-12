return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = function()
    local ht = require("hardtime")
    local toggleOpts = {
      id = "hardtime",
      name = "Hardtime",
      get = function()
        return ht.is_plugin_enabled
      end,
      set = function(state)
        if state then
          ht.enable()
        else
          ht.disable()
        end
      end,
    }
    Snacks.toggle.new(toggleOpts):map("<leader>uH")
  end,
}
