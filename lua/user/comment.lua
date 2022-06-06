local comment_ok, comment = pcall(require, 'Comment')
if comment_ok then
  comment.setup {
    ---Add a space b/w comment and the line
    ---@type boolean|fun():boolean
    padding = true,

    ---Whether the cursor should stay at its position
    ---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
    ---@type boolean
    sticky = true,

    ---Lines to be ignored while comment/uncomment.
    ---Could be a regex string or a function that returns a regex string.
    ---Example: Use '^$' to ignore empty lines
    ---@type string|fun():string
    ignore = nil,

    ---LHS of toggle mappings in NORMAL + VISUAL mode
    ---@type table
    toggler = {
      ---Line-comment toggle keymap
      line = 'gcc',
      ---Block-comment toggle keymap
      block = 'gbc',
    },

    ---LHS of operator-pending mappings in NORMAL + VISUAL mode
    ---@type table
    opleader = {
      ---Line-comment keymap
      line = 'gc',
      ---Block-comment keymap
      block = 'gb',
    },

    ---LHS of extra mappings
    ---@type table
    extra = {
      ---Add comment on the line above
      above = 'gcO',
      ---Add comment on the line below
      below = 'gco',
      ---Add comment at the end of line
      eol = 'gcA',
    },

    ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
    ---NOTE: If `mappings = false` then the plugin won't create any mappings
    ---@type boolean|table
    mappings = {
      ---Operator-pending mapping
      ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
      ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
      basic = true,
      ---Extra mapping
      ---Includes `gco`, `gcO`, `gcA`
      extra = true,
      ---Extended mapping
      ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
      extended = false,
    },

    ---Pre-hook, called before commenting the line
    ---@type fun(ctx: CommentCtx):string
    pre_hook = nil,

    ---Post-hook, called after commenting is done
    ---@type fun(ctx: CommentCtx)
    post_hook = nil,
  }
end


local status_ok, todo_comments = pcall(require, 'todo-comments')
if status_ok then
  local icons = require 'user.icons'
  local error_red = '#F44747'
  local warning_orange = '#ff8800'
  local info_yellow = '#FFCC66'
  local hint_blue = '#4FC1FF'
  local perf_purple = '#7C3AED'
  -- local note_green = '#10B981'

  todo_comments.setup {
    signs = true, -- show icons in the signs column
    sign_priority = 8, -- sign priority
    -- keywords recognized as todo comments
    keywords = {
      FIX    = { icon = icons.ui.Bug,              color = error_red,      alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, },
      DELETE = { icon = icons.ui.Check,            color = hint_blue,      alt = { 'DELETE', 'DELETEME' } },
      TODO   = { icon = icons.ui.Check,            color = hint_blue,      alt = { 'TIP' } },
      HACK   = { icon = icons.ui.Fire,             color = warning_orange },
      WARN   = { icon = icons.diagnostics.Warning, color = warning_orange },
      PERF   = { icon = icons.ui.Dashboard,        color = perf_purple },
      NOTE   = { icon = icons.ui.Note,             color = info_yellow,    alt = { 'INFO' } },
    },
    -- merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
      before = '', -- 'fg' or 'bg' or empty
      -- keyword = 'wide', -- 'fg', 'bg', 'wide' or empty. (wide is the same as bg, but will also highlight surrounding characters)
      keyword = 'fg', -- 'fg', 'bg', 'wide' or empty. (wide is the same as bg, but will also highlight surrounding characters)
      after = 'fg', -- 'fg' or 'bg' or empty
      pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
      comments_only = true, -- uses treesitter to match keywords in comments only
      max_line_len = 400, -- ignore lines longer than this
      exclude = {}, -- list of file types to exclude highlighting
    },
    -- list of named colors where we try to extract the guifg from the
    -- list of hilight groups or use the hex color if hl not found as a fallback
    -- colors = {
    --   error = { 'LspDiagnosticsDefaultError', 'ErrorMsg', '#DC2626' },
    --   warning = { 'LspDiagnosticsDefaultWarning', 'WarningMsg', '#FBBF24' },
    --   info = { 'LspDiagnosticsDefaultInformation', '#2563EB' },
    --   hint = { 'LspDiagnosticsDefaultHint', '#10B981' },
    --   default = { 'Identifier', '#7C3AED' },
    -- },
    search = {
      command = 'rg',
      args = {
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
      },
      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder
      pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    },
  }
end
