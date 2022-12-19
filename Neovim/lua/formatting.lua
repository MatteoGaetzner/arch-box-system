require("utils")

function coc_format()
    if vim.fn.exists("CocActionAsync") then
        vim.fn.CocActionAsync('format')
    else
        print("Couldn't find the function `CocActionAsync()`.")
    end
end

function prettier_format()
    if vim.fn.exists("Prettier") then
        vim.fn.Prettier()
    else
        print("Couldn't find the function `Prettier()`.")
    end
end

function autoformat_format()
    if vim.fn.exists("Autoformat") then
        cmd(":Autoformat")
    else
        print("Couldn't find the function `Autoformat()`.")
    end
end

local format_augroup = vim.api.nvim_create_augroup('format', {clear = true})

coc_format_extensions = create_set({"h", "c", "hpp", "cpp"})
prettier_format_extensions = create_set({"html", "javascript", "vue", "css"})
autoformat_format_extensions = create_set({"bash", "sh", "zsh", "tex"})

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    group = format_augroup,
    callback = function()
            ft = vim.bo.filetype
            if prettier_format_extensions[ft] then
                prettier_format()
            elseif coc_format_extensions[ft] then
                coc_format()
            elseif autoformat_format_extensions[ft] then
                autoformat_format()
            end
        end
})
