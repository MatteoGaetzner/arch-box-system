require("utils")

local cpp_augroup = vim.api.nvim_create_augroup('cpp', {clear = true})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'cpp',
    group = cpp_augroup,
    callback = function()
            map("n", "<C-c>", ":!g++ -std=c++11 % -Wall -g -o %.out && ./%.out<CR>")
            map("n", "<C-s>", ":!make && gdb -tui ./bin/main.out<CR>")
            map("n", "<CR>", ":!make && ./bin/main.out<CR>")
        end
})
