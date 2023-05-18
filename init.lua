for _, name in ipairs({
  'globals',
  'options',
  'autocommands',
  'mappings',
}) do
  require('b.' .. name)
end
