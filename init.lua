for _, name in ipairs({
  'globals',
  'options',
}) do
  require('b.' .. name)
end
