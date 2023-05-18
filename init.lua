for _, name in ipairs({
  'globals',
  'options',
  'autocommands',
}) do
  require('b.' .. name)
end
