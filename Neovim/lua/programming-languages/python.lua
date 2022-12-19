require("utils")

g.asyncrun_open = 10

local python_augroup = vim.api.nvim_create_augroup('python', {clear = true})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    group = python_augroup,
    callback = function()
            map("n", "<CR>", ":call CocAction('runCommand', 'pyright.organizeimports')", { silent = true })
        end
})

