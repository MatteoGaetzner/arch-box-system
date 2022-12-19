local clipboard_augroup = vim.api.nvim_create_augroup('clipboard', {clear = true})

vim.api.nvim_create_autocmd('VimLeave', {
  pattern = '*',
  group = clipboard_augroup,
  command = 'call system("xsel -ib", getreg(\'+\'))'
})
