return {
  "mfussenegger/nvim-dap",

  -- stylua: ignore
  keys = {
    { "<M-c>", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<M-l>", function() require("dap").step_into() end, desc = "Step Into" },
    { "<M-k>", function() require("dap").step_out() end, desc = "Step Out" },
    { "<M-j>", function() require("dap").step_over() end, desc = "Step Over" },
  },
}
