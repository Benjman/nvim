local present, bqf = pcall(require, 'bqf')
if not present then return end

bqf.setup {
  auto_resize_height = false,
  preview = {
    auto_preview = false,
  },
}
