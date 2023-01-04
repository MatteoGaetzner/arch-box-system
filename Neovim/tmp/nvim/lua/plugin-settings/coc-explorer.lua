require('utils')

g.coc_explorer_global_presets = {
    ["floating"] = {
        ["position"] = "floating",
        ["quit-on-open"] = true
    }
}

-- Use preset argument to open it
map('n', '<leader>ee', '<Cmd>CocCommand explorer<CR>')  
map('n', '<leader>ef', '<Cmd>CocCommand explorer --preset floating<CR>')

