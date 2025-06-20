return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  opts = function()
    require("dap").adapters = {
      lldb = require("plugins.dap.lldb"),
    }
  end,

  keys = function()
    local dap = require("dap")
    local widgets = require("dap.ui.widgets")
    local continue = dap.continue
    local reset_ui = function()
      dap.open({ reset = true })
    end
    local run_to_cursor = dap.run_to_cursor
    local step_into = dap.step_into
    local step_out = dap.step_out
    local step_over = dap.step_over
    local terminate = dap.terminate
    local toggle_breakpoint = dap.toggle_breakpoint
    local hover = widgets.hover
    local preview = widgets.preview
    local cf_frames = function()
      widgets.centered_float(widgets.frames)
    end
    local cf_scopes = function()
      widgets.centered_float(widgets.scopes)
    end
    return {
      { "<Leader>db", toggle_breakpoint, desc = "Dap Toggle Breakpoint" },
      { "<Leader>dc", continue, desc = "Dap Continue" },
      { "<Leader>df", cf_frames, desc = "Dap Frames" },
      { "<Leader>dh", hover, desc = "Dap Hover", mode = { "n", "v" } },
      { "<Leader>dp", hover, desc = "Dap Preview", mode = { "n", "v" } },
      { "<Leader>dp", hover, desc = "Dap Preview", mode = { "n", "v" } },
      { "<Leader>ds", cf_scopes, desc = "Dap Scopes" },
      { "<Leader>dt", terminate, desc = "Dap Continue with Args" },
      { "<Leader>dU", reset_ui, desc = "Dap UI Reset" },
      { "<M-c>", run_to_cursor, desc = "Dap Run to Cursor" },
      { "<M-j>", step_over, desc = "Dap Step Over" },
      { "<M-k>", step_out, desc = "Dap Step Out" },
      { "<M-l>", step_into, desc = "Dap Step Into" },
    }
  end,
}
