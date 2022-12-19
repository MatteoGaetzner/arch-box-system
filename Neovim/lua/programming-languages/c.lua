require("utils")

-- Make *.h files C header files by default
g.c_syntax_for_h = 1

local c_augroup = vim.api.nvim_create_augroup('c', {clear = true})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'c',
    group = c_augroup,
    callback = function()
            map("n", "<C-c>", ":!gcc -std=c11 % -Wall -g -o %.out && ./%.out<CR>")
            map("n", "<C-s>", ":!make && gdb -tui ./bin/%.out<CR>")
            map("n", "<CR>", ":!make && ./bin/%.out<CR>")
        end
})
