local windows_augroup = vim.api.nvim_create_augroup('windows', {clear = true})

vim.api.nvim_create_autocmd('VimResized', {
  pattern = '*',
  group = windows_augroup,
  command = 'if &equalalways | wincmd = | endif'
})
