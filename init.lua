for _, name in ipairs({
  'globals',
  'options',
  'autocommands',
  'mappings',
  'plugins',
  'colorscheme',
}) do
  require('b.' .. name)
end
