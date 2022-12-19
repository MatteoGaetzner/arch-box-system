require("utils")

local i3_augroup = vim.api.nvim_create_augroup('i3', {clear = true})

vim.api.nvim_create_autocmd('BufNewFile,BufRead', {
    pattern = os.getenv("HOME") .. "/.config/i3/config",
    group = i3_augroup,
    callback = function()
            vim.bo.filetype = "i3config"
        end
})

