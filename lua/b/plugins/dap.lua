return {
  'mfussenegger/nvim-dap',
  config = function()
    require('dap').adapters.lldb = {
      type = 'executable',
      command = '/home/ben/.local/bin/lldb-dap',
      name = 'lldb',
    }

    local lldb = {
      name = "Launch lldb",
      type = 'lldb',
      request = 'launch',
      program = function()
        local path = vim.fn.getcwd() .. '/'
        if vim.fn.isdirectory(path .. 'build') then
          path = path .. 'build/'
        end
        path = vim.fn.input({
          prompt = 'Path to executable: ',
          default = path,
          completion = 'file',
        })
        require('dapui').open()
        return path
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {
      },
      runInTerminal = false,
    }

    require('dap').configurations.cpp = {
      lldb
    }

    vim.keymap.set('n', '<leader>dc', require('dap').continue, { desc = '[C]ontinue' })
    vim.keymap.set('n', '<f10>', require('dap').step_over, { desc = 'Step Over' })
    vim.keymap.set('n', '<f11>', require('dap').step_into, { desc = 'Step Into' })
    vim.keymap.set('n', '<f12>', require('dap').step_out, { desc = 'Step Out' })
    vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint, { desc = 'Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dlp',
      function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    vim.keymap.set('n', '<leader>dr', require('dap').repl.open, { desc = 'Repl Open' })
    vim.keymap.set('n', '<leader>dl', require('dap').run_last, { desc = 'Run Last' })
    vim.keymap.set('n', '<leader>dt', function()
      require('dap').terminate()
      require('dapui').close()
    end, { desc = 'Terminate' })
    vim.keymap.set('n', '<leader>dR', require('dap').run_to_cursor, { desc = 'Run to cursor' })
    vim.keymap.set({ 'n', 'v' }, '<leader>dh', require('dap.ui.widgets').hover, { desc = 'Hover' })
    vim.keymap.set({ 'n', 'v' }, '<leader>dp', require('dap.ui.widgets').preview, { desc = 'Preview' })
    vim.keymap.set('n', '<leader>df', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
    end, { desc = 'Widget: Frames' })
    vim.keymap.set('n', '<leader>ds', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.scopes)
    end, { desc = 'Widget: Scopes' })

    -- TODO: Refer to https://github.com/stevearc/dressing.nvim/blob/8b7ae53d7f04f33be3439a441db8071c96092d19/tests/manual/completion.lua
    local function conditional_breakpoint_callback()
      function _G.lsp_symbols_fields(argLead, cmdLine, cursorPos)
        vim.lsp.buf.document_symbol({
          on_list = function(args)
            vim.notify(vim.inspect(args.items[1]))
            return args.items
          end
        })
      end

      vim.ui.input({
        prompt = 'Breakpoint condition: ',
        completion = 'customlist,v:lua.lsp_symbols_fields',
      }, function(result)
        if result then
          vim.notify("Result: " .. result)
        else
          vim.notify("Input cancelled")
        end
      end)
    end
    vim.keymap.set('n', '<leader>dB', conditional_breakpoint_callback, { desc = 'Conditional Breakpoint' })

    if pcall(require, 'which-key') then
      require('which-key').register({
        d = { name = '[D]AP', _ = 'which_key_ignore' },
      }, { prefix = '<leader>' })
    end
  end,
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      config = function()
        require('dapui').setup()
        vim.keymap.set('n', '<leader>du', require('dapui').toggle, { desc = 'Toggle Debug UI' })
      end,
    }
  },
}
