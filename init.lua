for _, name in ipairs({
  'globals',
  'options',
  'autocommands',
  'mappings',
  'plugins',
}) do
  require('b.' .. name)
end
