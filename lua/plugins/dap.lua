return {
  "mfussenegger/nvim-dap",
  opts = function(_, _)
    require("dap").adapters.lldb = {
      type = "executable",
      command = "codelldb",
      name = "codelldb",
    }
  end,

  -- stylua: ignore
  keys = {
    { "<M-c>", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<M-l>", function() require("dap").step_into() end, desc = "Step Into" },
    { "<M-k>", function() require("dap").step_out() end, desc = "Step Out" },
    { "<M-j>", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dr", function() require("dapui").open({reset = true}) end, desc = "Reset UI" },
  },
}
