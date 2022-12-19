require("utils")

local docker_augroup = vim.api.nvim_create_augroup('docker', {clear = true})

vim.api.nvim_create_autocmd('BufNewFile,BufRead', {
    pattern = 'Dockerfile*',
    group = docker_augroup,
    callback = function()
            vim.bo.filetype = "dockerfile"
        end
})
