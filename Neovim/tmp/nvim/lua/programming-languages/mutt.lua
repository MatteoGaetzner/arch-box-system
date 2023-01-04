require("utils")

local mutt_augroup = vim.api.nvim_create_augroup('mutt', {clear = true})

vim.api.nvim_create_autocmd('BufReadPost', {
    pattern = '*.muttrc',
    group = mutt_augroup,
    callback = function()
            vim.bo.filetype = "neomuttrc"
        end
})

vim.api.nvim_create_autocmd('BufRead,BufNewFile', {
    pattern = '*.mutt-*',
    group = mutt_augroup,
    callback = function()
            vim.bo.filetype = "mail"
        end
})
