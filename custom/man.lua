for _, name in ipairs({
  'globals',
  'options',
  'autocommands',
  'mappings',
  'colorscheme',
}) do
  require('b.' .. name)
end
