require("utils")

-- gm -> add mark
map("n", "gm", "m")

-- Go to tab by number
map("n", "<leader>1", "1gt")
map("n", "<leader>2", "2gt")
map("n", "<leader>3", "3gt")
map("n", "<leader>4", "4gt")
map("n", "<leader>5", "5gt")
map("n", "<leader>6", "6gt")
map("n", "<leader>7", "7gt")
map("n", "<leader>8", "8gt")
map("n", "<leader>9", "9gt")
map("n", "<leader>0", ":tablast<CR>")

-- Delete everything with <C-l>
map("n", "<C-l>", ":1,$d<CR>i")
map("i", "<C-l>", "<Esc>:1,$d<CR>i")

-- Yank everything with <C-y>
map("n", "<C-y>", ":1,$y<CR>")
map("i", "<C-y>", "<Esc>:1,$y<CR>i")

-- Force write
map("c", "w!!", "execute 'silent! write !sudo tee % >/dev/null' <bar> edit!")

-- Write on <leader>w
map("n", "<leader>w", ":update<CR>")

-- Moving lines
map("n", "<C-J>", ":move .+1<CR>==")
map("n", "<C-K>", ":move .-2<CR>==")
map("i", "<C-J>", "<Esc>:move .+1<CR>==gi")
map("i", "<C-K>", "<Esc>:move .-2<CR>==gi")
map("v", "<C-J>", ":move '>+1<CR>gv=gv")
map("v", "<C-K>", ":move '<-2<CR>gv=gv")
