require("utils")

g.UltiSnipsSnippetsDir         = os.getenv("HOME")..'/.config/nvim/ultisnips/'
g.UltiSnipsEditSplit           = "tabdo"
g.UltiSnipsExpandTrigger       = "<s-tab>"
g.ulti_expand_or_jump_res      = 0
g.UltiSnipsJumpForwardTrigger  = "<nop>"
g.UltiSnipsJumpBackwardTrigger = "<nop>"

map("n", "<leader>u", "<CMD>UltiSnipsEdit<CR>", { noremap = true })
