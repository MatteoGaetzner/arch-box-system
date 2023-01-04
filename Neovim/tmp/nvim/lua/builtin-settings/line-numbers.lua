local linenumbers_augroup = vim.api.nvim_create_augroup('linenumbers', {clear = true})

vim.api.nvim_create_autocmd('BufEnter,FocusGained,InsertLeave', {
  pattern = '*',
  group = linenumbers_augroup,
  command = 'set relativenumber'
})

vim.api.nvim_create_autocmd('BufLeave,FocusLost,InsertEnter', {
  pattern = '*',
  group = linenumbers_augroup,
  command = 'set norelativenumber'
})
