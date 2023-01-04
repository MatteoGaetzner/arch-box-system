require("utils")

local bash_augroup = vim.api.nvim_create_augroup('bash', {clear = true})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'sh,bash',
    group = bash_augroup,
    callback = function()
            map("n", "<CR>", ":!bash<CR>")
        end
})
