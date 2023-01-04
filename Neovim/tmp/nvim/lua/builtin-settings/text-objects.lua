local _chars = { '_', '.', ':', ',', ';', '|', '/', '\\', '*', '+', '%', '`', '?' }
for _,char in ipairs(_chars) do
    for _,mode in ipairs({ 'x', 'o' }) do
        vim.api.nvim_set_keymap(
            mode, 
            "i" .. char, 
            string.format(':<C-u>normal! T%svt%s<CR>', char, char, char), 
            { noremap = true, silent = true }
        )
        vim.api.nvim_set_keymap(
            mode, 
            "a" .. char, 
            string.format(':<C-u>normal! F%svf%s<CR>', char, char, char), 
            { noremap = true, silent = true }
        )
    end
end
