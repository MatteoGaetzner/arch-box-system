-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    ---@cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({ lhs, mode = mode }).id] then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

-- Moving lines
map("n", "<C-J>", ":move .+1<CR>==", { desc = "move line up" })
map("n", "<C-K>", ":move .-2<CR>==", { desc = "move line down" })
map("i", "<C-J>", "<Esc>:move .+1<CR>==gi", { desc = "move line up" })
map("i", "<C-K>", "<Esc>:move .-2<CR>==gi", { desc = "move line down" })
map("v", "<C-J>", ":move '>+1<CR>gv=gv", { desc = "move line up" })
map("v", "<C-K>", ":move '<-2<CR>gv=gv", { desc = "move line down" })

-- Close tab
map("n", "<leader>d", "<cmd>bd<cr>", { desc = "Close Tab" })

-- Go to tab by number
map("n", "<leader>1", "1gt", { desc = "go to tab 1" })
map("n", "<leader>2", "2gt", { desc = "go to tab 2" })
map("n", "<leader>3", "3gt", { desc = "go to tab 3" })
map("n", "<leader>4", "4gt", { desc = "go to tab 4" })
map("n", "<leader>5", "5gt", { desc = "go to tab 5" })
map("n", "<leader>6", "6gt", { desc = "go to tab 6" })
map("n", "<leader>7", "7gt", { desc = "go to tab 7" })
map("n", "<leader>8", "8gt", { desc = "go to tab 8" })
map("n", "<leader>9", "9gt", { desc = "go to tab 9" })
map("n", "<leader>0", ":tablast<CR>")

-- Cut movements
map("n", "m", "d", { desc = "normal mode cut" })
map("x", "m", "d", { desc = "visual mode cut" })
map("n", "mm", "dd", { desc = "normal mode cut line" })
map("n", "M", "D", { desc = "visual mode cut" })

-- Replace text with contents of register (visual mode)
map("v", "gr", '"_dP', { noremap = true, silent = true, desc = "replace with contents of register" })

-- Latex
map("n", "<leader>lf", ":lua FormatLatex()<CR>", { desc = "format file using latexindent" })

map("n", "<leader>cc", ":VimtexCompile<cr>", { desc = "compile LaTeX document" })
map("x", "<leader>cc", ":VimtexCompile<cr>", { desc = "compile LaTeX document" })
