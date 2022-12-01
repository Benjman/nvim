local present, treesitter = pcall(require, 'nvim-treesitter.configs')
if not present then return end

treesitter.setup {
  ensure_installed = 'all',
  highlight = {
    enable = true,
  },
  matchup = {
    enable = true,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      -- goto_node = '<cr>',
      show_help = '?',
    },
  },
  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',

      --[[ init_selection = 'zi',
			node_incremental = 'zi',
			scope_incremental = 'zo',
			node_decremental = 'zd', ]]
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      -- The keymaps are defined in the configuration table, no way to get our Mapper in there !
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',

        -- xml attribute
        ['ax'] = '@attribute.outer',
        ['ix'] = '@attribute.inner',

        -- json
        ['ak'] = '@key.outer',
        ['ik'] = '@key.inner',
        ['av'] = '@value.outer',
        ['iv'] = '@value.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>fpp'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>fpP'] = '@parameter.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
    },
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  },
}
