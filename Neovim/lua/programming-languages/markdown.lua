require("utils")

g.mkdp_auto_close = 1
g.mkdp_echo_preview_url = 0
g.mkdp_browser = 'firefox'
g.mkdp_theme = 'dark'
g.NVIM_MKDP_LOG_FILE = '/tmp/mkdp-log.log'

local markdown_augroup = vim.api.nvim_create_augroup('markdown', { clear = true })

-- Messes with latex: 
-- vim.api.nvim_create_autocmd('FileType', {
--     pattern = 'markdown',
--     group = markdown_augroup,
--     command = "call CocActionAsync('runCommand', 'markdownlint.fixAll')"
-- })

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    group = markdown_augroup,
    callback = function()
        fp = vim.api.nvim_buf_get_name(0)
        map("n", "<CR>", ":w | AsyncRun pandoc_beamer_compile '" .. fp .."'<CR>")
    end
})
