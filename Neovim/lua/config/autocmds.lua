-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
    return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

function FormatLatex()
    -- Step 1: Read the contents of the buffer into a variable
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local content = table.concat(lines, "\n")

    -- Step 2: Run latexindent on the contents of the buffer
    local cmd = "latexindent --cruft='/tmp/' -y=defaultIndent:'  '"
    local output = vim.fn.system(cmd, content)
    local success = vim.v.shell_error == 0

    if not success then
        vim.api.nvim_echo({ { "Error: Failed to format LaTeX file using latexindent.", "ErrorMsg" } }, true, {})
        vim.api.nvim_echo({ { "Output: " .. output, "ErrorMsg" } }, true, {})
        return
    end

    -- Step 3: Replace the buffer contents with the formatted output
    local formatted_lines = vim.split(output, "\n", true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted_lines)

    vim.api.nvim_echo({ { "LaTeX file formatted using latexindent.", "Normal" } }, true, {})
end

-- Create an autocmd for formatting LaTeX files on save
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup("latex"),
    pattern = { "*.latex", "*.tex" },
    callback = function()
        FormatLatex()
    end,
})
